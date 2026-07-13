import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

class CkgocIconButton extends StatelessWidget {
  const CkgocIconButton({
    required this.icon,
    this.onPressed,
    this.tooltip,
    super.key,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;
    final opacity = theme.opacity;

    final isDisabled = onPressed == null;

    Widget button = AnimatedOpacity(
      duration: motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: colors.onSurface,
          padding: EdgeInsets.all(spacing.sm),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.md),
            ),
            overlayColor: colors.primaryHover,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
