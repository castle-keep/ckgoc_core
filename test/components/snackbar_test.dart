import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

/// A page whose Scaffold is shorter than the window, like a page below a
/// fixed header.
Widget _pageBelowHeader(void Function(BuildContext) onTap) => Column(
  children: [
    const SizedBox(height: 56, child: Material(child: Text('header'))),
    Expanded(
      child: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: CKButton(
              onPressed: () => onTap(context),
              child: const Text('Show'),
            ),
          ),
        ),
      ),
    ),
  ],
);

Future<void> _show(
  WidgetTester tester,
  void Function(BuildContext) show, {
  bool belowHeader = true,
}) async {
  await pumpCK(
    tester,
    belowHeader
        ? _pageBelowHeader(show)
        : Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: CKButton(
                  onPressed: () => show(context),
                  child: const Text('Show'),
                ),
              ),
            ),
          ),
    fullScreen: true,
  );
  await tester.tap(find.text('Show'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

/// Lets a visible snackbar time out so no timers outlive the test.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 4));
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  group('CKSnackbar', () {
    testWidgets('shows at the top of a full-height Scaffold', (tester) async {
      await _show(
        tester,
        (c) => CKSnackbar.show(c, 'Saved'),
        belowHeader: false,
      );
      expect(find.text('Saved'), findsOneWidget);
      expect(tester.getTopLeft(find.byType(CKToast)).dy, lessThan(120));
      expect(tester.takeException(), isNull);
      await _settle(tester);
    });

    testWidgets('still shows when the Scaffold is shorter than the window', (
      tester,
    ) async {
      await _show(tester, (c) => CKSnackbar.show(c, 'Saved'));
      expect(find.text('Saved'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await _settle(tester);
    });

    testWidgets('floats above the header', (tester) async {
      await _show(tester, (c) => CKSnackbar.show(c, 'Saved'));
      final toast = tester.getRect(find.byType(CKToast));
      expect(toast.height, greaterThanOrEqualTo(40));
      // Overlaps the 56px header instead of sitting below it...
      expect(toast.top, lessThan(56));
      // ...and is the thing you hit when you tap there.
      expect(find.text('Saved').hitTestable(), findsOneWidget);
      expect(find.text('header').hitTestable(), findsNothing);
      await _settle(tester);
    });

    testWidgets('spans the window by default, even on wide screens', (
      tester,
    ) async {
      await pumpCK(
        tester,
        _pageBelowHeader((c) => CKSnackbar.show(c, 'Saved')),
        fullScreen: true,
        size: const Size(1600, 900),
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      final toast = tester.getRect(find.byType(CKToast));
      expect(toast.left, 12);
      expect(toast.right, 1588);
      await _settle(tester);
    });

    testWidgets('a given width is used and centered', (tester) async {
      await pumpCK(
        tester,
        _pageBelowHeader((c) => CKSnackbar.show(c, 'Saved', width: 400)),
        fullScreen: true,
        size: const Size(1600, 900),
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      final toast = tester.getRect(find.byType(CKToast));
      expect(toast.width, 400);
      expect(toast.center.dx, closeTo(800, 1));
      await _settle(tester);
    });

    testWidgets('a width larger than the window is limited to the window', (
      tester,
    ) async {
      await pumpCK(
        tester,
        _pageBelowHeader((c) => CKSnackbar.show(c, 'Saved', width: 2000)),
        fullScreen: true,
        size: const Size(600, 800),
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      final toast = tester.getRect(find.byType(CKToast));
      expect(toast.left, 12);
      expect(toast.right, 588);
      await _settle(tester);
    });

    testWidgets('uses the full width minus margins on narrow windows', (
      tester,
    ) async {
      await pumpCK(
        tester,
        _pageBelowHeader((c) => CKSnackbar.show(c, 'Saved')),
        fullScreen: true,
        size: const Size(360, 700),
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      final toast = tester.getRect(find.byType(CKToast));
      expect(toast.left, 12);
      expect(toast.right, 348);
      await _settle(tester);
    });

    testWidgets('covers nested Scaffolds and side panels', (tester) async {
      await pumpCK(
        tester,
        Row(
          children: [
            const SizedBox(width: 200, child: Material(child: Text('side'))),
            Expanded(
              child: Scaffold(
                body: Builder(
                  builder: (c) => Center(
                    child: CKButton(
                      onPressed: () => CKSnackbar.show(c, 'Saved'),
                      child: const Text('Show'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        fullScreen: true,
        size: const Size(500, 600),
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      // Spans over the side panel too (anchored to the window, not the page).
      expect(tester.getRect(find.byType(CKToast)).left, lessThan(200));
      await _settle(tester);
    });

    testWidgets('stays visible at any window height', (tester) async {
      for (final h in [500.0, 700.0, 1100.0]) {
        await pumpCK(
          tester,
          _pageBelowHeader((c) => CKSnackbar.show(c, 'Saved')),
          fullScreen: true,
          size: Size(1000, h),
        );
        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));
        expect(
          find.text('Saved').hitTestable(),
          findsOneWidget,
          reason: 'h=$h',
        );
        expect(
          tester.getRect(find.byType(CKToast)).height,
          greaterThanOrEqualTo(40),
        );
        await _settle(tester);
      }
    });

    testWidgets('accounts for a bottom navigation bar', (tester) async {
      await pumpCK(
        tester,
        Scaffold(
          bottomNavigationBar: const SizedBox(height: 80, child: Text('bar')),
          body: Builder(
            builder: (c) => Center(
              child: CKButton(
                onPressed: () => CKSnackbar.show(c, 'Saved'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
        fullScreen: true,
      );
      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Saved').hitTestable(), findsOneWidget);
      expect(tester.getRect(find.byType(CKToast)).top, greaterThanOrEqualTo(0));
      await _settle(tester);
    });

    testWidgets('bottom position still works', (tester) async {
      await _show(
        tester,
        (c) => CKSnackbar.show(c, 'Saved', position: CKSnackbarPosition.bottom),
      );
      expect(find.text('Saved'), findsOneWidget);
      expect(tester.getBottomLeft(find.byType(CKToast)).dy, greaterThan(500));
      await _settle(tester);
    });

    testWidgets('dismiss closes it', (tester) async {
      await _show(tester, (c) => CKSnackbar.show(c, 'Saved'));
      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(find.text('Saved'), findsNothing);
    });

    testWidgets('dismiss also calls onDismiss', (tester) async {
      var dismissed = 0;
      await _show(
        tester,
        (c) => CKSnackbar.show(c, 'Saved', onDismiss: () => dismissed++),
      );
      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pump(const Duration(seconds: 1));
      expect(dismissed, 1);
    });

    testWidgets('disappears by itself after its duration', (tester) async {
      await _show(
        tester,
        (c) =>
            CKSnackbar.show(c, 'Saved', duration: const Duration(seconds: 2)),
      );
      expect(find.text('Saved'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Saved'), findsNothing);
    });

    testWidgets('CKSnackbar.hide closes it', (tester) async {
      await _show(tester, (c) => CKSnackbar.show(c, 'Saved'));
      CKSnackbar.hide();
      await tester.pumpAndSettle();
      expect(find.text('Saved'), findsNothing);
    });

    testWidgets('keeps the brand theme in the overlay', (tester) async {
      await pumpCK(
        tester,
        Scaffold(
          body: Builder(
            builder: (c) => CKButton(
              onPressed: () =>
                  CKSnackbar.show(c, 'Saved', variant: ToastVariant.success),
              child: const Text('Show'),
            ),
          ),
        ),
        brand: ckcoreBrand.skyGo,
        brightness: Brightness.dark,
        fullScreen: true,
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
      expect(find.text('Saved'), findsOneWidget);
      await _settle(tester);
    });

    testWidgets('a second snackbar replaces the first', (tester) async {
      var n = 0;
      await _show(tester, (c) => CKSnackbar.show(c, 'Message ${n++}'));
      expect(find.text('Message 0'), findsOneWidget);
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(CKToast), findsOneWidget);
      expect(find.text('Message 0'), findsNothing);
      expect(find.text('Message 1'), findsOneWidget);
      await _settle(tester);
    });

    testWidgets('does not move when the Scaffold has an app bar', (
      tester,
    ) async {
      await pumpCK(
        tester,
        Scaffold(
          appBar: AppBar(title: const Text('t')),
          body: Builder(
            builder: (c) => Center(
              child: CKButton(
                onPressed: () => CKSnackbar.show(c, 'Saved'),
                child: const Text('Show'),
              ),
            ),
          ),
        ),
        fullScreen: true,
      );
      await tester.tap(find.text('Show'));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Saved').hitTestable(), findsOneWidget);
      await _settle(tester);
    });
  });
}
