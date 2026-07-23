import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocFilterChip extends StatelessWidget {
  const CkgocFilterChip({
    required this.label,
    this.selected = false,
    this.onTap,
    this.state = ChipState.defaultState,
    super.key,
  });
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final ChipState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final motion = theme.motion;
    final opacity = theme.opacity;

    final isDisabled = state == ChipState.disabled;
    final isError = state == ChipState.error;
    final pill = BorderRadius.circular(radius.full);

    final Color bg;
    final Color fg;
    final Color borderColor;

    if (isError) {
      bg = colors.errorContainer;
      fg = colors.error;
      borderColor = colors.error;
    } else if (selected) {
      bg = colors.primary;
      fg = colors.onPrimary;
      borderColor = colors.primary;
    } else {
      bg = Colors.transparent;
      fg = colors.onSurface;
      borderColor = colors.outline;
    }

    return AnimatedOpacity(
      duration: motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.decelerate,
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s12,
            vertical: spacing.xs,
          ),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: borderColor),
            borderRadius: pill,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(LucideIcons.check, size: spacing.md, color: fg),
                SizedBox(width: spacing.xs),
              ],
              Text(label, style: theme.typography.labelMd.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}

class CkgocInputChip extends StatelessWidget {
  const CkgocInputChip({
    required this.label,
    this.onRemove,
    this.state = ChipState.defaultState,
    this.leading,
    super.key,
  });
  final String label;
  final VoidCallback? onRemove;
  final ChipState state;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final opacity = theme.opacity;
    final motion = theme.motion;

    final isDisabled = state == ChipState.disabled;
    final isError = state == ChipState.error;
    final pill = BorderRadius.circular(radius.full);

    final Color fg = isError ? colors.error : colors.onSurface;
    final Color borderColor = isError ? colors.error : colors.outline;

    return AnimatedOpacity(
      duration: motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: Container(
        padding: EdgeInsets.only(
          left: spacing.s12,
          right: spacing.xs,
          top: spacing.xs,
          bottom: spacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, SizedBox(width: spacing.xs)],
            Text(label, style: theme.typography.labelMd.copyWith(color: fg)),
            SizedBox(width: spacing.xs),
            GestureDetector(
              onTap: isDisabled ? null : onRemove,
              child: Icon(LucideIcons.x, size: spacing.md, color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
