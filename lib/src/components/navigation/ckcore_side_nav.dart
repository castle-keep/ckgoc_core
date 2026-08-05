import 'package:ckcoreui/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/brand_icon.dart';
import 'package:ckcoreui/src/themes/ckcore_brand.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Collapsible side navigation used by app shells.
///
/// Displays sections and items with optional badges, branding, and collapse
/// behavior.
class CKSideNav extends StatefulWidget {
  const CKSideNav({
    required this.sections,
    required this.selectedIndex,
    required this.onItemSelected,
    this.selectedKey,
    this.onItemSelectedKey,
    this.collapsed = false,
    this.onToggleCollapse,
    this.logo,
    this.brandName,
    this.version,
    this.style = SideNavStyle.surface,
    this.profileName,
    this.profilePosition,
    this.profileAvatar,
    this.profileAuthProvider,
    this.onLogout,
    super.key,
  });
  final List<CKSideNavSection> sections;
  @Deprecated(
    'Use selectedKey instead; selectedIndex will be removed in a future release',
  )
  final int selectedIndex;
  @Deprecated(
    'Use onItemSelectedKey instead; onItemSelected will be removed in a future release',
  )
  final ValueChanged<int> onItemSelected;
  // New preferred key-based selection. When provided, selection will be
  // determined by matching CKSideNavItem.itemKey to this value.
  final Object? selectedKey;
  // Preferred selection callback using the item's key. Non-breaking: both
  // callbacks may be used; index-based callback remains for backward compat.
  final ValueChanged<Object?>? onItemSelectedKey;
  final bool collapsed;
  final VoidCallback? onToggleCollapse;
  final Widget? logo;
  final String? brandName;
  final String? version;
  final SideNavStyle style;
  final String? profileName;
  final String? profilePosition;
  final Widget? profileAvatar;
  final String? profileAuthProvider;
  final VoidCallback? onLogout;

  @override
  State<CKSideNav> createState() => _CKSideNavState();
}

class _CKSideNavState extends State<CKSideNav> {
  late OverlayEntry _overlayEntry;
  final GlobalKey _profileCardKey = GlobalKey();
  bool _showExpanded = false;

  @override
  void initState() {
    super.initState();
    _showExpanded = !widget.collapsed;
  }

  @override
  void didUpdateWidget(CKSideNav oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.collapsed != widget.collapsed) {
      if (widget.collapsed) {
        // Hide immediately before shrinking
        _showExpanded = false;
        setState(() {});
      } else {
        Future.delayed(context.ckcoreTheme.motion.normal, () {
          if (mounted && !widget.collapsed) {
            setState(() => _showExpanded = true);
          }
        });
      }
    }
  }

  void _showProfileMenu(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;

    // Ensure the profile card is built and mounted
    final currentContext = _profileCardKey.currentContext;
    if (currentContext == null) return;

    final renderBox = currentContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    try {
      final offset = renderBox.localToGlobal(Offset.zero);

      // Screen and safe area
      final mq = MediaQuery.of(context);
      final screenSize = mq.size;
      final safeTop = mq.padding.top;
      final safeBottom = mq.padding.bottom;

      // Estimate overlay height conservatively using spacing tokens
      final double estimatedHeight =
          spacing.lg * 2 + // header padding
          spacing.md * 2 + // action padding
          (widget.onLogout != null ? spacing.lg : 0) +
          spacing.x3l; // text rows + generous buffer

      // Center the overlay on the profile card
      final cardCenterY = offset.dy + renderBox.size.height / 2;
      double top = cardCenterY - estimatedHeight / 2;

      final double minTop = safeTop + spacing.xs;
      final double maxTop =
          screenSize.height - safeBottom - estimatedHeight - spacing.xs;

      // Clamp: if overflows top, push down; if overflows bottom, push up
      top = top.clamp(minTop, maxTop);

      double left = offset.dx;
      double width = renderBox.size.width;

      // Ensure overlay fits horizontally (keep margin spacing.md)
      final double maxRight = screenSize.width - spacing.md;
      final double right = left + width;
      if (right > maxRight) {
        left = (maxRight - width).clamp(spacing.md, maxRight - 8.0);
      }

      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            // Dismissible backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: () => _overlayEntry.remove(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // Menu overlay
            Positioned(
              left: left,
              top: top,
              width: width,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(radius.lg),
                    boxShadow: theme.shadows.lg,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.profileName ?? '',
                              style: typography.labelMd.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            if (widget.profileAuthProvider != null)
                              Column(
                                children: [
                                  SizedBox(height: spacing.xs),
                                  Text(
                                    widget.profileAuthProvider!,
                                    style: typography.textSm.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: colors.outline),
                      Padding(
                        padding: EdgeInsets.all(spacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (widget.onLogout != null)
                              InkWell(
                                onTap: () {
                                  _overlayEntry.remove();
                                  widget.onLogout!();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      LucideIcons.logOut,
                                      color: colors.error,
                                      size: spacing.lg,
                                    ),
                                    SizedBox(width: spacing.sm),
                                    Text(
                                      'Log out',
                                      style: typography.labelMd.copyWith(
                                        color: colors.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: spacing.sm),
                            InkWell(
                              onTap: () => _overlayEntry.remove(),
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.left,
                                style: TextStyle(color: theme.colors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry);
    } catch (e) {
      debugPrint('Error showing profile menu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;
    final motion = theme.motion;
    final sh = theme.shadows;
    final resolvedBrandName = widget.brandName?.trim();
    final hasBrandName =
        resolvedBrandName != null && resolvedBrandName.isNotEmpty;

    final opacity = theme.opacity;

    // spacing.x5l(128) + spacing.s80(80) + spacing.xl(32) = 240
    final expandedWidth = spacing.x5l + spacing.s80 + spacing.xl;
    // spacing.xl(32) + spacing.lg(24) = 56
    final collapsedWidth = spacing.xl + spacing.lg;

    final isBrand = widget.style == SideNavStyle.brand;
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

    // Flatten items to get absolute indices and keys
    int idx = 0;
    final List<
      ({int index, CKSideNavSection section, CKSideNavItem item, Object? key})
    >
    flatItems = [];
    for (final section in widget.sections) {
      for (final item in section.items) {
        flatItems.add((
          index: idx,
          section: section,
          item: item,
          key: item.itemKey,
        ));
        idx++;
      }
    }

    Widget buildItem(int itemIndex, CKSideNavItem item, Object? itemKey) {
      // Determine selection. Priority:
      // 1. If `widget.selectedKey` is non-null, compare to `itemKey`.
      // 2. Else fall back to `widget.selectedIndex` (deprecated but supported).
      final bool isSelected = widget.selectedKey != null
          ? (itemKey != null && widget.selectedKey == itemKey)
          : (itemIndex == widget.selectedIndex);
      // Additionally support selectedIndex being a key via dynamic type check.
      // If parent passed a key-based selectedIndex (Object), developers should
      // use the new `selectedKey` API — see migration docs.

      final showIconBadge = widget.collapsed && item.badge != null;

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
                      // Badge font size: 3pt smaller than labelSm (12 → 9)
                      fontSize: typography.labelSm.fontSize! - 3,
                      // Tight line height for badge text
                      height: 1.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

      return Tooltip(
        message: widget.collapsed ? item.label : '',
        preferBelow: false,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.decelerate,
          margin: EdgeInsets.symmetric(
            horizontal: spacing.xs,
            vertical: spacing.xxs / 2,
          ),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(radius.base),
          ),
          child: InkWell(
            onTap: () {
              // Fire both callbacks to remain backwards-compatible. Prefer
              // key-based callback when available.
              if (widget.onItemSelectedKey != null) {
                widget.onItemSelectedKey!(itemKey);
              }
              widget.onItemSelected(itemIndex);
            },
            borderRadius: BorderRadius.circular(radius.base),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm,
                vertical: spacing.sm,
              ),
              child: Row(
                mainAxisAlignment: !_showExpanded
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  iconWidget,
                  if (_showExpanded) ...[
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
                          vertical: spacing.xxs / 2,
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
    for (final section in widget.sections) {
      if (!widget.collapsed && section.label != null) {
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
        sectionWidgets.add(buildItem(runningIndex, item, item.itemKey));
        runningIndex++;
      }
    }

    final header = Container(
      width: double.infinity,
      height: spacing.x3l,
      padding: EdgeInsets.symmetric(horizontal: spacing.sm),
      child: !_showExpanded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.onToggleCollapse != null)
                  InkWell(
                    onTap: widget.onToggleCollapse,
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
                if (widget.logo != null)
                  SizedBox(
                    width: spacing.xl,
                    height: spacing.xl,
                    child: widget.logo!,
                  )
                else
                  CKContainer(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: spacing.xl,
                      height: spacing.xl,
                      child: Builder(
                        builder: (ctx) {
                          String? assetPath;
                          switch (theme.brand) {
                            case ckcoreBrand.castleKeep:
                              assetPath = BrandIcon.castlekeepLogo2Svg;
                              break;
                            case ckcoreBrand.skyGo:
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
                if (widget.onToggleCollapse != null)
                  InkWell(
                    onTap: widget.onToggleCollapse,
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

    final footer = widget.version != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Text(
              widget.collapsed ? '' : 'v${widget.version}',
              style: typography.textXs.copyWith(color: fgMuted),
              overflow: TextOverflow.ellipsis,
            ),
          )
        : const SizedBox.shrink();

    final profileCard = widget.profileName != null && !widget.collapsed
        ? Column(
            key: _profileCardKey,
            children: [
              Divider(
                color: isBrand
                    ? colors.onPrimary.withValues(alpha: opacity.subtle)
                    : colors.outline,
                height: spacing.md,
              ),
              InkWell(
                onTap: () => _showProfileMenu(context),
                borderRadius: BorderRadius.circular(radius.base),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.sm,
                    vertical: spacing.sm,
                  ),
                  child: Row(
                    children: [
                      widget.profileAvatar ??
                          CKAvatar(
                            initials: widget.profileName!
                                .split(' ')
                                .map((e) => e[0])
                                .join()
                                .toUpperCase(),
                          ),
                      if (_showExpanded) ...[
                        SizedBox(width: spacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.profileName!,
                                style: typography.labelMd.copyWith(color: fg),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.profilePosition != null)
                                Text(
                                  widget.profilePosition!,
                                  style: typography.textXs.copyWith(
                                    color: fgMuted,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();

    final borderRadius = BorderRadius.all(Radius.circular(radius.lg));

    return Container(
      padding: EdgeInsets.all(spacing.md),
      decoration: BoxDecoration(
        color: colors.background,
        boxShadow: sh.sm,
        borderRadius: borderRadius,
      ),
      child: AnimatedContainer(
        duration: motion.normal,
        curve: motion.decelerate,
        width: widget.collapsed ? collapsedWidth : expandedWidth,
        decoration: BoxDecoration(color: bg, borderRadius: borderRadius),
        foregroundDecoration: BoxDecoration(
          border: Border(right: BorderSide(color: borderColor)),
          borderRadius: borderRadius,
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
            profileCard,
            footer,
            SizedBox(height: spacing.xs),
          ],
        ),
      ),
    );
  }
}
