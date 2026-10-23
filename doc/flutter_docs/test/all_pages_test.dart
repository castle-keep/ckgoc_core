import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ckcore_docs_app/pages/app_page.dart';
import 'package:ckcore_docs_app/pages/brand_icons_page.dart';
import 'package:ckcore_docs_app/pages/buttons_page.dart';
import 'package:ckcore_docs_app/pages/data_table_page.dart';
import 'package:ckcore_docs_app/pages/display_page.dart';
import 'package:ckcore_docs_app/pages/enums_page.dart';
import 'package:ckcore_docs_app/pages/feedback_page.dart';
import 'package:ckcore_docs_app/pages/foundation_page.dart';
import 'package:ckcore_docs_app/pages/inputs_page.dart';
import 'package:ckcore_docs_app/pages/navigation_page.dart';
import 'package:ckcore_docs_app/pages/overlays_page.dart';
import 'package:ckcore_docs_app/pages/overview_page.dart';
import 'package:ckcore_docs_app/pages/router_page.dart';
import 'package:ckcore_docs_app/pages/screen_layout_page.dart';
import 'package:ckcore_docs_app/pages/themes_page.dart';

Future<void> _pump(WidgetTester tester, Widget page, ckcoreBrand brand) async {
  tester.view.physicalSize = const Size(1600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(CKApp(
    brand: brand,
    debugShowCheckedModeBanner: false,
    home: page,
  ));
  // Some demos run endless animations, so settle for a fixed time instead.
  await tester.pump(const Duration(milliseconds: 600));
}

void main() {
  final pages = <String, Widget>{
    'app': const AppPage(),
    'brand icons': const BrandIconsPage(),
    'buttons': const ButtonsPage(),
    'data table': const DataTablePage(),
    'display': const DisplayPage(),
    'enums': const EnumsPage(),
    'feedback': const FeedbackPage(),
    'foundation': const FoundationPage(),
    'inputs': const InputsPage(),
    'navigation': const NavigationPage(),
    'overlays': const OverlaysPage(),
    'overview': const OverviewPage(),
    'router': const RouterDocsPage(),
    'screen layout': const ScreenLayoutPage(),
    'themes': const ThemesPage(),
  };

  for (final brand in ckcoreBrand.values) {
    for (final entry in pages.entries) {
      testWidgets('${entry.key} page renders (${brand.name})', (tester) async {
        await _pump(tester, entry.value, brand);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('no page is still marked Coming soon', (tester) async {
    for (final entry in pages.entries) {
      await _pump(tester, entry.value, ckcoreBrand.castleKeep);
      expect(find.text('Coming soon'), findsNothing,
          reason: '${entry.key} still has a Coming soon section');
    }
  });
}
