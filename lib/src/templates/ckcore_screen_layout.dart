import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/navigation/ckcore_side_nav.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Responsive screen layout with side navigation and body content.
///
/// For desktop (>= 840px): Side nav is persistent.
/// For tablet portrait and below (< 840px): Side nav is hidden by default
/// and shown as an overlay when the hamburger menu is tapped.
class CKScreenLayout extends StatefulWidget {
  const CKScreenLayout({
    required this.body,
    required this.sections,
    required this.selectedIndex,
    required this.onItemSelected,
    this.logo,
    this.brandName,
    this.version,
    this.sideNavStyle = SideNavStyle.surface,
    this.allowSideNavCollapse = true,
    this.bodyScrollable = true,
    this.profileName,
    this.profilePosition,
    this.profileAvatar,
    this.profileAuthProvider,
    this.onLogout,
    super.key,
  });

  /// The main content area to display.
  final Widget body;

  /// Side navigation sections and items.
  final List<CKSideNavSection> sections;

  /// Currently selected navigation item index.
  final int selectedIndex;

  /// Callback when a navigation item is selected.
  final ValueChanged<int> onItemSelected;

  /// Optional logo widget for the side nav header.
  final Widget? logo;

  /// Optional brand name to display in the side nav header.
  final String? brandName;

  /// Optional version string to display in the side nav footer.
  final String? version;

  /// Style variant for the side navigation.
  final SideNavStyle sideNavStyle;

  /// Whether to allow collapsing the side nav on desktop.
  final bool allowSideNavCollapse;

  /// Optional profile name to display in the side nav.
  final bool bodyScrollable;

  /// Optional profile name to display in the side nav.
  final String? profileName;

  /// Optional profile position to display in the side nav.
  /// This is typically a job title or role.
  final String? profilePosition;

  /// Optional profile avatar to display in the side nav.
  /// This can be an image or icon widget.
  final Widget? profileAvatar;

  /// Callback when the logout button is tapped in the side nav.
  final VoidCallback? onLogout;

  /// Optional profile auth provider to display in the side nav.
  /// This is typically used to show which authentication provider the user is logged in with.
  final String? profileAuthProvider;

  @override
  State<CKScreenLayout> createState() => _CKScreenLayoutState();
}

class _CKScreenLayoutState extends State<CKScreenLayout> {
  bool _sideNavCollapsed = false;
  bool _drawerOpen = false;

  Widget _wrapBody(Widget body) {
    if (!widget.bodyScrollable) return body;

    final minHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: SizedBox(width: double.infinity, child: body),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final breakpoints = theme.breakpoints;

    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= breakpoints.lg;

    // On desktop, side nav is persistent; on mobile/tablet, it's a drawer
    if (isDesktop) {
      return Scaffold(
        backgroundColor: colors.background,
        body: Row(
          children: [
            CKSideNav(
              profileName: widget.profileName,
              profilePosition: widget.profilePosition,
              profileAvatar: widget.profileAvatar,
              profileAuthProvider: widget.profileAuthProvider,
              onLogout: widget.onLogout,
              sections: widget.sections,
              selectedIndex: widget.selectedIndex,
              onItemSelected: widget.onItemSelected,
              collapsed: _sideNavCollapsed,
              onToggleCollapse: widget.allowSideNavCollapse
                  ? () => setState(() => _sideNavCollapsed = !_sideNavCollapsed)
                  : null,
              logo: widget.logo,
              brandName: widget.brandName,
              version: widget.version,
              style: widget.sideNavStyle,
            ),
            Expanded(child: _wrapBody(widget.body)),
          ],
        ),
      );
    }

    // Mobile/Tablet: hamburger menu + drawer overlay
    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Main content with top bar
          Column(
            children: [
              // Top bar with hamburger
              Container(
                height: spacing.x3l,
                decoration: BoxDecoration(
                  color: widget.sideNavStyle == SideNavStyle.brand
                      ? colors.primary
                      : colors.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: widget.sideNavStyle == SideNavStyle.brand
                          ? colors.primary
                          : colors.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: spacing.md),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => setState(() => _drawerOpen = !_drawerOpen),
                      borderRadius: BorderRadius.circular(radius.base),
                      child: Padding(
                        padding: EdgeInsets.all(spacing.xs),
                        child: Icon(
                          LucideIcons.menu,
                          size: spacing.md + spacing.xxs,
                          color: widget.sideNavStyle == SideNavStyle.brand
                              ? colors.onPrimary
                              : colors.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(width: spacing.sm),
                    if (widget.brandName != null)
                      Expanded(
                        child: Text(
                          widget.brandName!,
                          style: theme.typography.labelLg.copyWith(
                            color: widget.sideNavStyle == SideNavStyle.brand
                                ? colors.onPrimary
                                : colors.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              // Body content
              Expanded(child: _wrapBody(widget.body)),
            ],
          ),

          // Drawer overlay
          if (_drawerOpen) ...[
            // Backdrop
            GestureDetector(
              onTap: () => setState(() => _drawerOpen = false),
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            // Side nav drawer
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius.lg),
                  bottomRight: Radius.circular(radius.lg),
                ),
                child: CKSideNav(
                  profileName: widget.profileName,
                  profilePosition: widget.profilePosition,
                  profileAvatar: widget.profileAvatar,
                  profileAuthProvider: widget.profileAuthProvider,
                  onLogout: widget.onLogout,
                  sections: widget.sections,
                  selectedIndex: widget.selectedIndex,
                  onItemSelected: (index) {
                    widget.onItemSelected(index);
                    setState(() => _drawerOpen = false);
                  },
                  collapsed: false,
                  logo: widget.logo,
                  brandName: widget.brandName,
                  version: widget.version,
                  style: widget.sideNavStyle,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
