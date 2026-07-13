import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

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

  static final _sections = [
    CkgocSideNavSection(
      label: 'Main',
      items: [
        CkgocSideNavItem(icon: LucideIcons.layoutDashboard, label: 'Dashboard'),
        CkgocSideNavItem(icon: LucideIcons.barChart2, label: 'Analytics'),
        CkgocSideNavItem(icon: LucideIcons.folderOpen, label: 'Projects'),
      ],
    ),
    CkgocSideNavSection(
      label: 'Sales Orders',
      items: [
        CkgocSideNavItem(icon: LucideIcons.bike, label: 'Motorcyles', badge: 6),
        CkgocSideNavItem(
          icon: LucideIcons.settings2,
          label: 'Spare Parts',
          badge: 2,
        ),
        CkgocSideNavItem(icon: LucideIcons.clipboardList, label: 'Service'),
        CkgocSideNavItem(icon: LucideIcons.shoppingCart, label: 'Sales'),
      ],
    ),
    CkgocSideNavSection(
      label: 'Config',
      items: [CkgocSideNavItem(icon: LucideIcons.settings, label: 'Settings')],
    ),
  ];

  static String _activeLabel(int index) {
    final flat = <CkgocSideNavItem>[];
    for (final sec in _sections) {
      flat.addAll(sec.items);
    }
    return flat[index].label;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: c.outline),
                  borderRadius: BorderRadius.circular(theme.radius.lg),
                ),
                child: Row(
                  children: [
                    CkgocSideNav(
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
            brandName: 'Castlekeep',
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
    final theme = context.ckgocTheme;
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
      CkgocTabs(
        tabs: [
          CkgocTab(
            label: 'Overview',
            icon: LucideIcons.layoutDashboard,
            content: tabBody(
              'Overview',
              'Summary of all activity and metrics.',
            ),
          ),
          CkgocTab(
            label: 'Analytics',
            icon: LucideIcons.barChart2,
            content: tabBody('Analytics', 'Detailed analytics and reports.'),
          ),
          CkgocTab(
            label: 'Reports',
            content: tabBody('Reports', 'Generated reports and exports.'),
          ),
          CkgocTab(
            label: 'Settings',
            icon: LucideIcons.settings,
            content: tabBody('Settings', 'Configuration and preferences.'),
          ),
          CkgocTab(
            label: 'Users',
            icon: LucideIcons.users,
            content: tabBody('Users', 'User management and permissions.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — PILL'),
      CkgocTabs(
        variant: TabVariant.pill,
        tabs: [
          CkgocTab(
            label: 'All',
            content: tabBody('All', 'All items across every status.'),
          ),
          CkgocTab(
            label: 'Active',
            content: tabBody('Active', 'Currently active items.'),
          ),
          CkgocTab(
            label: 'Pending',
            content: tabBody('Pending', 'Items awaiting action.'),
          ),
          CkgocTab(
            label: 'Resolved',
            content: tabBody('Resolved', 'Completed and resolved items.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — CARD'),
      CkgocTabs(
        variant: TabVariant.card,
        tabs: [
          CkgocTab(
            label: 'Home',
            icon: LucideIcons.home,
            content: tabBody('Home', 'Your home workspace.'),
          ),
          CkgocTab(
            label: 'Work',
            icon: LucideIcons.briefcase,
            content: tabBody('Work', 'Work-related items and tasks.'),
          ),
          CkgocTab(
            label: 'Travel',
            icon: LucideIcons.map,
            content: tabBody('Travel', 'Travel plans and bookings.'),
          ),
          CkgocTab(
            label: 'Health',
            icon: LucideIcons.heart,
            content: tabBody('Health', 'Health tracking and logs.'),
          ),
          CkgocTab(
            label: 'Finance',
            icon: LucideIcons.creditCard,
            content: tabBody('Finance', 'Financial overview and budget.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — SCROLLABLE'),
      CkgocTabs(
        scrollable: true,
        tabs: [
          CkgocTab(
            label: 'Overview',
            content: tabBody('Overview', 'Summary panel.'),
          ),
          CkgocTab(
            label: 'Analytics',
            content: tabBody('Analytics', 'Analytics panel.'),
          ),
          CkgocTab(
            label: 'Reports',
            content: tabBody('Reports', 'Reports panel.'),
          ),
          CkgocTab(
            label: 'Settings',
            content: tabBody('Settings', 'Settings panel.'),
          ),
          CkgocTab(label: 'Users', content: tabBody('Users', 'Users panel.')),
          CkgocTab(
            label: 'Billing',
            content: tabBody('Billing', 'Billing and invoices.'),
          ),
          CkgocTab(
            label: 'Integrations',
            content: tabBody('Integrations', 'Third-party integrations.'),
          ),
          CkgocTab(
            label: 'Logs',
            content: tabBody('Logs', 'System and audit logs.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
      sectionLabel('TABS — WITH BADGES'),
      CkgocTabs(
        tabs: [
          CkgocTab(
            label: 'Inbox',
            badge: 12,
            content: tabBody('Inbox', '12 unread messages in your inbox.'),
          ),
          CkgocTab(
            label: 'Sent',
            content: tabBody('Sent', 'Messages you have sent.'),
          ),
          CkgocTab(
            label: 'Drafts',
            badge: 3,
            content: tabBody('Drafts', '3 unsaved drafts.'),
          ),
          CkgocTab(
            label: 'Trash',
            content: tabBody('Trash', 'Deleted messages.'),
          ),
        ],
      ),
      SizedBox(height: s.xl),
    ];
  }

  List<Widget> _appBarSections(BuildContext context) {
    final theme = context.ckgocTheme;
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

    Widget preview(String label, CkgocAppBar bar) => Column(
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
        CkgocAppBar(
          style: AppBarStyle.primary,
          title: const Text('Overview'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.bell), tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'SURFACE',
        CkgocAppBar(
          style: AppBarStyle.surface,
          title: const Text('Dashboard'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.bell), tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'DARK',
        CkgocAppBar(
          style: AppBarStyle.dark,
          title: const Text('Settings'),
          leading: const Icon(LucideIcons.chevronLeft),
          trailing: [tIcon(LucideIcons.user)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'TRANSPARENT',
        CkgocAppBar(
          style: AppBarStyle.transparent,
          trailing: [tIcon(LucideIcons.search)],
        ),
      ),
      SizedBox(height: s.md),
      preview(
        'LARGE TITLE',
        CkgocAppBar(
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
    final theme = context.ckgocTheme;
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
      const CkgocNavItem(icon: LucideIcons.home, label: 'Home'),
      const CkgocNavItem(icon: LucideIcons.search, label: 'Search'),
      const CkgocNavItem(icon: LucideIcons.settings, label: 'Settings'),
      const CkgocNavItem(icon: LucideIcons.user, label: 'Profile'),
    ];

    Widget navPreview(String label, CkgocBottomNavigation nav) => Column(
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
        CkgocBottomNavigation(
          selectedIndex: _bottomNavIndex,
          items: items,
          onDestinationSelected: (i) => setState(() => _bottomNavIndex = i),
        ),
      ),
      SizedBox(height: s.md),
      navPreview(
        'WITH FAB',
        CkgocBottomNavigation(
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
