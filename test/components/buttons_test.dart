import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  smokeMatrix({
    for (final v in ButtonVariant.values)
      'CKButton ${v.name}': () => CKButton(
            variant: v,
            onPressed: () {},
            child: Text('Button ${v.name}'),
          ),
    for (final s in ButtonSize.values)
      'CKButton size ${s.name}': () => CKButton(
            size: s,
            onPressed: () {},
            child: const Text('Sized'),
          ),
    'CKButton.outline': () =>
        CKButton.outline(onPressed: () {}, child: const Text('Outline')),
    'CKButton.ghost': () =>
        CKButton.ghost(onPressed: () {}, child: const Text('Ghost')),
    'CKButton.destructive': () =>
        CKButton.destructive(onPressed: () {}, child: const Text('Delete')),
    'CKButton full width': () => CKButton(
          isFullWidth: true,
          onPressed: () {},
          child: const Text('Wide'),
        ),
    'CKIconButton': () =>
        CKIconButton(icon: Icons.add, onPressed: () {}, tooltip: 'Add'),
    'CKFab': () => CKFab(icon: Icons.add, onPressed: () {}),
    'CKFab extended': () =>
        CKFab(icon: Icons.add, label: 'Create', onPressed: () {}),
  });

  group('CKButton', () {
    testWidgets('calls onPressed when tapped', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKButton(onPressed: () => taps++, child: const Text('Go')),
      );
      await tester.tap(find.text('Go'));
      expect(taps, 1);
    });

    testWidgets('does not fire when disabled', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKButton(
          disabled: true,
          onPressed: () => taps++,
          child: const Text('Go'),
        ),
      );
      await tester.tap(find.text('Go'), warnIfMissed: false);
      expect(taps, 0);
    });

    testWidgets('does not fire when loading', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKButton(
          loading: true,
          onPressed: () => taps++,
          child: const Text('Go'),
        ),
        settle: false,
      );
      await tester.tap(find.byType(CKButton), warnIfMissed: false);
      expect(taps, 0);
    });

    testWidgets('does not throw without onPressed', (tester) async {
      await pumpCK(tester, const CKButton(child: Text('Inert')));
      await tester.tap(find.text('Inert'), warnIfMissed: false);
      expect(tester.takeException(), isNull);
    });

    testWidgets('isFullWidth fills the available width', (tester) async {
      await pumpCK(
        tester,
        CKButton(
          isFullWidth: true,
          onPressed: () {},
          child: const Text('Wide'),
        ),
      );
      expect(tester.getSize(find.byType(CKButton)).width, 720);
    });
  });

  group('CKButton motion', () {
    Matrix4 motion(WidgetTester tester) => tester
        .widget<AnimatedContainer>(
          find
              .descendant(
                of: find.byType(CKButton),
                matching: find.byType(AnimatedContainer),
              )
              .last,
        )
        .transform!;

    Future<TestGesture> mouse(WidgetTester tester, Finder target) async {
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(gesture.removePointer);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(target));
      await tester.pump(const Duration(milliseconds: 300));
      return gesture;
    }

    testWidgets('floats up on hover by default', (tester) async {
      await pumpCK(tester, CKButton(onPressed: () {}, child: const Text('Go')));
      expect(motion(tester).getTranslation().y, 0);
      await mouse(tester, find.text('Go'));
      expect(motion(tester).getTranslation().y, lessThan(0));
    });

    testWidgets('settles back when the pointer leaves', (tester) async {
      await pumpCK(tester, CKButton(onPressed: () {}, child: const Text('Go')));
      final gesture = await mouse(tester, find.text('Go'));
      await gesture.moveTo(const Offset(1100, 850));
      await tester.pump(const Duration(milliseconds: 300));
      expect(motion(tester).getTranslation().y, 0);
    });

    testWidgets('hoverStyle.none does not move', (tester) async {
      await pumpCK(
        tester,
        CKButton(
          hoverStyle: ButtonHoverStyle.none,
          onPressed: () {},
          child: const Text('Go'),
        ),
      );
      await mouse(tester, find.text('Go'));
      expect(motion(tester).getTranslation().y, 0);
      expect(motion(tester).storage[0], 1);
    });

    testWidgets('hoverStyle.grow scales up without lifting', (tester) async {
      await pumpCK(
        tester,
        CKButton(
          hoverStyle: ButtonHoverStyle.grow,
          onPressed: () {},
          child: const Text('Go'),
        ),
      );
      await mouse(tester, find.text('Go'));
      expect(motion(tester).getTranslation().y, 0);
      expect(motion(tester).storage[0], greaterThan(1));
    });

    testWidgets('scales down while pressed and recovers on release',
        (tester) async {
      await pumpCK(tester, CKButton(onPressed: () {}, child: const Text('Go')));
      final gesture = await tester.startGesture(tester.getCenter(find.text('Go')));
      await tester.pump(const Duration(milliseconds: 150));
      expect(motion(tester).storage[0], lessThan(1));
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 300));
      expect(motion(tester).storage[0], 1);
    });

    testWidgets('disabled buttons do not animate', (tester) async {
      await pumpCK(
        tester,
        const CKButton(disabled: true, child: Text('Go')),
      );
      await mouse(tester, find.text('Go'));
      expect(motion(tester).getTranslation().y, 0);
      expect(motion(tester).storage[0], 1);
    });

    testWidgets('tap still fires after the press animation', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKButton(onPressed: () => taps++, child: const Text('Go')),
      );
      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();
      expect(taps, 1);
    });

    testWidgets('reduced motion removes the animation duration',
        (tester) async {
      await pumpCK(
        tester,
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: CKButton(onPressed: () {}, child: const Text('Go')),
        ),
      );
      final container = tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(CKButton),
              matching: find.byType(AnimatedContainer),
            )
            .last,
      );
      expect(container.duration, Duration.zero);
    });
  });

  group('CKButton layout', () {
    testWidgets('full-width button with a long label wraps instead of overflowing',
        (tester) async {
      await pumpCK(
        tester,
        SizedBox(
          width: 200,
          child: CKButton(
            isFullWidth: true,
            onPressed: () {},
            child: const Text('Yes, Delete Permanently And Forever'),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('CKIconButton / CKFab', () {
    testWidgets('icon button fires onPressed', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKIconButton(icon: Icons.add, onPressed: () => taps++),
      );
      await tester.tap(find.byIcon(Icons.add));
      expect(taps, 1);
    });

    testWidgets('fab fires onPressed and shows its label', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKFab(icon: Icons.add, label: 'Create', onPressed: () => taps++),
      );
      expect(find.text('Create'), findsOneWidget);
      await tester.tap(find.text('Create'));
      expect(taps, 1);
    });
  });
}
