import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocBottomNavigation extends StatelessWidget {
  const CkgocBottomNavigation({
    required this.selectedIndex,
    required this.items,
    this.onDestinationSelected,
    this.fab,
    super.key,
  });
  final int selectedIndex;
  final List<CkgocNavItem> items;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final t = theme.typography;

    final barHeight = s.x3l;

    Widget navItem(int i) {
      final item = items[i];
      final active = i == selectedIndex;
      final iconData = active ? (item.activeIcon ?? item.icon) : item.icon;
      final color = active ? c.primary : c.onSurfaceVariant;
      return Expanded(
        child: InkWell(
          onTap: () => onDestinationSelected?.call(i),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: s.lg, color: color),
              SizedBox(height: s.xxs),
              Text(
                item.label,
                style: t.labelSm.copyWith(color: color),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    final barDecoration = BoxDecoration(
      color: c.surface,
      border: Border(
        top: BorderSide(color: c.outline, width: s.xxs / 2),
      ),
    );

    if (fab != null) {
      final half = items.length ~/ 2;
      return SizedBox(
        height: barHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: barHeight,
              decoration: barDecoration,
              child: Row(
                children: [
                  ...List.generate(half, navItem),
                  const Expanded(child: SizedBox()),
                  ...List.generate(
                    items.length - half,
                    (i) => navItem(half + i),
                  ),
                ],
              ),
            ),
            Positioned(top: -(s.x2l / 2), child: fab!),
          ],
        ),
      );
    }

    return Container(
      height: barHeight,
      decoration: barDecoration,
      child: Row(children: List.generate(items.length, navItem)),
    );
  }
}
