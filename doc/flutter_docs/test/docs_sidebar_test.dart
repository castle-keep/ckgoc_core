import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ckcore_docs_app/docs/docs_sidebar.dart';
import 'package:ckcore_docs_app/docs_navigation.dart';
import 'package:ckcore_docs_app/main.dart';
import 'package:ckcore_docs_app/pages/splash_screen.dart';

Future<void> _pumpSidebar(WidgetTester tester, {double width = 1400}) async {
  // Tall enough that the lazily built list shows every page.
  tester.view.physicalSize = Size(width, 1800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  currentRoute.value = '/';
  await tester.pumpWidget(
    const CKApp(
      brand: ckcoreBrand.castleKeep,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Row(children: [DocsSidebar()])),
    ),
  );
  await tester.pumpAndSettle();
}

int get _allItems => docsNavGroups.fold(0, (sum, g) => sum + g.items.length);

void main() {
  group('navigation data', () {
    test('every route is unique', () {
      final routes = [
        for (final g in docsNavGroups) ...g.items.map((i) => i.route)
      ];
      expect(routes.toSet().length, routes.length);
    });

    test('matches by title and by keyword, ignoring case and spaces', () {
      const item = DocsNavItem(
        title: 'Overlays',
        route: '/overlays',
        icon: Icons.layers,
        keywords: 'dialog tooltip',
      );
      expect(item.matches(''), isTrue);
      expect(item.matches('  OVER '), isTrue);
      expect(item.matches('Tooltip'), isTrue);
      expect(item.matches('table'), isFalse);
    });
  });

  group('DocsSidebar (expanded)', () {
    testWidgets('lists every group and page', (tester) async {
      await _pumpSidebar(tester);
      for (final g in docsNavGroups) {
        expect(find.text(g.title.toUpperCase()), findsOneWidget);
        for (final i in g.items) {
          expect(find.text(i.title), findsOneWidget, reason: i.title);
        }
      }
    });

    testWidgets('tapping a page navigates', (tester) async {
      await _pumpSidebar(tester);
      await tester.tap(find.text('Buttons'));
      expect(currentRoute.value, '/buttons');
    });

    testWidgets('the current page is marked selected', (tester) async {
      await _pumpSidebar(tester);
      currentRoute.value = '/inputs';
      await tester.pumpAndSettle();
      expect(
        tester.getSemantics(find.text('Inputs')),
        containsSemantics(label: 'Inputs', isSelected: true, isButton: true),
      );
      expect(
        tester.getSemantics(find.text('Buttons')),
        containsSemantics(label: 'Buttons', isSelected: false, isButton: true),
      );
    });

    testWidgets('selection follows route changes', (tester) async {
      await _pumpSidebar(tester);
      currentRoute.value = '/overlays';
      await tester.pumpAndSettle();
      expect(
        tester.getSemantics(find.text('Overlays')),
        containsSemantics(isSelected: true),
      );
    });
  });

  group('DocsSidebar search', () {
    testWidgets('filters pages by title', (tester) async {
      await _pumpSidebar(tester);
      await tester.enterText(find.byType(TextField), 'butt');
      await tester.pump();
      expect(find.text('Buttons'), findsOneWidget);
      expect(find.text('Inputs'), findsNothing);
      expect(find.text('COMPONENTS'), findsOneWidget);
      expect(find.text('FOUNDATIONS'), findsNothing);
    });

    testWidgets('finds a page by a component name it contains', (tester) async {
      await _pumpSidebar(tester);
      await tester.enterText(find.byType(TextField), 'tooltip');
      await tester.pump();
      expect(find.text('Overlays'), findsOneWidget);
      expect(find.text('Buttons'), findsNothing);
    });

    testWidgets('says so when nothing matches', (tester) async {
      await _pumpSidebar(tester);
      await tester.enterText(find.byType(TextField), 'zzzz');
      await tester.pump();
      expect(find.text('No pages match "zzzz"'), findsOneWidget);
      for (final g in docsNavGroups) {
        expect(find.text(g.title.toUpperCase()), findsNothing);
      }
    });

    testWidgets('the clear button restores the full list', (tester) async {
      await _pumpSidebar(tester);
      await tester.enterText(find.byType(TextField), 'butt');
      await tester.pump();
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pump();
      expect(find.text('Inputs'), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,
          '');
    });

    testWidgets('Enter opens the first match', (tester) async {
      await _pumpSidebar(tester);
      await tester.enterText(find.byType(TextField), 'tooltip');
      await tester.testTextInput.receiveAction(TextInputAction.go);
      await tester.pump();
      expect(currentRoute.value, '/overlays');
    });

    testWidgets('Escape clears the search', (tester) async {
      await _pumpSidebar(tester);
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'butt');
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,
          '');
    });
  });

  group('DocsSidebar collapsing', () {
    testWidgets('collapses to icons on narrow windows', (tester) async {
      await _pumpSidebar(tester, width: 800);
      expect(find.text('Buttons'), findsNothing);
      expect(find.text('COMPONENTS'), findsNothing);
      expect(find.byIcon(Icons.smart_button_outlined), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      // narrow windows are always collapsed, so there is no toggle
      expect(find.byTooltip('Collapse sidebar'), findsNothing);
    });

    testWidgets('collapsed icons still navigate and show tooltips',
        (tester) async {
      await _pumpSidebar(tester, width: 800);
      await tester.tap(find.byIcon(Icons.table_chart_outlined));
      expect(currentRoute.value, '/data-table');
      expect(find.byTooltip('Data Table'), findsOneWidget);
    });

    testWidgets('user can collapse and expand on wide windows', (tester) async {
      await _pumpSidebar(tester);
      final wide = tester.getSize(find.byType(DocsSidebar)).width;
      await tester.tap(find.byTooltip('Collapse sidebar'));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(DocsSidebar)).width, lessThan(wide));
      expect(find.text('Buttons'), findsNothing);

      await tester.tap(find.byTooltip('Expand sidebar'));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(DocsSidebar)).width, wide);
      expect(find.text('Buttons'), findsOneWidget);
    });

    testWidgets('the search button expands the sidebar and focuses search',
        (tester) async {
      await _pumpSidebar(tester);
      await tester.tap(find.byTooltip('Collapse sidebar'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Search docs'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(docsSearchFocus.hasFocus, isTrue);
    });

    testWidgets('every page still fits when collapsed', (tester) async {
      await _pumpSidebar(tester, width: 800);
      expect(find.byType(Tooltip), findsAtLeastNWidgets(_allItems));
      expect(tester.takeException(), isNull);
    });
  });

  group('inside the docs app', () {
    Future<void> openDocs(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1600, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      currentRoute.value = '/';
      await tester.pumpWidget(const DocsApp());
      await tester.pump();
      await tester.tap(find.byType(SplashScreen));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 600));
    }

    final searchField = find.descendant(
      of: find.byType(DocsSidebar),
      matching: find.byType(TextField),
    );

    testWidgets('there is exactly one sidebar, left of the page',
        (tester) async {
      await openDocs(tester);
      expect(find.byType(DocsSidebar), findsOneWidget);
      final bar = tester.getRect(find.byType(DocsSidebar));
      final title = tester.getRect(find.text('Get started with ckcoreui'));
      expect(bar.right, lessThanOrEqualTo(title.left));
    });

    testWidgets('keeps the search text while you navigate', (tester) async {
      await openDocs(tester);
      await tester.enterText(searchField, 'butt');
      await tester.pump();
      await tester.tap(
        find.descendant(
            of: find.byType(DocsSidebar), matching: find.text('Buttons')),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(currentRoute.value, '/buttons');
      expect(
        tester.widget<TextField>(searchField).controller!.text,
        'butt',
      );
    });

    testWidgets('Ctrl+K focuses the search field', (tester) async {
      await openDocs(tester);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
      await tester.pump();
      expect(docsSearchFocus.hasFocus, isTrue);
    });

    testWidgets('page content is capped for readability on wide screens',
        (tester) async {
      await openDocs(tester);
      final title = tester.getSize(find.text('Get started with ckcoreui'));
      expect(title.width, lessThanOrEqualTo(1100));
    });
  });
}
