import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// Bottom sheet that follows the design system surface and spacing.
class CkgocBottomSheet extends StatelessWidget {
  const CkgocBottomSheet({
    required this.children,
    this.title,
    this.onClose,
    super.key,
  });
  final String? title;
  final List<Widget> children;
  final VoidCallback? onClose;

  static Future<T?> show<T>({
    required BuildContext context,
    required List<Widget> children,
    String? title,
    VoidCallback? onClose,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) =>
          CkgocBottomSheet(title: title, onClose: onClose, children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.x2l),
          topRight: Radius.circular(radius.x2l),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: spacing.sm, bottom: spacing.xs),
              child: Container(
                width: spacing.s40,
                height: spacing.xs,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(radius.full),
                ),
              ),
            ),
          ),
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.lg,
                vertical: spacing.sm,
              ),
              child: Text(
                title!,
                style: typography.labelLg.copyWith(color: colors.onSurface),
              ),
            ),
            Divider(
              height: spacing.xxs,
              thickness: 1,
              color: colors.outlineVariant,
            ),
            SizedBox(height: spacing.xs),
          ],
          ...children,
          SizedBox(height: spacing.lg + bottomPadding),
        ],
      ),
    );
  }
}
