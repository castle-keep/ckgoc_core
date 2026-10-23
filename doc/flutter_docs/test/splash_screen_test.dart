import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ckcore_docs_app/main.dart';
import 'package:ckcore_docs_app/pages/splash_screen.dart';

void main() {
  testWidgets('shows the name and tagline', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      CKApp(
        brand: ckcoreBrand.castleKeep,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          brand: ckcoreBrand.castleKeep,
          duration: const Duration(milliseconds: 1000),
          onDone: () {},
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('ckcoreui'), findsOneWidget);
    expect(find.text('Design system for Flutter'), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('finishes by itself after its duration', (tester) async {
    var done = 0;
    await tester.pumpWidget(
      CKApp(
        brand: ckcoreBrand.castleKeep,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          brand: ckcoreBrand.castleKeep,
          duration: const Duration(milliseconds: 1000),
          onDone: () => done++,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 900));
    expect(done, 0);
    await tester.pump(const Duration(milliseconds: 200));
    expect(done, 1);
    await tester.pumpAndSettle();
  });

  testWidgets('tap skips it, once', (tester) async {
    var done = 0;
    await tester.pumpWidget(
      CKApp(
        brand: ckcoreBrand.castleKeep,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          brand: ckcoreBrand.castleKeep,
          onDone: () => done++,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('ckcoreui'));
    await tester.tap(find.text('ckcoreui'), warnIfMissed: false);
    expect(done, 1);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(done, 1);
  });

  testWidgets('any key skips it', (tester) async {
    var done = 0;
    await tester.pumpWidget(
      CKApp(
        brand: ckcoreBrand.castleKeep,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          brand: ckcoreBrand.castleKeep,
          onDone: () => done++,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    expect(done, 1);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('is skipped under reduced motion', (tester) async {
    var done = 0;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: CKApp(
          brand: ckcoreBrand.castleKeep,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            brand: ckcoreBrand.castleKeep,
            onDone: () => done++,
          ),
        ),
      ),
    );
    // onDone fires from a post-frame callback, not after the duration.
    await tester.pump();
    await tester.pump();
    expect(done, 1);
  });

  testWidgets('docs app opens on the splash, then the docs', (tester) async {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const DocsApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Get started with ckcoreui'), findsNothing);

    await tester.tap(find.byType(SplashScreen));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.text('Get started with ckcoreui'), findsOneWidget);
  });
}
