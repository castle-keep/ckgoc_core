import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// FAB. Pass [label] for extended variant.
class CkgocFab extends StatelessWidget {
  const CkgocFab({required this.icon, this.onPressed, this.label, super.key});
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;
    final typography = theme.typography;
    final elevation = theme.elevation;

    if (label != null) {
      return AnimatedContainer(
        duration: motion.normal,
        curve: motion.decelerate,
        child: FloatingActionButton.extended(
          onPressed: onPressed,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: elevation.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.xl),
          ),
          icon: Icon(icon),
          label: Padding(
            padding: EdgeInsets.only(left: spacing.xs),
            child: Text(
              label!,
              style: typography.labelLg.copyWith(color: colors.onPrimary),
            ),
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: motion.normal,
      curve: motion.decelerate,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: elevation.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.full),
        ),
        child: Icon(icon),
      ),
    );
  }
}
