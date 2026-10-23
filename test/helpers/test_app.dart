import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Brand/brightness combinations every component is exercised under.
const themeMatrix = <(ckcoreBrand, Brightness)>[
  (ckcoreBrand.castleKeep, Brightness.light),
  (ckcoreBrand.castleKeep, Brightness.dark),
  (ckcoreBrand.skyGo, Brightness.light),
  (ckcoreBrand.skyGo, Brightness.dark),
];

String themeLabel((ckcoreBrand, Brightness) t) => '${t.$1.name}/${t.$2.name}';

/// Pumps [child] inside [CKApp] on a large surface.
///
/// With [fullScreen] the child is the app's home (for layouts and
/// other widgets that bring their own Scaffold). Otherwise it is placed in a
/// scrollable Scaffold body with bounded width.
Future<void> pumpCK(
  WidgetTester tester,
  Widget child, {
  ckcoreBrand brand = ckcoreBrand.castleKeep,
  Brightness brightness = Brightness.light,
  bool fullScreen = false,
  Size size = const Size(1200, 900),
  bool settle = true,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    CKApp(
      brand: brand,
      brightness: brightness,
      debugShowCheckedModeBanner: false,
      home: fullScreen
          ? child
          : Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(width: 720, child: child),
                ),
              ),
            ),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
}

/// Registers one smoke test per theme combination for each entry: the widget
/// must build, lay out and paint without throwing, and be found in the tree.
void smokeMatrix(
  Map<String, Widget Function()> widgets, {
  bool fullScreen = false,
  bool settle = true,
}) {
  for (final entry in widgets.entries) {
    for (final theme in themeMatrix) {
      testWidgets('${entry.key} renders (${themeLabel(theme)})', (tester) async {
        final widget = entry.value();
        await pumpCK(
          tester,
          widget,
          brand: theme.$1,
          brightness: theme.$2,
          fullScreen: fullScreen,
          settle: settle,
        );
        expect(tester.takeException(), isNull);
        expect(find.byWidget(widget), findsOneWidget);
      });
    }
  }
}
