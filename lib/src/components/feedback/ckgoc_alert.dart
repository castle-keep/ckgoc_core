import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocAlert extends StatelessWidget {
  const CkgocAlert({
    required this.message,
    this.title,
    this.variant = AlertVariant.info,
    this.onDismiss,
    super.key,
  });
  final String message;
  final String? title;
  final AlertVariant variant;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
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

    return DecoratedBox(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: spacing.md, color: fg),
            SizedBox(width: spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(title!, style: typography.labelMd.copyWith(color: fg)),
                  if (title != null) SizedBox(height: spacing.xxs),
                  Text(message, style: typography.textSm.copyWith(color: fg)),
                ],
              ),
            ),
            if (onDismiss != null) ...[
              SizedBox(width: spacing.sm),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(LucideIcons.x, size: spacing.md, color: fg),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
