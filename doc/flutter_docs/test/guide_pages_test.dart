import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ckcore_docs_app/pages/ai_tools_page.dart';
import 'package:ckcore_docs_app/pages/animate_page.dart';
import 'package:ckcore_docs_app/pages/getting_started_page.dart';

void main() {
  final pages = <String, Widget>{
    'getting started': const GettingStartedPage(),
    'ai tools': const AiToolsPage(),
    'animate': const AnimatePage(),
  };

  for (final brand in ckcoreBrand.values) {
    for (final entry in pages.entries) {
      testWidgets('${entry.key} renders for ${brand.name}', (tester) async {
        tester.view.physicalSize = const Size(1600, 1200);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(CKApp(brand: brand, home: entry.value));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('ai tools config follows the selected client', (tester) async {
    tester.view.physicalSize = const Size(1600, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const CKApp(brand: ckcoreBrand.castleKeep, home: AiToolsPage()),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('"servers"'), findsWidgets);

    await tester.tap(find.text('Claude Code'));
    await tester.pumpAndSettle();
    expect(find.textContaining('claude mcp add ckcoreui'), findsWidgets);
    expect(find.textContaining('"servers"'), findsNothing);
  });
}
