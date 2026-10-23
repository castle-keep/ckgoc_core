import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {bool disableAnimations = false}) => CKApp(
      brand: ckcoreBrand.castleKeep,
      debugShowCheckedModeBanner: false,
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: disableAnimations),
        child: Scaffold(body: child),
      ),
    );

double _opacity(WidgetTester t) => t
    .widget<Opacity>(
      find.descendant(of: find.byType(CKAnimate), matching: find.byType(Opacity)),
    )
    .opacity;

void main() {
  testWidgets('fades in over the theme duration', (tester) async {
    await tester.pumpWidget(_app(const CKAnimate(child: Text('hi'))));
    expect(_opacity(tester), 0);
    await tester.pump(const Duration(milliseconds: 150));
    expect(_opacity(tester), inInclusiveRange(0.01, 0.99));
    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('delay holds the child hidden', (tester) async {
    await tester.pumpWidget(_app(const CKAnimate(
      delay: Duration(milliseconds: 500),
      child: Text('hi'),
    )));
    await tester.pump(const Duration(milliseconds: 400));
    expect(_opacity(tester), 0);
    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('trigger change replays', (tester) async {
    Widget build(int n) =>
        _app(CKAnimate(trigger: n, child: const Text('hi')));
    await tester.pumpWidget(build(0));
    await tester.pumpAndSettle();
    await tester.pumpWidget(build(1));
    expect(_opacity(tester), 0);
    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('reduced motion shows child immediately', (tester) async {
    await tester.pumpWidget(
      _app(const CKAnimate(child: Text('hi')), disableAnimations: true),
    );
    expect(_opacity(tester), 1);
  });

  testWidgets('stagger wraps every child', (tester) async {
    final list = CKAnimate.stagger(children: const [Text('a'), Text('b')]);
    expect(list, hasLength(2));
    expect((list[1] as CKAnimate).delay, const Duration(milliseconds: 60));
  });
}
