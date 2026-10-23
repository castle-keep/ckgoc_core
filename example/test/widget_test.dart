import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:showcase/main.dart';

const _sections = [
  'Tokens',
  'Buttons',
  'Inputs',
  'Display',
  'Data Table',
  'Feedback',
  'Navigation',
  'Overlays',
  'Layout',
];

/// Layout errors collected while a test runs.
///
/// `flutter_test` renders text with the wide Ahem font, so tight rows can
/// report RenderFlex overflows that do not occur with the real fonts. Those
/// are ignored here; any other framework error still fails the test.
final _errors = <FlutterErrorDetails>[];

void _collectErrors() {
  _errors.clear();
  final original = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('RenderFlex overflowed')) return;
    _errors.add(details);
  };
  addTearDown(() => FlutterError.onError = original);
}

Future<void> _pumpApp(WidgetTester tester) async {
  _collectErrors();
  tester.view.physicalSize = const Size(1600, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ShowcaseApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('launches on the Tokens section with the SkyGo brand',
      (tester) async {
    await _pumpApp(tester);
    expect(find.text('Company UI Showcase'), findsOneWidget);
    expect(_errors, isEmpty);
    final context = tester.element(find.byType(Scaffold).first);
    expect(context.ckcoreTheme.brand, ckcoreBrand.skyGo);
  });

  for (final section in _sections) {
    testWidgets('opens the $section section without errors', (tester) async {
      await _pumpApp(tester);
      await tester.tap(find.text(section));
      // Some sections have endless spinners, so pump a fixed time instead of
      // settling.
      await tester.pump(const Duration(milliseconds: 500));
      expect(_errors, isEmpty);
    });
  }

  testWidgets('brand dropdown switches the theme', (tester) async {
    await _pumpApp(tester);
    await tester.tap(find.byType(DropdownButton<ckcoreBrand>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CastleKeep').last);
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(Scaffold).first);
    expect(context.ckcoreTheme.brand, ckcoreBrand.castleKeep);
  });

  testWidgets('dark/light switch changes the brightness', (tester) async {
    await _pumpApp(tester);
    final before = tester.element(find.byType(Scaffold).first).ckcoreTheme;
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    final after = tester.element(find.byType(Scaffold).first).ckcoreTheme;
    expect(after.brightness, isNot(before.brightness));
  });
}
