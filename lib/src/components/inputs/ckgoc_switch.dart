import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocSwitch extends StatelessWidget {
  const CkgocSwitch({
    required this.value,
    this.onChanged,
    this.label,
    this.variant,
    this.color,
    super.key,
  });
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final SwitchVariant? variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
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
