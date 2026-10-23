import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  smokeMatrix({
    'CKAlert': () => const CKAlert(message: 'Heads up', title: 'Info'),
    'CKAlert.success': () => const CKAlert.success(message: 'Saved'),
    'CKAlert.warning': () => const CKAlert.warning(message: 'Careful'),
    'CKAlert.error': () => const CKAlert.error(message: 'Broke'),
    'CKToast': () => const CKToast(message: 'Toast'),
    'CKToast.success': () => const CKToast.success(message: 'Done'),
    'CKToast.error': () => const CKToast.error(message: 'Failed'),
    'CKToast.warning': () => const CKToast.warning(message: 'Hmm'),
    'CKToast.info': () => const CKToast.info(message: 'FYI'),
    'CKEmptyState': () => const CKEmptyState(
          title: 'Nothing here',
          description: 'Add something',
        ),
    'CKErrorState': () => CKErrorState(
          title: 'Oops',
          description: 'Try again',
          onRetry: () {},
        ),
    'CKSlider': () => CKSlider(value: 40, onChanged: (_) {}, showValue: true),
    'CKProgressBar': () => const CKProgressBar(value: 0.4, showValue: true),
    'CKProgressBar.success': () => const CKProgressBar.success(value: 1),
    'CKProgressBar.error': () => const CKProgressBar.error(value: 0.2),
  });

  // Animated indicators never settle, so these pump a single frame.
  smokeMatrix({
    'CKLoader': () => const CKLoader(),
    'CKLoader.ring': () => const CKLoader.ring(),
    'CKLoader.bar': () => const CKLoader.bar(),
    'CKLoader.dots': () => const CKLoader.dots(),
    'CKLoadingState': () => const CKLoadingState(message: 'Loading'),
    'CKProgressBar.indeterminate': () => const CKProgressBar.indeterminate(),
    'CKSkeleton': () => const CKSkeleton(width: 120, height: 16),
  }, settle: false);

  group('CKAlert', () {
    testWidgets('shows title and message', (tester) async {
      await pumpCK(tester, const CKAlert(message: 'Body text', title: 'Head'));
      expect(find.text('Head'), findsOneWidget);
      expect(find.text('Body text'), findsOneWidget);
    });

    testWidgets('dismiss callback fires', (tester) async {
      var dismissed = 0;
      await pumpCK(
        tester,
        CKAlert(message: 'Bye', onDismiss: () => dismissed++),
      );
      await tester.tap(find.byIcon(LucideIcons.x));
      expect(dismissed, 1);
    });
  });

  group('CKToast', () {
    testWidgets('shows message and fires onDismiss', (tester) async {
      var dismissed = 0;
      await pumpCK(
        tester,
        CKToast.success(message: 'Saved!', onDismiss: () => dismissed++),
      );
      expect(find.text('Saved!'), findsOneWidget);
      await tester.tap(find.byIcon(LucideIcons.x));
      expect(dismissed, 1);
    });
  });

  group('states', () {
    testWidgets('error state shows title/description and retry fires',
        (tester) async {
      var retries = 0;
      await pumpCK(
        tester,
        CKErrorState(
          title: 'Oops',
          description: 'Something broke',
          onRetry: () => retries++,
        ),
      );
      expect(find.text('Oops'), findsOneWidget);
      expect(find.text('Something broke'), findsOneWidget);
      await tester.tap(find.byType(CKButton));
      expect(retries, 1);
    });

    testWidgets('error state has no retry button without onRetry',
        (tester) async {
      await pumpCK(tester, const CKErrorState(title: 'Oops'));
      expect(find.byType(CKButton), findsNothing);
    });

    testWidgets('error state supports a custom icon and retry label',
        (tester) async {
      await pumpCK(
        tester,
        CKErrorState(
          title: 'Offline',
          icon: LucideIcons.wifiOff,
          retryLabel: 'Reconnect',
          onRetry: () {},
        ),
      );
      expect(find.byIcon(LucideIcons.wifiOff), findsOneWidget);
      expect(find.text('Reconnect'), findsOneWidget);
    });

    testWidgets('empty state shows title and description', (tester) async {
      await pumpCK(
        tester,
        const CKEmptyState(title: 'Empty', description: 'Nothing yet'),
      );
      expect(find.text('Empty'), findsOneWidget);
      expect(find.text('Nothing yet'), findsOneWidget);
      expect(find.byIcon(LucideIcons.inbox), findsOneWidget);
    });

    testWidgets('empty state shows a custom illustration and action',
        (tester) async {
      await pumpCK(
        tester,
        CKEmptyState(
          title: 'Empty',
          illustration: const Text('art'),
          action: CKButton(onPressed: () {}, child: const Text('Add')),
        ),
      );
      expect(find.text('art'), findsOneWidget);
      expect(find.byIcon(LucideIcons.inbox), findsNothing);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('loading state shows its message', (tester) async {
      await pumpCK(
        tester,
        const CKLoadingState(message: 'Please wait'),
        settle: false,
      );
      expect(find.text('Please wait'), findsOneWidget);
    });
  });

  group('CKSkeleton', () {
    testWidgets('has the requested size', (tester) async {
      await pumpCK(
        tester,
        const Align(
          alignment: Alignment.topLeft,
          child: CKSkeleton(width: 120, height: 16),
        ),
        settle: false,
      );
      expect(tester.getSize(find.byType(CKSkeleton)), const Size(120, 16));
    });

    testWidgets('does not animate under reduced motion', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: CKApp(
            brand: ckcoreBrand.castleKeep,
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: CKSkeleton(width: 50, height: 10)),
          ),
        ),
      );
      // Would time out if a repeating animation were running.
      await tester.pumpAndSettle();
    });
  });

  group('CKSlider', () {
    testWidgets('reports changes when dragged', (tester) async {
      double? latest;
      await pumpCK(
        tester,
        CKSlider(value: 0, onChanged: (v) => latest = v),
      );
      await tester.drag(find.byType(Slider), const Offset(200, 0));
      await tester.pump();
      expect(latest, isNotNull);
      expect(latest, greaterThan(0));
    });
  });

  group('CKProgressBar', () {
    testWidgets('shows the percentage when showValue is true', (tester) async {
      await pumpCK(tester, const CKProgressBar(value: 0.5, showValue: true));
      expect(find.textContaining('50'), findsWidgets);
    });
  });
}
