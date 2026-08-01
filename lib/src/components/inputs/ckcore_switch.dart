import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Switch control with label support and optional variant coloring.
///
/// The default appearance is neutral. Use named constructors for semantic variants:
/// ```dart
/// CKSwitch(value: true, onChanged: (v) {})    // neutral (default)
/// CKSwitch.success(value: true, onChanged: (v) {})  // green
/// CKSwitch.error(value: false, onChanged: (v) {})   // red
/// ```
class CKSwitch extends StatelessWidget {
  /// Neutral switch (default, standard appearance).
  const CKSwitch({
    required this.value,
    this.onChanged,
    this.label,
    this.variant,
    this.color,
    super.key,
  });

  /// Success variant switch (green when enabled).
  const CKSwitch.success({
    required this.value,
    this.onChanged,
    this.label,
    this.color,
    super.key,
  }) : variant = SwitchVariant.success;

  /// Error variant switch (red when enabled).
  const CKSwitch.error({
    required this.value,
    this.onChanged,
    this.label,
    this.color,
    super.key,
  }) : variant = SwitchVariant.error;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final SwitchVariant? variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final typography = theme.typography;
    final opacity = theme.opacity;
    final spacing = theme.spacing;

    final isDisabled = onChanged == null;

    final activeColor =
        color ??
        switch (variant) {
          SwitchVariant.success => colors.success,
          SwitchVariant.error => colors.error,
          null => colors.primary,
        };

    final sw = AnimatedOpacity(
      duration: theme.motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: activeColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: colors.neutral,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );

    if (label == null) return sw;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        sw,
        SizedBox(width: spacing.sm),
        Text(
          label!,
          style: typography.labelMd.copyWith(
            color: isDisabled ? colors.onSurfaceVariant : colors.onSurface,
          ),
        ),
      ],
    );
  }
}

/// Deprecated: Use [CKSwitch] instead.
@Deprecated('Use CKSwitch instead')
typedef ckcoreswitch = CKSwitch;
