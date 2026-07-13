import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocBadge extends StatelessWidget {
  const CkgocBadge({
    required this.label,
    this.variant = BadgeVariant.defaultFill,
    this.count,
    this.maxCount = 99,
    super.key,
  });

  const CkgocBadge.count({
    required this.count,
    this.maxCount = 99,
    this.variant = BadgeVariant.error,
    super.key,
  }) : label = '';
  final String label;
  final BadgeVariant variant;
  final int? count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;

    final displayLabel = count != null
        ? (count! > maxCount ? '\$maxCount+' : '\$count')
        : label;

    final isStatus =
        variant == BadgeVariant.online ||
        variant == BadgeVariant.away ||
        variant == BadgeVariant.busy ||
        variant == BadgeVariant.offline;

    final isOutline =
        variant == BadgeVariant.outline ||
        variant == BadgeVariant.outlineSuccess ||
        variant == BadgeVariant.outlineError;

    final isPro = variant == BadgeVariant.pro;

    final (bg, fg, border) = _resolveColors(variant, colors);

    final pill = BorderRadius.circular(radius.full);
    final hPad = spacing.sm;
    final vPad = spacing.xxs;

    if (isStatus) {
      final (statusBg, statusFg, statusDot) = _resolveStatusColors(
        variant,
        colors,
      );
      return Container(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        decoration: BoxDecoration(color: statusBg, borderRadius: pill),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: spacing.sm,
              height: spacing.sm,
              decoration: BoxDecoration(
                color: statusDot,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spacing.xs),
            Text(
              displayLabel,
              style: theme.typography.labelSm.copyWith(color: statusFg),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: isPro ? null : (isOutline ? Colors.transparent : bg),
        gradient: isPro
            ? LinearGradient(colors: [colors.tagProStart, colors.tagProEnd])
            : null,
        border: isOutline ? Border.all(color: border) : null,
        borderRadius: pill,
      ),
      child: Text(
        displayLabel,
        style: theme.typography.labelSm.copyWith(color: fg),
      ),
    );
  }

  static (Color bg, Color fg, Color border) _resolveColors(
    BadgeVariant v,
    dynamic colors,
  ) {
    return switch (v) {
      BadgeVariant.defaultFill => (
        colors.inverseSurface,
        colors.onInverseSurface,
        colors.inverseSurface,
      ),
      BadgeVariant.primary => (
        colors.primary,
        colors.onPrimary,
        colors.primary,
      ),
      BadgeVariant.success => (
        colors.successContainer,
        colors.onSuccessContainer,
        colors.success,
      ),
      BadgeVariant.warning => (
        colors.warningContainer,
        colors.onWarningContainer,
        colors.warning,
      ),
      BadgeVariant.error => (
        colors.errorContainer,
        colors.onErrorContainer,
        colors.error,
      ),
      BadgeVariant.info => (
        colors.infoContainer,
        colors.onInfoContainer,
        colors.info,
      ),
      BadgeVariant.live => (colors.tagLive, colors.onTagLive, colors.tagLive),
      BadgeVariant.newBadge => (colors.tagNew, colors.onTagNew, colors.tagNew),
      BadgeVariant.beta => (colors.tagBeta, colors.onTagBeta, colors.tagBeta),
      BadgeVariant.pro => (
        colors.tagProStart,
        colors.onTagPro,
        colors.tagProStart,
      ),
      BadgeVariant.outline => (
        Colors.transparent,
        colors.onSurface,
        colors.outline,
      ),
      BadgeVariant.outlineSuccess => (
        Colors.transparent,
        colors.success,
        colors.success,
      ),
      BadgeVariant.outlineError => (
        Colors.transparent,
        colors.error,
        colors.error,
      ),
      _ => (Colors.transparent, colors.onSurface, colors.outline),
    };
  }

  static (Color bg, Color fg, Color dot) _resolveStatusColors(
    BadgeVariant v,
    dynamic colors,
  ) => switch (v) {
    BadgeVariant.online => (
      colors.successContainer,
      colors.onSuccessContainer,
      colors.success,
    ),
    BadgeVariant.away => (
      colors.warningContainer,
      colors.onWarningContainer,
      colors.warning,
    ),
    BadgeVariant.busy => (
      colors.errorContainer,
      colors.onErrorContainer,
      colors.error,
    ),
    BadgeVariant.offline => (
      colors.surfaceVariant,
      colors.onSurfaceVariant,
      colors.neutral,
    ),
    _ => (colors.surfaceVariant, colors.onSurfaceVariant, colors.neutral),
  };
}
