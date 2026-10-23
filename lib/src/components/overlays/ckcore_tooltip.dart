import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Contextual tooltip on long-press or hover.
class CKTooltip extends StatelessWidget {
  const CKTooltip({required this.message, required this.child, super.key});
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return Tooltip(
      message: message,
      waitDuration: const Duration(milliseconds: 400),
      verticalOffset: spacing.md,
      padding: EdgeInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs),
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: BorderRadius.circular(theme.radius.base),
        boxShadow: theme.shadows.sm,
      ),
      textStyle: theme.typography.textXs.copyWith(
        color: colors.onInverseSurface,
      ),
      child: child,
    );
  }
}
