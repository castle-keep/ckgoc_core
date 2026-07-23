import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

// Contextual dropdown menu.

class CkgocMenu extends StatelessWidget {
  const CkgocMenu({required this.trigger, required this.items, super.key});
  final Widget trigger;
  final List<CkgocMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final typography = theme.typography;

    Future<void> openMenu(BuildContext triggerContext) async {
      final overlay = Overlay.maybeOf(triggerContext);
      final renderBox = triggerContext.findRenderObject() as RenderBox?;
      final overlayBox = overlay?.context.findRenderObject() as RenderBox?;

      if (renderBox == null || overlayBox == null) return;

      final topLeft = renderBox.localToGlobal(
        Offset.zero,
        ancestor: overlayBox,
      );
      final bottomRight = renderBox.localToGlobal(
        renderBox.size.bottomRight(Offset.zero),
        ancestor: overlayBox,
      );

      final selectedIndex = await showMenu<int>(
        context: triggerContext,
        color: colors.surfaceElevated,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.lg),
          side: BorderSide(color: colors.outlineVariant),
        ),
        position: RelativeRect.fromRect(
          Rect.fromPoints(topLeft, bottomRight),
          Offset.zero & overlayBox.size,
        ),
        items: [
          for (int index = 0; index < items.length; index++)
            PopupMenuItem<int>(
              value: index,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (items[index].icon != null) ...[
                    Icon(
                      items[index].icon,
                      size: spacing.md,
                      color: items[index].destructive
                          ? colors.error
                          : colors.onSurface,
                    ),
                    SizedBox(width: spacing.sm),
                  ],
                  Flexible(
                    child: Text(
                      items[index].label,
                      style: typography.labelMd.copyWith(
                        color: items[index].destructive
                            ? colors.error
                            : colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );

      if (selectedIndex != null) {
        items[selectedIndex].onTap?.call();
      }
    }

    return Builder(
      builder: (triggerContext) => Semantics(
        button: true,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius.lg),
            onTap: () => openMenu(triggerContext),
            child: trigger,
          ),
        ),
      ),
    );
  }
}
