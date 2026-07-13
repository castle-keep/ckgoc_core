import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

class CkgocDrawerItem {
  const CkgocDrawerItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class CkgocDrawer extends StatelessWidget {
  const CkgocDrawer({
    required this.appName,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.userEmail,
    this.logo,
    super.key,
  });
  final String appName;
  final String? userEmail;
  final Widget? logo;
  final List<CkgocDrawerItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;
    final opacity = theme.opacity;
    final topPadding = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: colors.primary,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              spacing.lg,
              topPadding + spacing.lg,
              spacing.lg,
              spacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (logo != null)
                  SizedBox.square(dimension: spacing.s40, child: logo!)
                else
                  Container(
                    width: spacing.s40,
                    height: spacing.s40,
                    decoration: BoxDecoration(
                      color: colors.onPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(radius.md),
                    ),
                    child: Icon(
                      LucideIcons.layers,
                      size: spacing.s20,
                      color: colors.onPrimary,
                    ),
                  ),
                SizedBox(height: spacing.sm),
                Text(
                  appName,
                  style: typography.labelLg.copyWith(color: colors.onPrimary),
                ),
                if (userEmail != null) ...[
                  SizedBox(height: spacing.xs),
                  Text(
                    userEmail!,
                    style: typography.textSm.copyWith(
                      color: colors.onPrimary.withValues(
                        alpha: opacity.muted + 0.1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm,
                vertical: spacing.xs,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final isSelected = i == selectedIndex;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: spacing.xxs / 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary.withValues(alpha: opacity.hover)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(radius.base),
                  ),
                  child: InkWell(
                    onTap: () {
                      onItemSelected(i);
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(radius.base),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.md,
                        vertical: spacing.sm,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            items[i].icon,
                            size: spacing.md,
                            color: isSelected
                                ? colors.primary
                                : colors.onSurfaceVariant,
                          ),
                          SizedBox(width: spacing.sm),
                          Text(
                            items[i].label,
                            style: typography.labelMd.copyWith(
                              color: isSelected
                                  ? colors.primary
                                  : colors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
