import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// Text field component with validation, helper and success states.
class CkgocTextField extends StatefulWidget {
  const CkgocTextField({
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.leading,
    this.trailing,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.autoFocus = false,
    this.borderless = false,
    super.key,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final Widget? leading;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final bool autoFocus;

  // When true, renders without the outline borders and without filled background.
  // Useful for inline table cells where a border would clash with the table layout.
  final bool borderless;

  @override
  State<CkgocTextField> createState() => _CompanyTextFieldState();
}

class _CompanyTextFieldState extends State<CkgocTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _validationError;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  void _handleChange(String value) {
    if (widget.validator != null) {
      setState(() {
        _isDirty = true;
        _validationError = widget.validator!(value);
      });
    }
    widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final hasError = widget.errorText != null || _validationError != null;
    final hasSuccess = widget.successText != null && !hasError && _isDirty;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
          borderRadius: BorderRadius.circular(radius.base),
        );

    final suffixIcon =
        widget.trailing ??
        (hasSuccess
            ? Icon(
                LucideIcons.checkCircle,
                color: colors.success,
                size: spacing.md,
              )
            : hasError
            ? Icon(LucideIcons.xCircle, color: colors.error, size: spacing.md)
            : null);

    final decoration = widget.borderless
        ? InputDecoration(
            hintText: widget.hint,
            hintStyle: typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            helperText: hasSuccess ? widget.successText : widget.helperText,
            errorText: widget.errorText ?? _validationError,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            prefixIcon: widget.leading != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: spacing.s12,
                      right: spacing.sm,
                    ),
                    child: widget.leading,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: spacing.s12),
                    child: suffixIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(),
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
            errorText: widget.errorText ?? _validationError,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            prefixIcon: widget.leading != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: spacing.s12,
                      right: spacing.sm,
                    ),
                    child: widget.leading,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: spacing.s12),
                    child: suffixIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(),
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

    // Outer focus ring color derived from theme token (no hardcoded literals)
    final ringColor = hasError
        ? colors.error.withValues(alpha: 0.2)
        : colors.primary.withValues(alpha: 0.2);

    final field = AnimatedContainer(
      duration: theme.motion.fast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.base),
        boxShadow: _isFocused
            ? [BoxShadow(color: ringColor, spreadRadius: 3, blurRadius: 0)]
            : const [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: decoration,
        onChanged: _handleChange,
        onEditingComplete: widget.onEditingComplete,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction,
        autofocus: widget.autoFocus,
        style: typography.textMd.copyWith(
          color: widget.enabled ? colors.onSurface : colors.onSurfaceVariant,
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
