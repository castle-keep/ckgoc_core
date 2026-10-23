import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Vertical navigation rail for tablet / desktop.
///
/// Shows each destination as an icon above a label, with the selected one
/// highlighted. Fills the height it is given.
class CKNavigationRail extends StatelessWidget {
  const CKNavigationRail({
    required this.selectedIndex,
    required this.items,
    this.onDestinationSelected,
    super.key,
  });
  final int selectedIndex;
  final List<CKNavItem> items;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    Widget destination(int i) {
      final item = items[i];
      final selected = i == selectedIndex;
      final color = selected ? colors.primary : colors.onSurfaceVariant;

      return Semantics(
        button: true,
        selected: selected,
        child: InkWell(
          onTap: () => onDestinationSelected?.call(i),
          borderRadius: BorderRadius.circular(theme.radius.md),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: spacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: theme.motion.fast,
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.md,
                    vertical: spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? colors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(theme.radius.full),
                  ),
                  child: Icon(
                    selected ? (item.activeIcon ?? item.icon) : item.icon,
                    size: spacing.lg,
                    color: color,
                  ),
                ),
                SizedBox(height: spacing.xxs),
                Text(
                  item.label,
                  style: typography.labelSm.copyWith(color: color),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: spacing.x4l - spacing.md,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(right: BorderSide(color: colors.outline)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: spacing.sm),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) destination(i),
            ],
          ),
        ),
      ),
    );
  }
}
