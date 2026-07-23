import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// Number stepper styled to match `CkgocTextField`.
class CkgocNumberStepper extends StatelessWidget {
  const CkgocNumberStepper({
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

  bool get _canDecrement {
    if (!enabled || onChanged == null) return false;
    if (value == null) return true;
    if (min == null) return true;
    return value! - step >= min!;
  }

  bool get _canIncrement {
    if (!enabled || onChanged == null) return false;
    if (value == null) return true;
    if (max == null) return true;
    return value! + step <= max!;
  }

  void _updateValue(int delta) {
    if (onChanged == null || !enabled) return;
    final baseValue = value ?? min ?? 0;
    var nextValue = baseValue + delta;
    if (min != null && nextValue < min!) nextValue = min!;
    if (max != null && nextValue > max!) nextValue = max!;
    if (nextValue != value) onChanged!(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final hasError = errorText != null;
    final hasSuccess = successText != null && !hasError;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
          borderRadius: BorderRadius.circular(radius.base),
        );

    final decoration = borderless
        ? InputDecoration(
            hintText: hint,
            hintStyle: typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            helperText: hasSuccess ? successText : helperText,
            errorText: errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: false,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
        : InputDecoration(
            hintText: hint,
            hintStyle: typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            helperText: hasSuccess ? successText : helperText,
            helperStyle: typography.textSm.copyWith(
              color: hasSuccess ? colors.success : colors.onSurfaceVariant,
            ),
            errorText: errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: true,
            fillColor: enabled ? colors.surface : colors.muted,
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

    final dividerColor = borderless ? Colors.transparent : colors.outline;
    final valueText = value?.toString() ?? hint ?? '-';
    final valueColor = enabled
        ? (value == null ? colors.onSurfaceVariant : colors.onSurface)
        : colors.onSurfaceVariant;

    final field = InputDecorator(
      decoration: decoration,
      isEmpty: value == null,
      child: Row(
        children: [
          _StepperButton(
            icon: LucideIcons.minus,
            onTap: _canDecrement ? () => _updateValue(-step) : null,
          ),
          SizedBox(width: spacing.sm),
          Container(width: 1, height: spacing.lg, color: dividerColor),
          SizedBox(width: spacing.sm),
          Expanded(
            child: Text(
              valueText,
              textAlign: TextAlign.center,
              style: typography.textMd.copyWith(color: valueColor),
            ),
          ),
          SizedBox(width: spacing.sm),
          Container(width: 1, height: spacing.lg, color: dividerColor),
          SizedBox(width: spacing.sm),
          _StepperButton(
            icon: LucideIcons.plus,
            onTap: _canIncrement ? () => _updateValue(step) : null,
          ),
        ],
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
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
    final theme = context.ckgocTheme;
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
