import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocProgressBar extends StatelessWidget {
  const CkgocProgressBar({
    this.value,
    this.maxValue = 1.0,
    this.variant = ProgressVariant.primary,
    this.showValue = false,
    super.key,
  });
  final double? value;
  final double maxValue;
  final ProgressVariant variant;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final fillColor = switch (variant) {
      ProgressVariant.primary => colors.primary,
      ProgressVariant.success => colors.success,
      ProgressVariant.warning => colors.warning,
      ProgressVariant.error => colors.error,
      ProgressVariant.indeterminate => colors.primary,
    };

    final normalized = variant == ProgressVariant.indeterminate
        ? null
        : value == null
        ? null
        : (value! / maxValue).clamp(0.0, 1.0);

    final bar = ClipRRect(
      borderRadius: BorderRadius.circular(radius.full),
      child: LinearProgressIndicator(
        value: normalized,
        backgroundColor: colors.surfaceVariant,
        valueColor: AlwaysStoppedAnimation(fillColor),
        minHeight: spacing.sm,
      ),
    );

    if (!showValue ||
        variant == ProgressVariant.indeterminate ||
        value == null) {
      return bar;
    }

    final pct = ((value! / maxValue) * 100).clamp(0.0, 100.0).round();
    return Row(
      children: [
        Expanded(child: bar),
        SizedBox(width: spacing.sm),
        Text(
          '$pct%',
          style: typography.textSm.copyWith(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class CkgocSlider extends StatelessWidget {
  const CkgocSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.showValue = false,
    this.color,
    super.key,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final bool showValue;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final opacity = theme.opacity;
    final activeColor = color ?? colors.primary;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor,
        inactiveTrackColor: colors.surfaceVariant,
        thumbColor: activeColor,
        overlayColor: activeColor.withValues(alpha: opacity.subtle),
        valueIndicatorColor: activeColor,
        valueIndicatorTextStyle: typography.textSm.copyWith(
          color: colors.onPrimary,
        ),
        showValueIndicator: showValue
            ? ShowValueIndicator.onDrag
            : ShowValueIndicator.never,
        trackHeight: spacing.xs,
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        label: value.round().toString(),
      ),
    );
  }
}
