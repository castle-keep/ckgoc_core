import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  group('CKApp', () {
    testWidgets('provides the brand theme to its subtree', (tester) async {
      late CkcoreuiThemeData data;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          data = c.ckcoreTheme;
          return const SizedBox();
        }),
        brand: ckcoreBrand.skyGo,
      );
      expect(data.brand, ckcoreBrand.skyGo);
    });

    testWidgets('forces brightness when given', (tester) async {
      late CkcoreuiThemeData data;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          data = c.ckcoreTheme;
          return const SizedBox();
        }),
        brightness: Brightness.dark,
      );
      expect(data.isDark, isTrue);
    });

    testWidgets('follows the platform brightness when null', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      late CkcoreuiThemeData data;
      await tester.pumpWidget(
        CKApp(
          brand: ckcoreBrand.castleKeep,
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (c) {
            data = c.ckcoreTheme;
            return const SizedBox();
          }),
        ),
      );
      expect(data.isDark, isTrue);
    });

    testWidgets('rebuilds with the new theme when brand changes', (tester) async {
      final brand = ValueNotifier(ckcoreBrand.castleKeep);
      addTearDown(brand.dispose);
      Color? primary;
      await tester.pumpWidget(
        ValueListenableBuilder<ckcoreBrand>(
          valueListenable: brand,
          builder: (_, b, __) => CKApp(
            brand: b,
            brightness: Brightness.light,
            debugShowCheckedModeBanner: false,
            home: Builder(builder: (c) {
              primary = c.ckColors.primary;
              return const SizedBox();
            }),
          ),
        ),
      );
      final before = primary;
      brand.value = ckcoreBrand.skyGo;
      await tester.pumpAndSettle();
      expect(primary, isNot(before));
    });

    testWidgets('uses the given title and home', (tester) async {
      await tester.pumpWidget(
        const CKApp(
          brand: ckcoreBrand.castleKeep,
          title: 'My App',
          debugShowCheckedModeBanner: false,
          home: Text('home', textDirection: TextDirection.ltr),
        ),
      );
      expect(find.text('home'), findsOneWidget);
      expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).title, 'My App');
    });

    testWidgets('supports named routes', (tester) async {
      await tester.pumpWidget(
        CKApp(
          brand: ckcoreBrand.castleKeep,
          debugShowCheckedModeBanner: false,
          initialRoute: '/two',
          routes: {
            '/': (_) => const Text('one', textDirection: TextDirection.ltr),
            '/two': (_) => const Text('two', textDirection: TextDirection.ltr),
          },
        ),
      );
      expect(find.text('two'), findsOneWidget);
    });

    testWidgets('CKApp.router builds from a RouterConfig', (tester) async {
      final config = RouterConfig<Object>(
        routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(uri: Uri.parse('/')),
        ),
        routeInformationParser: _Parser(),
        routerDelegate: _Delegate(),
      );
      await tester.pumpWidget(
        CKApp.router(
          brand: ckcoreBrand.skyGo,
          debugShowCheckedModeBanner: false,
          routerConfig: config,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('routed'), findsOneWidget);
    });
  });

  group('deprecated ckcoreApp', () {
    testWidgets('still provides the theme', (tester) async {
      late CkcoreuiThemeData data;
      await tester.pumpWidget(
        // ignore: deprecated_member_use_from_same_package
        ckcoreApp(
          brand: ckcoreBrand.skyGo,
          child: Builder(builder: (c) {
            data = c.ckcoreTheme;
            return const SizedBox();
          }),
        ),
      );
      expect(data.brand, ckcoreBrand.skyGo);
    });
  });

  group('theme lookup without CKApp', () {
    testWidgets('ckcoreTheme asserts when no theme is present', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(builder: (c) {
            c.ckcoreTheme;
            return const SizedBox();
          }),
        ),
      );
      expect(tester.takeException(), isA<AssertionError>());
    });
  });
}

class _Parser extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(RouteInformation info) async => Object();
}

class _Delegate extends RouterDelegate<Object> with ChangeNotifier {
  @override
  Widget build(BuildContext context) =>
      const Text('routed', textDirection: TextDirection.ltr);

  @override
  Future<bool> popRoute() async => false;

  @override
  Future<void> setNewRoutePath(Object configuration) async {}
}
