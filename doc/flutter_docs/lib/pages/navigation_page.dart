import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Navigation Components',
      subtitle:
          'Documentation for every file in lib/src/components/navigation.',
      children: [
        DocSection(data: _appBarDoc()),
        DocSection(data: _tabsDoc()),
        DocSection(data: _bottomNavigationDoc()),
        DocSection(data: _breadcrumbDoc()),
        DocSection(data: _drawerDoc()),
        DocSection(data: _navigationRailDoc()),
        DocSection(data: _sideNavDoc()),
      ],
    );
  }
}

ComponentDocData _appBarDoc() => const ComponentDocData(
      title: 'CkgocAppBar',
      summary:
          'Design-system app bar with style variants, custom leading content, trailing actions, and optional large-title mode.',
      demo: _AppBarDemo(),
      code: '''
CkgocAppBar(
  title: Text('Dashboard'),
  leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
  trailing: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
  style: AppBarStyle.primary,
)
''',
      params: [
        DocParam(
          name: 'title',
          type: 'Widget?',
          description: 'App bar title widget.',
        ),
        DocParam(
          name: 'leading',
          type: 'Widget?',
          description: 'Leading widget, usually a menu or back action.',
        ),
        DocParam(
          name: 'trailing',
          type: 'List<Widget>',
          description: 'Trailing actions list.',
          defaultValue: 'const []',
        ),
        DocParam(
          name: 'style',
          type: 'AppBarStyle',
          description: 'Visual app bar style.',
          defaultValue: 'AppBarStyle.surface',
        ),
        DocParam(
          name: 'largeTitle',
          type: 'bool',
          description: 'Uses a taller layout and larger title typography.',
          defaultValue: 'false',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use largeTitle?',
          answer:
              'Use it on section landing screens where the header is part of the content hierarchy, not just chrome.',
        ),
        DocFaq(
          question: 'Can trailing hold multiple actions?',
          answer: 'Yes. Pass any number of widgets in the trailing list.',
        ),
      ],
      notes: [
        'Enum demo coverage: all AppBarStyle values are rendered.',
      ],
    );

ComponentDocData _tabsDoc() => const ComponentDocData(
      title: 'CkgocTabs',
      summary:
          'Tabs component supporting line, pill, and card variants with optional badges and icons.',
      demo: _TabsDemo(),
      code: '''
CkgocTabs(
  variant: TabVariant.pill,
  tabs: const [
    CkgocTab(label: 'Overview', content: Text('Overview content')),
    CkgocTab(label: 'Billing', badge: 2, content: Text('Billing content')),
  ],
)
''',
      params: [
        DocParam(
          name: 'tabs',
          type: 'List<CkgocTab>',
          description: 'Tab definitions and associated content.',
          requiredParam: true,
        ),
        DocParam(
          name: 'variant',
          type: 'TabVariant',
          description: 'Tabs bar style.',
          defaultValue: 'TabVariant.line',
        ),
        DocParam(
          name: 'scrollable',
          type: 'bool',
          description:
              'Allows horizontal scrolling instead of stretching tabs.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'initialIndex',
          type: 'int',
          description: 'Initially selected tab index.',
          defaultValue: '0',
        ),
        DocParam(
          name: 'onTabChanged',
          type: 'ValueChanged<int>?',
          description: 'Selection callback.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use pill versus line?',
          answer:
              'Use line when tabs should feel lightweight and content-first. Use pill when tabs need more visual separation or feel more like segmented controls.',
        ),
        DocFaq(
          question: 'Can badges and icons be combined?',
          answer: 'Yes. Each CkgocTab supports both icon and badge together.',
        ),
      ],
      notes: [
        'Enum demo coverage: all TabVariant values are rendered.',
      ],
    );

ComponentDocData _bottomNavigationDoc() => const ComponentDocData(
      title: 'CkgocBottomNavigation',
      summary:
          'Bottom navigation bar with optional central FAB cutout composition.',
      demo: _BottomNavigationDemo(),
      code: '''
CkgocBottomNavigation(
  selectedIndex: 0,
  items: const [
    CkgocNavItem(icon: Icons.home_outlined, label: 'Home'),
    CkgocNavItem(icon: Icons.person_outline, label: 'Profile'),
  ],
  onDestinationSelected: (index) {},
  fab: CkgocFab(icon: Icons.add, onPressed: () {}),
)
''',
      params: [
        DocParam(
          name: 'selectedIndex',
          type: 'int',
          description: 'Current selected destination index.',
          requiredParam: true,
        ),
        DocParam(
          name: 'items',
          type: 'List<CkgocNavItem>',
          description: 'Bottom navigation destinations.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onDestinationSelected',
          type: 'ValueChanged<int>?',
          description: 'Selection callback.',
        ),
        DocParam(
          name: 'fab',
          type: 'Widget?',
          description: 'Optional floating action button centered over the bar.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How many items work well here?',
          answer:
              'Keep it small. Bottom navigation is best with a limited number of top-level destinations.',
        ),
        DocFaq(
          question: 'What is the fab slot for?',
          answer: 'Use it for the primary create action in mobile app shells.',
        ),
      ],
    );

ComponentDocData _breadcrumbDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocBreadcrumb',
      summary:
          'Breadcrumb API surface for hierarchical paths. The current package implementation is a placeholder widget body.',
      demo: _BreadcrumbDemo(),
      code: '''
CkgocBreadcrumb(
  items: const [
    BreadcrumbItem(label: 'Home'),
    BreadcrumbItem(label: 'Projects'),
    BreadcrumbItem(label: 'CastleKeep'),
  ],
)
''',
      params: [
        DocParam(
          name: 'items',
          type: 'List<BreadcrumbItem>',
          description: 'Ordered breadcrumb path entries.',
          requiredParam: true,
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'What should each item do?',
          answer:
              'Earlier path segments should usually be tappable navigation targets; the current page is often presentational only.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _drawerDoc() => const ComponentDocData(
      title: 'CkgocDrawer',
      summary:
          'App drawer with branding, optional user email, and a selectable item list.',
      demo: _DrawerDemo(),
      code: '''
CkgocDrawer(
  appName: 'CastleKeep Admin',
  selectedIndex: 0,
  userEmail: 'ops@castlekeep.app',
  items: const [
    CkgocDrawerItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    CkgocDrawerItem(icon: Icons.people_outline, label: 'Users'),
  ],
  onItemSelected: (index) {},
)
''',
      params: [
        DocParam(
          name: 'appName',
          type: 'String',
          description: 'Drawer brand or app name.',
          requiredParam: true,
        ),
        DocParam(
          name: 'items',
          type: 'List<CkgocDrawerItem>',
          description: 'Drawer options.',
          requiredParam: true,
        ),
        DocParam(
          name: 'selectedIndex',
          type: 'int',
          description: 'Current selected item index.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onItemSelected',
          type: 'ValueChanged<int>',
          description: 'Item selection callback.',
          requiredParam: true,
        ),
        DocParam(
          name: 'userEmail',
          type: 'String?',
          description: 'Optional account email in the header.',
        ),
        DocParam(
          name: 'logo',
          type: 'Widget?',
          description: 'Optional header logo override.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Does the drawer render a default logo?',
          answer:
              'Yes. If logo is omitted, it derives a brand logo from the active theme brand.',
        ),
        DocFaq(
          question: 'Should I close the drawer manually on selection?',
          answer:
              'No. The component closes itself after invoking onItemSelected.',
        ),
      ],
    );

ComponentDocData _navigationRailDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocNavigationRail',
      summary:
          'Navigation rail API surface for larger responsive shells. The current package implementation is a placeholder widget body.',
      demo: _NavigationRailDemo(),
      code: '''
CkgocNavigationRail(
  selectedIndex: 1,
  items: const [
    CkgocNavItem(icon: Icons.home_outlined, label: 'Home'),
    CkgocNavItem(icon: Icons.settings_outlined, label: 'Settings'),
  ],
  onDestinationSelected: (index) {},
)
''',
      params: [
        DocParam(
          name: 'selectedIndex',
          type: 'int',
          description: 'Current selected index.',
          requiredParam: true,
        ),
        DocParam(
          name: 'items',
          type: 'List<CkgocNavItem>',
          description: 'Rail destinations.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onDestinationSelected',
          type: 'ValueChanged<int>?',
          description: 'Selection callback.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'When would I prefer a rail over bottom navigation?',
          answer:
              'Use a rail on tablet or desktop layouts where vertical chrome is more appropriate.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _sideNavDoc() => const ComponentDocData(
      title: 'CkgocSideNav',
      summary:
          'Collapsible side navigation with grouped sections, badges, optional branding, and surface or brand styling.',
      demo: _SideNavDemo(),
      code: '''
CkgocSideNav(
  selectedIndex: 0,
  sections: const [
    CkgocSideNavSection(
      label: 'Main',
      items: [
        CkgocSideNavItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
        CkgocSideNavItem(icon: Icons.people_outline, label: 'Users', badge: 12),
      ],
    ),
  ],
  onItemSelected: (index) {},
  style: SideNavStyle.brand,
)
''',
      params: [
        DocParam(
          name: 'sections',
          type: 'List<CkgocSideNavSection>',
          description: 'Labeled groups of navigation items.',
          requiredParam: true,
        ),
        DocParam(
          name: 'selectedIndex',
          type: 'int',
          description: 'Absolute selected item index across all sections.',
          requiredParam: true,
        ),
        DocParam(
          name: 'onItemSelected',
          type: 'ValueChanged<int>',
          description: 'Item selection callback.',
          requiredParam: true,
        ),
        DocParam(
          name: 'collapsed',
          type: 'bool',
          description: 'Collapsed icon-only mode.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'onToggleCollapse',
          type: 'VoidCallback?',
          description: 'Collapse toggle handler.',
        ),
        DocParam(
          name: 'logo',
          type: 'Widget?',
          description: 'Optional brand logo override.',
        ),
        DocParam(
          name: 'brandName',
          type: 'String?',
          description: 'Optional brand text in the header.',
        ),
        DocParam(
          name: 'version',
          type: 'String?',
          description: 'Optional footer version text.',
        ),
        DocParam(
          name: 'style',
          type: 'SideNavStyle',
          description: 'Surface or brand appearance.',
          defaultValue: 'SideNavStyle.surface',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How is selectedIndex calculated across sections?',
          answer:
              'It is absolute across the flattened item list, not scoped per section.',
        ),
        DocFaq(
          question: 'When should I use SideNavStyle.brand?',
          answer:
              'Use the brand style when the side nav is the primary shell chrome and should carry stronger brand identity.',
        ),
      ],
      notes: [
        'Enum demo coverage: both SideNavStyle values are rendered, including collapsed mode.',
      ],
    );

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final style in AppBarStyle.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: CkgocAppBar(
                title: Text(style.name),
                leading:
                    IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                trailing: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                ],
                style: style,
              ),
            ),
          ),
      ],
    );
  }
}

class _TabsDemo extends StatelessWidget {
  const _TabsDemo();

  List<CkgocTab> _tabs() => const [
        CkgocTab(
          label: 'Overview',
          icon: Icons.dashboard_outlined,
          content: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Overview content'),
          ),
        ),
        CkgocTab(
          label: 'Billing',
          badge: 2,
          content: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Billing content'),
          ),
        ),
        CkgocTab(
          label: 'Settings',
          icon: Icons.settings_outlined,
          content: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Settings content'),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final variant in TabVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CkgocTabs(tabs: _tabs(), variant: variant),
          ),
      ],
    );
  }
}

class _BottomNavigationDemo extends StatefulWidget {
  const _BottomNavigationDemo();

  @override
  State<_BottomNavigationDemo> createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<_BottomNavigationDemo> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CkgocBottomNavigation(
          selectedIndex: selected,
          onDestinationSelected: (index) => setState(() => selected = index),
          items: const [
            CkgocNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            CkgocNavItem(
              icon: Icons.receipt_long_outlined,
              activeIcon: Icons.receipt_long,
              label: 'Billing',
            ),
            CkgocNavItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
            ),
            CkgocNavItem(
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              label: 'Settings',
            ),
          ],
          fab: CkgocFab(icon: Icons.add, onPressed: () {}),
        ),
      ),
    );
  }
}

class _BreadcrumbDemo extends StatelessWidget {
  const _BreadcrumbDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocBreadcrumb(
          items: [
            BreadcrumbItem(label: 'Home'),
            BreadcrumbItem(label: 'Projects'),
            BreadcrumbItem(label: 'CastleKeep'),
          ],
        ),
      ],
    );
  }
}

class _DrawerDemo extends StatelessWidget {
  const _DrawerDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 420,
      child: CkgocDrawer(
        appName: 'CastleKeep Admin',
        userEmail: 'ops@castlekeep.app',
        selectedIndex: 1,
        onItemSelected: (_) {},
        items: const [
          CkgocDrawerItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
          CkgocDrawerItem(icon: Icons.people_outline, label: 'Users'),
          CkgocDrawerItem(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
    );
  }
}

class _NavigationRailDemo extends StatelessWidget {
  const _NavigationRailDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocNavigationRail(
          selectedIndex: 1,
          items: [
            CkgocNavItem(icon: Icons.home_outlined, label: 'Home'),
            CkgocNavItem(icon: Icons.settings_outlined, label: 'Settings'),
          ],
        ),
      ],
    );
  }
}

class _SideNavDemo extends StatefulWidget {
  const _SideNavDemo();

  @override
  State<_SideNavDemo> createState() => _SideNavDemoState();
}

class _SideNavDemoState extends State<_SideNavDemo> {
  int selectedIndex = 1;
  bool collapsed = false;

  List<CkgocSideNavSection> get _sections => const [
        CkgocSideNavSection(
          label: 'Main',
          items: [
            CkgocSideNavItem(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
            ),
            CkgocSideNavItem(
              icon: Icons.people_outline,
              label: 'Users',
              badge: 12,
            ),
          ],
        ),
        CkgocSideNavSection(
          label: 'System',
          items: [
            CkgocSideNavItem(icon: Icons.settings_outlined, label: 'Settings'),
            CkgocSideNavItem(icon: Icons.shield_outlined, label: 'Security'),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        Container(
          width: 260,
          height: 420,
          child: CkgocSideNav(
            sections: _sections,
            selectedIndex: selectedIndex,
            onItemSelected: (value) => setState(() => selectedIndex = value),
            collapsed: false,
            brandName: 'CastleKeep',
            version: '1.0.0',
            style: SideNavStyle.surface,
          ),
        ),
        Container(
          width: collapsed ? 72 : 260,
          height: 420,
          child: CkgocSideNav(
            sections: _sections,
            selectedIndex: selectedIndex,
            onItemSelected: (value) => setState(() => selectedIndex = value),
            collapsed: collapsed,
            onToggleCollapse: () => setState(() => collapsed = !collapsed),
            brandName: 'CastleKeep',
            version: '1.0.0',
            style: SideNavStyle.brand,
          ),
        ),
      ],
    );
  }
}
