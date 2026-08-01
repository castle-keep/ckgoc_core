import 'package:ckcoreui/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Number stepper styled to match `CKTextField`.
class CKNumberStepper extends StatefulWidget {
  const CKNumberStepper({
    required this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.min,
    this.max,
    this.step = 1,
    this.enabled = true,
    this.borderless = false,
    super.key,
  });

  final int? value;
  final ValueChanged<int>? onChanged;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final int? min;
  final int? max;
  final int step;
  final bool enabled;
  final bool borderless;

  @override
  State<CKNumberStepper> createState() => _CKNumberStepperState();
}

class _CKNumberStepperState extends State<CKNumberStepper> {
  late TextEditingController _controller;
  bool _programmaticChange = false;
  bool _showRangeError = false;
  Timer? _errorTimer;

  bool get _canDecrement {
    if (!widget.enabled || widget.onChanged == null) return false;
    if (widget.value == null) return true;
    if (widget.min == null) return true;
    return widget.value! - widget.step >= widget.min!;
  }

  bool get _canIncrement {
    if (!widget.enabled || widget.onChanged == null) return false;
    if (widget.value == null) return true;
    if (widget.max == null) return true;
    return widget.value! + widget.step <= widget.max!;
  }

  void _updateValue(int delta) {
    if (widget.onChanged == null || !widget.enabled) return;
    final baseValue = widget.value ?? widget.min ?? 0;
    var nextValue = baseValue + delta;
    if (widget.min != null && nextValue < widget.min!) nextValue = widget.min!;
    if (widget.max != null && nextValue > widget.max!) nextValue = widget.max!;
    if (nextValue != widget.value) widget.onChanged!(nextValue);
  }

  void _onControllerChanged() {
    if (_programmaticChange) return;
    final s = _controller.text;
    final parsed = int.tryParse(s);
    if (parsed == null) return;
    var next = parsed;
    var clamped = next;
    if (widget.min != null && clamped < widget.min!) clamped = widget.min!;
    if (widget.max != null && clamped > widget.max!) clamped = widget.max!;

    if (clamped != next) {
      final newText = clamped.toString();
      setState(() {
        _showRangeError = true;
      });
      _errorTimer?.cancel();
      _errorTimer = Timer(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() => _showRangeError = false);
      });

      _programmaticChange = true;
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
      _programmaticChange = false;
      next = clamped;
    }

    if (next != widget.value) widget.onChanged?.call(next);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value?.toString() ?? widget.hint ?? '',
    );
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant CKNumberStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.value?.toString() ?? widget.hint ?? '';
    if (newText != _controller.text) {
      _programmaticChange = true;
      _controller.text = newText;
      _programmaticChange = false;
    }
  }

  @override
  void dispose() {
    _errorTimer?.cancel();
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final hasError = widget.errorText != null;
    final hasSuccess = widget.successText != null && !hasError;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
          borderRadius: BorderRadius.circular(radius.base),
        );

    final decoration = widget.borderless
        ? InputDecoration(
            hintText: widget.hint,
            hintStyle: typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            helperText: hasSuccess ? widget.successText : widget.helperText,
            errorText: widget.errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: false,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
        : InputDecoration(
            hintText: widget.hint,
            hintStyle: typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            helperText: hasSuccess ? widget.successText : widget.helperText,
            helperStyle: typography.textSm.copyWith(
              color: hasSuccess ? colors.success : colors.onSurfaceVariant,
            ),
            errorText: widget.errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: true,
            fillColor: widget.enabled ? colors.surface : colors.muted,
            contentPadding: EdgeInsets.symmetric(
              horizontal: spacing.s12,
              vertical: spacing.sm,
            ),
            enabledBorder: border(hasSuccess ? colors.success : colors.outline),
            focusedBorder: border(colors.primary, width: spacing.xxs),
            errorBorder: border(colors.error),
            focusedErrorBorder: border(colors.error, width: spacing.xxs),
            disabledBorder: border(colors.outline),
          );

    final dividerColor = widget.borderless
        ? Colors.transparent
        : colors.outline;

    final allowNegative = widget.min != null && widget.min! < 0;
    final regex = allowNegative ? RegExp(r'^-?\d*$') : RegExp(r'^\d*$');
    final numericFormatter = TextInputFormatter.withFunction((
      oldValue,
      newValue,
    ) {
      return regex.hasMatch(newValue.text) ? newValue : oldValue;
    });

    final field = AnimatedContainer(
      duration: theme.motion.fast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.base),
        boxShadow: _showRangeError
            ? [
                BoxShadow(
                  color: colors.error.withValues(alpha: 0.2),
                  spreadRadius: 3,
                  blurRadius: 0,
                ),
              ]
            : const [],
      ),
      child: InputDecorator(
        decoration: decoration,
        isEmpty: widget.value == null,
        child: Row(
          children: [
            _StepperButton(
              icon: LucideIcons.minus,
              onTap: _canDecrement ? () => _updateValue(-widget.step) : null,
            ),
            SizedBox(width: spacing.sm),
            Container(width: 1, height: spacing.lg, color: dividerColor),
            SizedBox(width: spacing.sm),
            Expanded(
              child: CKTextField(
                controller: _controller,
                borderless: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                readOnly: !widget.enabled,
                inputFormatters: [numericFormatter],
              ),
            ),
            SizedBox(width: spacing.sm),
            Container(width: 1, height: spacing.lg, color: dividerColor),
            SizedBox(width: spacing.sm),
            _StepperButton(
              icon: LucideIcons.plus,
              onTap: _canIncrement ? () => _updateValue(widget.step) : null,
            ),
          ],
        ),
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label!,
          style: typography.labelMd.copyWith(color: colors.onSurface),
        ),
        SizedBox(height: spacing.xs),
        field,
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(theme.radius.sm),
      child: SizedBox(
        width: spacing.lg,
        height: spacing.lg,
        child: Icon(
          icon,
          size: spacing.md,
          color: onTap == null ? colors.onSurfaceVariant : colors.onSurface,
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKNumberStepper] instead.
@Deprecated('Use CKNumberStepper instead')
typedef ckcorenumberStepper = CKNumberStepper;
