import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/foundation/colors/color_primitives.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocToast extends StatelessWidget {
  const CkgocToast({
    required this.message,
    this.variant = ToastVariant.defaultToast,
    this.onDismiss,
    super.key,
  });
  final String message;
  final ToastVariant variant;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final (bg, fg, icon) = switch (variant) {
      ToastVariant.defaultToast => (
        colors.inverseSurface,
        colors.onInverseSurface,
        null,
      ),
      ToastVariant.success => (
        CkgocPrimitiveColors.successDark,
        CkgocPrimitiveColors.successLight,
        LucideIcons.checkCircle,
      ),
      ToastVariant.error => (
        CkgocPrimitiveColors.errorDark,
        CkgocPrimitiveColors.errorLight,
        LucideIcons.xCircle,
      ),
      ToastVariant.warning => (
        CkgocPrimitiveColors.warningDark,
        CkgocPrimitiveColors.warningLight,
        LucideIcons.alertTriangle,
      ),
      ToastVariant.info => (
        CkgocPrimitiveColors.infoDark,
        CkgocPrimitiveColors.infoLight,
        LucideIcons.info,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius.lg),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.s12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: spacing.md, color: fg),
              SizedBox(width: spacing.sm),
            ],
            Expanded(
              child: Text(
                message,
                style: typography.textSm.copyWith(color: fg),
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
