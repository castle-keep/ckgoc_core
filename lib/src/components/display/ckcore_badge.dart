import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Badge component for displaying labels, counts, and status indicators.
///
/// The default appearance is primary. Use named constructors for semantic variants:
/// ```dart
/// CKBadge(label: 'Featured')              // primary (default)
/// CKBadge.success(label: 'Approved')
/// CKBadge.warning(label: 'Pending')
/// CKBadge.error(label: 'Failed')
/// CKBadge.count(count: 5)
/// ```
class CKBadge extends StatelessWidget {
  /// Primary badge (default, recommended appearance).
  const CKBadge({
    required this.label,
    this.variant = BadgeVariant.primary,
    this.count,
    this.maxCount = 99,
    super.key,
  });

  /// Success badge variant (positive, approved).
  const CKBadge.success({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.success;

  /// Warning badge variant (caution, pending).
  const CKBadge.warning({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.warning;

  /// Error badge variant (critical, failed).
  const CKBadge.error({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.error;

  /// Info badge variant (informational).
  const CKBadge.info({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.info;

  /// Draft badge variant (work in progress).
  const CKBadge.draft({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.draft;

  /// Live badge variant (currently active).
  const CKBadge.live({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.live;

  /// New badge variant (new feature/item).
  const CKBadge.newBadge({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.newBadge;

  /// Beta badge variant (beta program).
  const CKBadge.beta({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.beta;

  /// Pro badge variant (premium feature).
  const CKBadge.pro({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.pro;

  /// Outline badge variant (bordered, minimal).
  const CKBadge.outline({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.outline;

  /// Outline success badge variant.
  const CKBadge.outlineSuccess({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.outlineSuccess;

  /// Outline error badge variant.
  const CKBadge.outlineError({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.outlineError;

  /// Online status badge.
  const CKBadge.online({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.online;

  /// Away status badge.
  const CKBadge.away({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.away;

  /// Busy status badge.
  const CKBadge.busy({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.busy;

  /// Offline status badge.
  const CKBadge.offline({
    required this.label,
    this.count,
    this.maxCount = 99,
    super.key,
  }) : variant = BadgeVariant.offline;

  /// Count badge variant (error color, numeric display).
  ///
  /// Example:
  /// ```dart
  /// CKBadge.count(count: 5, maxCount: 99)
  /// ```
  const CKBadge.count({
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
    final theme = context.ckcoreTheme;
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
      BadgeVariant.draft => (
        colors.surfaceVariant,
        colors.onSurfaceVariant,
        colors.outlineVariant,
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

/// Deprecated: Use [CKBadge] instead.
@Deprecated('Use CKBadge instead')
typedef ckcorebadge = CKBadge;
