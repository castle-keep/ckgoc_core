import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Alert component for displaying messages with semantic color variants.
///
/// The default appearance is info (blue, informational). Use named constructors
/// for other semantic variants:
/// ```dart
/// CKAlert(message: 'Please review')              // info (default)
/// CKAlert.success(message: 'Saved!')
/// CKAlert.warning(message: 'Double-check this')
/// CKAlert.error(message: 'Something went wrong')
/// ```
class CKAlert extends StatelessWidget {
  /// Info alert (default, informational appearance).
  const CKAlert({
    required this.message,
    this.title,
    this.variant = AlertVariant.info,
    this.onDismiss,
    super.key,
  });

  /// Success alert variant (green, positive).
  const CKAlert.success({
    required this.message,
    this.title,
    this.onDismiss,
    super.key,
  }) : variant = AlertVariant.success;

  /// Warning alert variant (orange, caution).
  const CKAlert.warning({
    required this.message,
    this.title,
    this.onDismiss,
    super.key,
  }) : variant = AlertVariant.warning;

  /// Error alert variant (red, critical).
  const CKAlert.error({
    required this.message,
    this.title,
    this.onDismiss,
    super.key,
  }) : variant = AlertVariant.error;
  final String message;
  final String? title;
  final AlertVariant variant;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final (bg, fg, border, icon) = switch (variant) {
      AlertVariant.info => (
        colors.infoContainer,
        colors.onInfoContainer,
        colors.info,
        LucideIcons.info,
      ),
      AlertVariant.success => (
        colors.successContainer,
        colors.onSuccessContainer,
        colors.success,
        LucideIcons.checkCircle,
      ),
      AlertVariant.warning => (
        colors.warningContainer,
        colors.onWarningContainer,
        colors.warning,
        LucideIcons.alertTriangle,
      ),
      AlertVariant.error => (
        colors.errorContainer,
        colors.onErrorContainer,
        colors.error,
        LucideIcons.xCircle,
      ),
    };

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius.lg),
          border: Border.all(color: border),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.s12,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              if (onDismiss != null) ...[
                SizedBox(width: spacing.sm),
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(LucideIcons.x, size: spacing.md, color: fg),
                ),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: spacing.lg, color: fg),
                  SizedBox(width: spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: typography.labelMd.copyWith(color: fg),
                          ),
                        if (title != null) SizedBox(height: spacing.xxs),
                        Text(
                          message,
                          style: typography.textSm.copyWith(color: fg),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKAlert] instead.
@Deprecated('Use CKAlert instead')
typedef ckcorealert = CKAlert;
