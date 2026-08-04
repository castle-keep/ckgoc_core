import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedSurface = 0;
  bool _collapsedSurface = false;

  int _selectedBrand = 0;
  bool _collapsedBrand = false;
  int _bottomNavIndex = 0;
  Object? _selectedKeyExample = 'dashboard';

  static final _sections = [
    CKSideNavSection(
      label: 'Main',
      items: [
        CKSideNavItem(
          icon: LucideIcons.layoutDashboard,
          label: 'Dashboard',
          itemKey: 'dashboard',
        ),
        CKSideNavItem(
          icon: LucideIcons.barChart2,
          label: 'Analytics',
          itemKey: 'analytics',
        ),
        CKSideNavItem(
          icon: LucideIcons.folderOpen,
          label: 'Projects',
          itemKey: 'projects',
        ),
      ],
    ),
    CKSideNavSection(
      label: 'Sales Orders',
      items: [
        CKSideNavItem(
          icon: LucideIcons.bike,
          label: 'Motorcyles',
          badge: 6,
          itemKey: 'motorcycles',
        ),
        CKSideNavItem(
          icon: LucideIcons.settings2,
          label: 'Spare Parts',
          badge: 2,
          itemKey: 'spare_parts',
        ),
        CKSideNavItem(
          icon: LucideIcons.clipboardList,
          label: 'Service',
          itemKey: 'service',
        ),
        CKSideNavItem(
          icon: LucideIcons.shoppingCart,
          label: 'Sales',
          itemKey: 'sales',
        ),
      ],
    ),
    CKSideNavSection(
      label: 'Config',
      items: [
        CKSideNavItem(
          icon: LucideIcons.settings,
          label: 'Settings',
          itemKey: 'settings',
        ),
      ],
    ),
  ];

  static String _activeLabel(int index) {
    final flat = <CKSideNavItem>[];
    for (final sec in _sections) {
      flat.addAll(sec.items);
    }
    return flat[index].label;
  }

  String _activeLabelForKey(Object? key) {
    if (key == null) return '';
    for (final sec in _sections) {
      for (final item in sec.items) {
        if (item.itemKey == key) return item.label;
      }
    }
    return '';
  }

  int? _indexForKey(Object? key) {
    if (key == null) return null;
    int idx = 0;
    for (final sec in _sections) {
      for (final item in sec.items) {
        if (item.itemKey == key) return idx;
        idx++;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final t = theme.typography;
    final c = theme.colors;

    Widget label(String text) => Padding(
      padding: EdgeInsets.only(bottom: s.sm),
      child: Text(
        text,
        style: t.labelSm.copyWith(
          color: c.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );

    Widget navDemo({
      required String title,
      required int selected,
      required bool collapsed,
      required ValueChanged<int> onSelect,
      required VoidCallback onToggle,
      SideNavStyle style = SideNavStyle.surface,
      String? brandName,
    }) {
      final activeLabel = _activeLabel(selected);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          label(title),
          SizedBox(
            height: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.radius.lg),
              child: Row(
                children: [
                  CKSideNav(
                    profileName: 'John Doe',
                    profilePosition: 'Professional Procastinator',
                    onLogout: () => debugPrint('Profile tapped'),
                    sections: _sections,
                    selectedIndex: selected,
                    onItemSelected: onSelect,
                    collapsed: collapsed,
                    onToggleCollapse: onToggle,
                    brandName: brandName,
                    version: '1.0',
                    style: style,
                  ),
                  Expanded(
                    child: Container(
                      color: c.background,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              activeLabel,
                              style: t.labelLg.copyWith(color: c.onSurface),
                            ),
                            SizedBox(height: s.xs),
                            Text(
                              'Page content',
                              style: t.textSm.copyWith(
                                color: c.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget navDemoKey({
      required String title,
      required Object? selectedKey,
      required bool collapsed,
      required ValueChanged<Object?> onSelectKey,
      required VoidCallback onToggle,
      SideNavStyle style = SideNavStyle.surface,
      String? brandName,
    }) {
      final activeLabel = _activeLabelForKey(selectedKey);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          label(title),
          SizedBox(
            height: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.radius.lg),
              child: Row(
                children: [
                  CKSideNav(
                    // profileName: 'John Doe',
                    // profilePosition: 'Professional Procastinator',
                    // onLogout: () => debugPrint('Profile tapped'),
                    sections: _sections,
                    selectedIndex: _indexForKey(selectedKey) ?? 0,
                    selectedKey: selectedKey,
                    onItemSelectedKey: onSelectKey,
                    onItemSelected: (i) {},
                    collapsed: collapsed,
                    onToggleCollapse: onToggle,
                    brandName: brandName,
                    version: '1.0',
                    style: style,
                  ),
                  Expanded(
                    child: Container(
                      color: c.background,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              activeLabel,
                              style: t.labelLg.copyWith(color: c.onSurface),
                            ),
                            SizedBox(height: s.xs),
                            Text(
                              'Page content',
                              style: t.textSm.copyWith(
                                color: c.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          navDemo(
            title: 'SIDE NAVIGATION — SURFACE',
            selected: _selectedSurface,
            collapsed: _collapsedSurface,
            brandName: theme.brand == ckcoreBrand.castleKeep
                ? 'CastleKeep'
                : 'SkyGo',
            onSelect: (i) => setState(() => _selectedSurface = i),
            onToggle: () =>
                setState(() => _collapsedSurface = !_collapsedSurface),
          ),
          SizedBox(height: s.xl),
          navDemo(
            title: 'SIDE NAVIGATION — BRAND',
            selected: _selectedBrand,
            collapsed: _collapsedBrand,
            onSelect: (i) => setState(() => _selectedBrand = i),
            onToggle: () => setState(() => _collapsedBrand = !_collapsedBrand),
            style: SideNavStyle.brand,
            brandName: theme.brand == ckcoreBrand.castleKeep
                ? 'CastleKeep'
                : 'SkyGo',
          ),
          SizedBox(height: s.xl),
          navDemoKey(
            title: 'SIDE NAVIGATION — KEY-BASED',
            selectedKey: _selectedKeyExample,
            collapsed: false,
            onSelectKey: (k) => setState(() => _selectedKeyExample = k),
            onToggle: () {},
            style: SideNavStyle.surface,
            brandName: theme.brand == ckcoreBrand.castleKeep
                ? 'CastleKeep'
                : 'SkyGo',
          ),
          SizedBox(height: s.xl),
          ..._tabSections(context),
          ..._appBarSections(context),
          ..._bottomNavSections(context),
        ],
      ),
    );
  }

  List<Widget> _tabSections(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final t = theme.typography;
    final c = theme.colors;

    Widget sectionLabel(String text) => Padding(
      padding: EdgeInsets.only(bottom: s.sm),
      child: Text(
        text,
        style: t.labelSm.copyWith(
          color: c.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );

    Widget tabBody(String title, String subtitle) => Container(
      color: c.background,
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: t.labelLg.copyWith(color: c.onSurface)),
          SizedBox(height: s.xs),
          Text(subtitle, style: t.textSm.copyWith(color: c.onSurfaceVariant)),
        ],
      ),
    );

    return [
      sectionLabel('TABS — LINE'),
      CKTabs(
        tabs: [
          CKTab(
            label: 'Overview',
            icon: LucideIcons.layoutDashboard,
            content: tabBody(
              'Overview',
              'Summary of all activity and metrics.',
            ),
          ),
          CKTab(
            label: 'Analytics',
            icon: LucideIcons.barChart2,
            content: tabBody('Analytics', 'Detailed analytics and reports.'),
          ),
          CKTab(
            label: 'Reports',
            content: tabBody('Reports', 'Generated reports and exports.'),
          ),
          CKTab(
            label: 'Settings',
            icon: LucideIcons.settings,
            content: tabBody('Settings', 'Configuration and preferences.'),
          ),
          CKTab(
            label: 'Users',
            icon: LucideIcons.users,
            content: tabBody('Users', 'User management and permissions.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — PILL'),
      CKTabs(
        variant: TabVariant.pill,
        tabs: [
          CKTab(
            label: 'All',
            content: tabBody('All', 'All items across every status.'),
          ),
          CKTab(
            label: 'Active',
            content: tabBody('Active', 'Currently active items.'),
          ),
          CKTab(
            label: 'Pending',
            content: tabBody('Pending', 'Items awaiting action.'),
          ),
          CKTab(
            label: 'Resolved',
            content: tabBody('Resolved', 'Completed and resolved items.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — CARD'),
      CKTabs(
        variant: TabVariant.card,
        tabs: [
          CKTab(
            label: 'Home',
            icon: LucideIcons.home,
            content: tabBody('Home', 'Your home workspace.'),
          ),
          CKTab(
            label: 'Work',
            icon: LucideIcons.briefcase,
            content: tabBody('Work', 'Work-related items and tasks.'),
          ),
          CKTab(
            label: 'Travel',
            icon: LucideIcons.map,
            content: tabBody('Travel', 'Travel plans and bookings.'),
          ),
          CKTab(
            label: 'Health',
            icon: LucideIcons.heart,
            content: tabBody('Health', 'Health tracking and logs.'),
          ),
          CKTab(
            label: 'Finance',
            icon: LucideIcons.creditCard,
            content: tabBody('Finance', 'Financial overview and budget.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — SCROLLABLE'),
      CKTabs(
        scrollable: true,
        tabs: [
          CKTab(
            label: 'Overview',
            content: tabBody('Overview', 'Summary panel.'),
          ),
          CKTab(
            label: 'Analytics',
            content: tabBody('Analytics', 'Analytics panel.'),
          ),
          CKTab(
            label: 'Reports',
            content: tabBody('Reports', 'Reports panel.'),
          ),
          CKTab(
            label: 'Settings',
            content: tabBody('Settings', 'Settings panel.'),
          ),
          CKTab(label: 'Users', content: tabBody('Users', 'Users panel.')),
          CKTab(
            label: 'Billing',
            content: tabBody('Billing', 'Billing and invoices.'),
          ),
          CKTab(
            label: 'Integrations',
            content: tabBody('Integrations', 'Third-party integrations.'),
          ),
          CKTab(
            label: 'Logs',
            content: tabBody('Logs', 'System and audit logs.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — WITH BADGES'),
      CKTabs(
        tabs: [
          CKTab(
            label: 'Inbox',
            badge: 12,
            content: tabBody('Inbox', '12 unread messages in your inbox.'),
          ),
          CKTab(
            label: 'Sent',
            content: tabBody('Sent', 'Messages you have sent.'),
          ),
          CKTab(
            label: 'Drafts',
            badge: 3,
            content: tabBody('Drafts', '3 unsaved drafts.'),
          ),
          CKTab(label: 'Trash', content: tabBody('Trash', 'Deleted messages.')),
        ],
      ),
      SizedBox(height: s.xl),
    ];
  }

  List<Widget> _appBarSections(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final t = theme.typography;
    final c = theme.colors;
    final r = theme.radius;

    Widget sLabel(String text) => Padding(
      padding: EdgeInsets.only(bottom: s.sm),
      child: Text(
        text,
        style: t.labelSm.copyWith(
          color: c.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );

    Widget preview(String label, CKAppBar bar) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        sLabel(label),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.lg),
          child: Container(
            height: bar.preferredSize.height + s.s80,
            decoration: BoxDecoration(
              border: Border.all(color: c.outline, width: s.xxs / 2),
              borderRadius: BorderRadius.circular(r.lg),
              color: c.background,
            ),
            child: Column(
              children: [
                bar,
                Expanded(
                  child: Center(
                    child: Text(
                      'Content area',
                      style: t.textSm.copyWith(color: c.onSurfaceVariant),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    Widget tIcon(IconData icon) => Padding(
      padding: EdgeInsets.symmetric(horizontal: s.xs),
      child: Icon(icon),
    );

    return [
      sLabel('APP BAR'),
      preview(
        'PRIMARY',
        CKAppBar(
          style: AppBarStyle.primary,
          title: const Text('Overview'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.bell), tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'SURFACE',
        CKAppBar(
          style: AppBarStyle.surface,
          title: const Text('Dashboard'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.bell), tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'DARK',
        CKAppBar(
          style: AppBarStyle.dark,
          title: const Text('Settings'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'TRANSPARENT',
        CKAppBar(
          style: AppBarStyle.transparent,
          trailing: [tIcon(LucideIcons.search)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'LARGE TITLE',
        CKAppBar(
          style: AppBarStyle.surface,
          largeTitle: true,
          title: const Text('Page Title'),
          leading: const Icon(LucideIcons.chevronLeft),
        ),
      ),
      SizedBox(height: s.xl),
    ];
  }

  List<Widget> _bottomNavSections(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final t = theme.typography;
    final c = theme.colors;
    final r = theme.radius;
    final sh = theme.shadows;

    Widget sLabel(String text) => Padding(
      padding: EdgeInsets.only(bottom: s.sm),
      child: Text(
        text,
        style: t.labelSm.copyWith(
          color: c.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );

    final items = [
      const CKNavItem(icon: LucideIcons.home, label: 'Home'),
      const CKNavItem(icon: LucideIcons.search, label: 'Search'),
      const CKNavItem(icon: LucideIcons.settings, label: 'Settings'),
      const CKNavItem(icon: LucideIcons.user, label: 'Profile'),
    ];

    Widget navPreview(String label, CKBottomNavigation nav) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        sLabel(label),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.lg),
          child: Container(
            height: s.s80 + s.x3l,
            decoration: BoxDecoration(
              border: Border.all(color: c.outline, width: s.xxs / 2),
              borderRadius: BorderRadius.circular(r.lg),
              color: c.background,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Content area',
                      style: t.textSm.copyWith(color: c.onSurfaceVariant),
                    ),
                  ),
                ),
                nav,
              ],
            ),
          ),
        ),
      ],
    );

    return [
      sLabel('BOTTOM NAVIGATION'),
      navPreview(
        'STANDARD',
        CKBottomNavigation(
          selectedIndex: _bottomNavIndex,
          items: items,
          onDestinationSelected: (i) => setState(() => _bottomNavIndex = i),
        ),
      ),
      SizedBox(height: s.md),
      navPreview(
        'WITH FAB',
        CKBottomNavigation(
          selectedIndex: _bottomNavIndex,
          items: items,
          onDestinationSelected: (i) => setState(() => _bottomNavIndex = i),
          fab: Container(
            width: s.x2l,
            height: s.x2l,
            decoration: BoxDecoration(
              color: c.primary,
              shape: BoxShape.circle,
              boxShadow: sh.md,
            ),
            child: Center(
              child: Icon(LucideIcons.plus, color: c.onPrimary, size: s.lg),
            ),
          ),
        ),
      ),
      SizedBox(height: s.xl),
    ];
  }
}
