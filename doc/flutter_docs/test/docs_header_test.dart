import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ckcore_docs_app/docs/docs_header.dart';
import 'package:ckcore_docs_app/docs/docs_sidebar.dart';
import 'package:ckcore_docs_app/docs_navigation.dart';
import 'package:ckcore_docs_app/main.dart';
import 'package:ckcore_docs_app/pages/splash_screen.dart';

Future<void> _pumpHeader(
  WidgetTester tester, {
  ckcoreBrand brand = ckcoreBrand.castleKeep,
  Brightness? brightness,
  ValueChanged<ckcoreBrand>? onBrand,
  ValueChanged<Brightness?>? onMode,
  double width = 1200,
}) async {
  tester.view.physicalSize = Size(width, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    CKApp(
      brand: brand,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DocsHeader(
          brand: brand,
          brightness: brightness,
          onBrandChanged: onBrand ?? (_) {},
          onBrightnessChanged: onMode ?? (_) {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _openDocs(WidgetTester tester) async {
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

CkcoreuiThemeData _theme(WidgetTester tester) =>
    tester.element(find.byType(Scaffold).first).ckcoreTheme;

void main() {
  group('DocsHeader', () {
    testWidgets('shows every brand and mode option', (tester) async {
      await _pumpHeader(tester);
      for (final label in ['CastleKeep', 'SkyGo', 'System', 'Light', 'Dark']) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('picking a brand reports it', (tester) async {
      ckcoreBrand? picked;
      await _pumpHeader(tester, onBrand: (b) => picked = b);
      await tester.tap(find.text('SkyGo'));
      expect(picked, ckcoreBrand.skyGo);
    });

    testWidgets('picking Dark, Light and System reports each', (tester) async {
      final picked = <Brightness?>[];
      await _pumpHeader(
        tester,
        brightness: Brightness.light,
        onMode: picked.add,
      );
      await tester.tap(find.text('Dark'));
      await tester.tap(find.text('System'));
      await tester.tap(find.text('Light'));
      expect(picked, [Brightness.dark, null, Brightness.light]);
    });

    testWidgets('marks the active options as selected', (tester) async {
      await _pumpHeader(
        tester,
        brand: ckcoreBrand.skyGo,
        brightness: Brightness.dark,
      );
      for (final label in ['SkyGo', 'Dark']) {
        expect(
          tester.getSemantics(find.text(label)),
          containsSemantics(label: label, isSelected: true, isButton: true),
        );
      }
      for (final label in ['CastleKeep', 'System', 'Light']) {
        expect(
          tester.getSemantics(find.text(label)),
          containsSemantics(label: label, isSelected: false, isButton: true),
        );
      }
    });

    testWidgets('System is selected when brightness is null', (tester) async {
      await _pumpHeader(tester);
      expect(
        tester.getSemantics(find.text('System')),
        containsSemantics(label: 'System', isSelected: true),
      );
    });

    testWidgets('narrow screens keep mode icons but drop their labels',
        (tester) async {
      await _pumpHeader(tester, width: 500);
      expect(find.text('Light'), findsNothing);
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.code), findsNothing);
    });

    testWidgets('narrow icon-only options still work', (tester) async {
      Brightness? picked;
      await _pumpHeader(tester, width: 500, onMode: (b) => picked = b);
      await tester.tap(find.byIcon(Icons.dark_mode_outlined));
      expect(picked, Brightness.dark);
    });

    testWidgets('compact keeps only the selected brand name', (tester) async {
      await _pumpHeader(tester, width: 640, brand: ckcoreBrand.skyGo);
      expect(find.text('SkyGo'), findsOneWidget);
      expect(find.text('CastleKeep'), findsNothing);
    });

    testWidgets('compact brand switching still works', (tester) async {
      ckcoreBrand? picked;
      await _pumpHeader(tester, width: 640, onBrand: (b) => picked = b);
      // The unselected brand is just a colour dot; tap its tooltip target.
      await tester.tap(find.byTooltip('Use the SkyGo brand'));
      expect(picked, ckcoreBrand.skyGo);
    });

    testWidgets('fits very narrow screens', (tester) async {
      await _pumpHeader(tester, width: 360);
      expect(tester.takeException(), isNull);
      // Brand names collapse to colour dots.
      expect(find.text('CastleKeep'), findsNothing);
      expect(find.text('ckcoreui'), findsNothing);
    });

    testWidgets('wide screens show the external links', (tester) async {
      await _pumpHeader(tester);
      expect(find.byIcon(Icons.code), findsOneWidget);
      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    });
  });

  group('docs app header', () {
    testWidgets('is a bar above the page, not an overlay', (tester) async {
      await _openDocs(tester);
      final header = tester.getRect(find.byType(DocsHeader));
      final title = tester.getRect(find.text('Get started with ckcoreui'));
      expect(header.top, 0);
      expect(title.top, greaterThanOrEqualTo(header.bottom));
    });

    testWidgets('starts on System and switches to Dark in one tap',
        (tester) async {
      await _openDocs(tester);
      expect(_theme(tester).brightness, Brightness.light); // test platform
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();
      expect(_theme(tester).isDark, isTrue);
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      expect(_theme(tester).isLight, isTrue);
    });

    testWidgets('System follows the platform brightness', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      await _openDocs(tester);
      expect(_theme(tester).isDark, isTrue);
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      expect(_theme(tester).isLight, isTrue);
      await tester.tap(find.text('System'));
      await tester.pumpAndSettle();
      expect(_theme(tester).isDark, isTrue);
    });

    testWidgets('switches brand in one tap', (tester) async {
      await _openDocs(tester);
      expect(_theme(tester).brand, ckcoreBrand.castleKeep);
      await tester.tap(find.text('SkyGo'));
      await tester.pumpAndSettle();
      expect(_theme(tester).brand, ckcoreBrand.skyGo);
    });

    testWidgets('keeps the choice when navigating pages', (tester) async {
      await _openDocs(tester);
      await tester.tap(find.text('SkyGo'));
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();
      currentRoute.value = '/buttons';
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(DocsHeader), findsOneWidget);
      expect(_theme(tester).brand, ckcoreBrand.skyGo);
      expect(_theme(tester).isDark, isTrue);
    });
  });

  group('snackbars over the header', () {
    Future<void> showSuccess(WidgetTester tester) async {
      currentRoute.value = '/feedback';
      await tester.pump(const Duration(milliseconds: 500));
      final button = find.widgetWithText(CKButton, 'success').first;
      await tester.ensureVisible(button);
      await tester.pump();
      await tester.tap(button);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
    }

    Future<void> finish(WidgetTester tester) async {
      await tester.pump(const Duration(seconds: 4));
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('floats above the header and is tappable', (tester) async {
      await _openDocs(tester);
      await showSuccess(tester);

      final toast = find.text('Snackbar: success');
      expect(toast, findsOneWidget);
      expect(toast.hitTestable(), findsOneWidget);

      final header = tester.getRect(find.byType(DocsHeader));
      final rect = tester.getRect(
        find.ancestor(of: toast, matching: find.byType(CKToast)).first,
      );
      expect(rect.height, greaterThanOrEqualTo(40), reason: 'not squashed');
      expect(rect.top, lessThan(header.bottom), reason: 'covers the header');
      await finish(tester);
    });

    testWidgets('floats above the sidebar on narrow windows', (tester) async {
      tester.view.physicalSize = const Size(700, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      currentRoute.value = '/';
      await tester.pumpWidget(const DocsApp());
      await tester.pump();
      await tester.tap(find.byType(SplashScreen));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 600));
      await showSuccess(tester);

      final sidebar = tester.getRect(find.byType(DocsSidebar));
      final rect = tester.getRect(
        find
            .ancestor(
              of: find.text('Snackbar: success'),
              matching: find.byType(CKToast),
            )
            .first,
      );
      expect(rect.left, lessThan(sidebar.right), reason: 'covers the sidebar');
      expect(find.text('Snackbar: success').hitTestable(), findsOneWidget);
      await finish(tester);
    });
  });
}
