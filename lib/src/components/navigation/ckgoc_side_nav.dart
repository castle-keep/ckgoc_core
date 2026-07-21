import 'package:ckgoc_core/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/brand_icon.dart';
import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

/// Collapsible side navigation used by app shells.
///
/// Displays sections and items with optional badges, branding, and collapse
/// behavior.
class CkgocSideNav extends StatelessWidget {
  const CkgocSideNav({
    required this.sections,
    required this.selectedIndex,
    required this.onItemSelected,
    this.collapsed = false,
    this.onToggleCollapse,
    this.logo,
    this.brandName,
    this.version,
    this.style = SideNavStyle.surface,
    super.key,
  });
  final List<CkgocSideNavSection> sections;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool collapsed;
  final VoidCallback? onToggleCollapse;
  final Widget? logo;
  final String? brandName;
  final String? version;
  final SideNavStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;
    final motion = theme.motion;
    final resolvedBrandName = brandName?.trim();
    final hasBrandName =
        resolvedBrandName != null && resolvedBrandName.isNotEmpty;

    final opacity = theme.opacity;

    // spacing.x5l(128) + spacing.s80(80) + spacing.xl(32) = 240
    final expandedWidth = spacing.x5l + spacing.s80 + spacing.xl;
    // spacing.xl(32) + spacing.lg(24) = 56
    final collapsedWidth = spacing.xl + spacing.lg;

    final isBrand = style == SideNavStyle.brand;
    final bg = isBrand ? colors.primary : colors.surface;
    final borderColor = isBrand ? colors.primary : colors.outline;
    final fg = isBrand ? colors.onPrimary : colors.onSurface;
    final fgMuted = isBrand
        ? colors.onPrimary.withValues(alpha: opacity.muted)
        : colors.onSurfaceVariant;
    final sectionLabelColor = isBrand
        ? colors.onPrimary.withValues(alpha: opacity.scrim)
        : colors.onSurfaceVariant;
    final activeBg = isBrand
        ? colors.onPrimary.withValues(alpha: opacity.subtle)
        : colors.primary.withValues(alpha: opacity.hover);
    final activeFg = isBrand ? colors.onPrimary : colors.primary;

    // Flatten items to get absolute indices
    int idx = 0;
    final List<
      ({int index, CkgocSideNavSection section, CkgocSideNavItem item})
    >
    flatItems = [];
    for (final section in sections) {
      for (final item in section.items) {
        flatItems.add((index: idx, section: section, item: item));
        idx++;
      }
    }

    Widget buildItem(int itemIndex, CkgocSideNavItem item) {
      final isSelected = itemIndex == selectedIndex;

      final showIconBadge = collapsed && item.badge != null;

      final iconWidget = SizedBox(
        width: spacing.md,
        height: spacing.md,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(
              item.icon,
              size: spacing.md,
              color: isSelected ? activeFg : fgMuted,
            ),

            if (showIconBadge)
              Positioned(
                top: -spacing.xxs,
                right: -spacing.xs,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: spacing.md,
                    minHeight: spacing.md,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.xs,
                    vertical: spacing.xxs / 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.error,
                    borderRadius: BorderRadius.circular(radius.full),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.badge! > 99 ? '99+' : '${item.badge}',
                    style: typography.labelSm.copyWith(
                      color: colors.onError,
                      fontSize: 9,
                      height: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

      return Tooltip(
        message: collapsed ? item.label : '',
        preferBelow: false,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.decelerate,
          margin: EdgeInsets.symmetric(horizontal: spacing.xs, vertical: 1),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(radius.base),
          ),
          child: InkWell(
            onTap: () => onItemSelected(itemIndex),
            borderRadius: BorderRadius.circular(radius.base),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm,
                vertical: spacing.sm,
              ),
              child: Row(
                mainAxisAlignment: collapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  iconWidget,
                  if (!collapsed) ...[
                    SizedBox(width: spacing.sm),
                    Expanded(
                      child: Text(
                        item.label,
                        style: typography.labelMd.copyWith(
                          color: isSelected ? activeFg : fg,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.badge != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spacing.xs,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: colors.error,
                          borderRadius: BorderRadius.circular(radius.full),
                        ),
                        child: Text(
                          '${item.badge}',
                          style: typography.labelSm.copyWith(
                            color: colors.onError,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Build section list
    final List<Widget> sectionWidgets = [];
    int runningIndex = 0;
    for (final section in sections) {
      if (!collapsed && section.label != null) {
        sectionWidgets.add(
          Padding(
            padding: EdgeInsets.only(
              left: spacing.md,
              top: spacing.sm,
              bottom: spacing.xs,
            ),
            child: Text(
              section.label!.toUpperCase(),
              style: typography.labelSm.copyWith(
                color: sectionLabelColor,
                letterSpacing: 0.8,
              ),
            ),
          ),
        );
      } else if (section.label != null) {
        sectionWidgets.add(
          Divider(
            color: fgMuted.withValues(alpha: opacity.subtle + opacity.hover),
            indent: spacing.md,
            endIndent: spacing.md,
            height: spacing.md,
          ),
        );
      }
      for (final item in section.items) {
        sectionWidgets.add(buildItem(runningIndex, item));
        runningIndex++;
      }
    }

    final header = Container(
      width: double.infinity,
      height: spacing.x3l,
      padding: EdgeInsets.symmetric(horizontal: spacing.sm),
      child: collapsed
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onToggleCollapse != null)
                  InkWell(
                    onTap: onToggleCollapse,
                    borderRadius: BorderRadius.circular(radius.base),
                    child: Padding(
                      padding: EdgeInsets.all(spacing.xs),
                      child: Icon(
                        LucideIcons.panelLeftOpen,
                        size: spacing.md + spacing.xxs,
                        color: fgMuted,
                      ),
                    ),
                  ),
              ],
            )
          : Row(
              children: [
                if (logo != null)
                  SizedBox(width: spacing.xl, height: spacing.xl, child: logo!)
                else
                  CkgocContainer(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: spacing.xl,
                      height: spacing.xl,
                      child: Builder(
                        builder: (ctx) {
                          String? assetPath;
                          switch (theme.brand) {
                            case CkgocBrand.castleKeep:
                              assetPath = BrandIcon.castlekeepLogo2Svg;
                              break;
                            case CkgocBrand.skyGo:
                              assetPath = BrandIcon.skygoLogo2;
                              break;
                          }

                          return BrandIcon.brandLogoWidget(
                            ctx,
                            theme.brand,
                            size: spacing.xl,
                            assetPath: assetPath,
                          );
                        },
                      ),
                    ),
                  ),
                SizedBox(width: spacing.sm),
                if (hasBrandName)
                  Expanded(
                    child: Text(
                      resolvedBrandName,
                      style: typography.labelLg.copyWith(color: fg),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                else
                  const Spacer(),
                if (onToggleCollapse != null)
                  InkWell(
                    onTap: onToggleCollapse,
                    borderRadius: BorderRadius.circular(radius.base),
                    child: Padding(
                      padding: EdgeInsets.all(spacing.xs),
                      child: Icon(
                        LucideIcons.panelLeftClose,
                        size: spacing.md,
                        color: fgMuted,
                      ),
                    ),
                  ),
              ],
            ),
    );

    final footer = version != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Text(
              collapsed ? '' : 'v$version',
              style: typography.textXs.copyWith(color: fgMuted),
              overflow: TextOverflow.ellipsis,
            ),
          )
        : const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius.lg),
        bottomRight: Radius.circular(radius.lg),
      ),
      child: AnimatedContainer(
        duration: motion.normal,
        curve: motion.decelerate,
        width: collapsed ? collapsedWidth : expandedWidth,
        decoration: BoxDecoration(color: bg),
        foregroundDecoration: BoxDecoration(
          border: Border(right: BorderSide(color: borderColor)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            Divider(
              height: spacing.xxs,
              thickness: 1,
              color: isBrand
                  ? colors.onPrimary.withValues(alpha: opacity.subtle)
                  : colors.outline,
            ),
            Expanded(
              child: ClipRect(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: spacing.xs),
                      ...sectionWidgets,
                    ],
                  ),
                ),
              ),
            ),
            footer,
            SizedBox(height: spacing.xs),
          ],
        ),
      ),
    );
  }
}
