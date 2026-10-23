import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

const _navItems = [
  CKNavItem(icon: Icons.home_outlined, label: 'Home'),
  CKNavItem(icon: Icons.search, label: 'Search'),
  CKNavItem(icon: Icons.person_outline, label: 'Profile'),
];

const _tabs = [
  CKTab(label: 'One', content: Text('Content one')),
  CKTab(label: 'Two', content: Text('Content two')),
];

List<CKSideNavSection> _sections() => const [
      CKSideNavSection(
        label: 'Main',
        items: [
          CKSideNavItem(icon: Icons.home, label: 'Dashboard', itemKey: 'dash'),
          CKSideNavItem(icon: Icons.people, label: 'Users', itemKey: 'users'),
        ],
      ),
    ];

void main() {
  smokeMatrix({
    'CKAppBar': () => const CKAppBar(title: Text('Title')),
    'CKAppBar.surface': () => const CKAppBar.surface(title: Text('Title')),
    'CKAppBar.dark': () => const CKAppBar.dark(title: Text('Title')),
    'CKAppBar.transparent': () =>
        const CKAppBar.transparent(title: Text('Title')),
    'CKAppBar large': () =>
        const CKAppBar(title: Text('Title'), largeTitle: true),
    'CKTabs line': () => const CKTabs(tabs: _tabs),
    'CKTabs.pill': () => const CKTabs.pill(tabs: _tabs),
    'CKTabs.card': () => const CKTabs.card(tabs: _tabs),
    'CKBottomNavigation': () =>
        CKBottomNavigation(selectedIndex: 0, items: _navItems, onDestinationSelected: (_) {}),
    'CKNavigationRail': () => CKNavigationRail(
          selectedIndex: 0,
          items: _navItems,
          onDestinationSelected: (_) {},
        ),
  });

  smokeMatrix({
    'CKDrawer': () => Scaffold(
          body: CKDrawer(
            appName: 'App',
            items: const [
              CKDrawerItem(icon: Icons.home, label: 'Home'),
              CKDrawerItem(icon: Icons.settings, label: 'Settings'),
            ],
            selectedIndex: 0,
            onItemSelected: (_) {},
          ),
        ),
    'CKSideNav': () => Scaffold(
          body: Row(children: [
            CKSideNav(
              sections: _sections(),
              selectedIndex: 0,
              onItemSelected: (_) {},
              brandName: 'Brand',
            ),
          ]),
        ),
    'CKSideNav collapsed': () => Scaffold(
          body: Row(children: [
            CKSideNav(
              sections: _sections(),
              selectedIndex: 0,
              onItemSelected: (_) {},
              collapsed: true,
            ),
          ]),
        ),
    'CKScreenLayout': () => CKScreenLayout(
          sections: _sections(),
          selectedIndex: 0,
          onItemSelected: (_) {},
          body: const Center(child: Text('Body')),
        ),
  }, fullScreen: true);

  group('CKTabs', () {
    testWidgets('shows the first tab and switches on tap', (tester) async {
      int? changed;
      await pumpCK(
        tester,
        CKTabs(tabs: _tabs, onTabChanged: (i) => changed = i),
      );
      expect(find.text('Content one'), findsOneWidget);
      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();
      expect(find.text('Content two'), findsOneWidget);
      expect(changed, 1);
    });

    testWidgets('honours initialIndex', (tester) async {
      await pumpCK(tester, const CKTabs(tabs: _tabs, initialIndex: 1));
      expect(find.text('Content two'), findsOneWidget);
    });
  });

  group('CKBottomNavigation', () {
    testWidgets('reports the tapped destination', (tester) async {
      int? picked;
      await pumpCK(
        tester,
        Scaffold(
          bottomNavigationBar: CKBottomNavigation(
            selectedIndex: 0,
            items: _navItems,
            onDestinationSelected: (i) => picked = i,
          ),
        ),
        fullScreen: true,
      );
      await tester.tap(find.text('Profile'));
      expect(picked, 2);
    });
  });

  group('CKSideNav', () {
    testWidgets('lists items and reports key selection', (tester) async {
      Object? picked;
      await pumpCK(
        tester,
        Scaffold(
          body: Row(children: [
            CKSideNav(
              sections: _sections(),
              selectedIndex: 0,
              onItemSelected: (_) {},
              selectedKey: 'dash',
              onItemSelectedKey: (k) => picked = k,
            ),
          ]),
        ),
        fullScreen: true,
      );
      expect(find.text('Dashboard'), findsOneWidget);
      await tester.tap(find.text('Users'));
      expect(picked, 'users');
    });
  });

  group('CKDrawer', () {
    testWidgets('reports the tapped item', (tester) async {
      int? picked;
      await pumpCK(
        tester,
        Scaffold(
          body: CKDrawer(
            appName: 'App',
            items: const [
              CKDrawerItem(icon: Icons.home, label: 'Home'),
              CKDrawerItem(icon: Icons.settings, label: 'Settings'),
            ],
            selectedIndex: 0,
            onItemSelected: (i) => picked = i,
          ),
        ),
        fullScreen: true,
      );
      await tester.tap(find.text('Settings'));
      expect(picked, 1);
    });
  });

  group('CKAppBar', () {
    testWidgets('shows its title', (tester) async {
      await pumpCK(
        tester,
        const Scaffold(appBar: CKAppBar(title: Text('Dashboard'))),
        fullScreen: true,
      );
      expect(find.text('Dashboard'), findsOneWidget);
    });
  });
}
