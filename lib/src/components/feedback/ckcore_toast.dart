import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/foundation/colors/color_primitives.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Toast notification component with semantic color variants.
///
/// The default appearance is neutral. Use named constructors for semantic variants:
/// ```dart
/// CKToast(message: 'Hello')                // neutral (default)
/// CKToast.success(message: 'Done!')
/// CKToast.error(message: 'Failed')
/// CKToast.warning(message: 'Careful')
/// CKToast.info(message: 'FYI')
/// ```
class CKToast extends StatelessWidget {
  /// Default toast (neutral colors, recommended appearance).
  const CKToast({
    required this.message,
    this.variant = ToastVariant.defaultToast,
    this.onDismiss,
    super.key,
  });

  /// Success toast variant (green).
  const CKToast.success({required this.message, this.onDismiss, super.key})
    : variant = ToastVariant.success;

  /// Error toast variant (red).
  const CKToast.error({required this.message, this.onDismiss, super.key})
    : variant = ToastVariant.error;

  /// Warning toast variant (orange).
  const CKToast.warning({required this.message, this.onDismiss, super.key})
    : variant = ToastVariant.warning;

  /// Info toast variant (blue).
  const CKToast.info({required this.message, this.onDismiss, super.key})
    : variant = ToastVariant.info;
  final String message;
  final ToastVariant variant;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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
        ckcorePrimitiveColors.successDark,
        ckcorePrimitiveColors.successLight,
        LucideIcons.checkCircle,
      ),
      ToastVariant.error => (
        ckcorePrimitiveColors.errorDark,
        ckcorePrimitiveColors.errorLight,
        LucideIcons.xCircle,
      ),
      ToastVariant.warning => (
        ckcorePrimitiveColors.warningDark,
        ckcorePrimitiveColors.warningLight,
        LucideIcons.alertTriangle,
      ),
      ToastVariant.info => (
        ckcorePrimitiveColors.infoDark,
        ckcorePrimitiveColors.infoLight,
        LucideIcons.info,
      ),
    };

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: DecoratedBox(
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
      ),
    );
  }
}

/// Deprecated: Use [CKToast] instead.
@Deprecated('Use CKToast instead')
typedef ckcoretoast = CKToast;
