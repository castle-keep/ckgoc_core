import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  smokeMatrix({
    'CKDialog': () => const CKDialog(title: 'Title', content: Text('Body')),
    'CKDialog.destructive': () => const CKDialog.destructive(
          title: 'Delete?',
          content: Text('This cannot be undone'),
        ),
    'CKBottomSheet': () => const CKBottomSheet(
          title: 'Sheet',
          children: [Text('One'), Text('Two')],
        ),
    'CKMenu': () => CKMenu(
          trigger: const Text('Open'),
          items: [CKMenuItem(label: 'Edit', onTap: () {})],
        ),
  });

  group('CKDialog', () {
    testWidgets('confirm and cancel fire their callbacks', (tester) async {
      var confirmed = 0, cancelled = 0;
      await pumpCK(
        tester,
        CKDialog(
          title: 'Sure?',
          content: const Text('Body'),
          confirmLabel: 'Yes',
          cancelLabel: 'No',
          onConfirm: () => confirmed++,
          onCancel: () => cancelled++,
        ),
      );
      await tester.tap(find.text('Yes'));
      expect(confirmed, 1);
      await tester.tap(find.text('No'));
      expect(cancelled, 1);
    });

    testWidgets('CKDialog.show opens and a button closes it', (tester) async {
      await pumpCK(
        tester,
        Builder(
          builder: (context) => CKButton(
            onPressed: () => CKDialog.show<void>(
              context: context,
              title: 'Hello',
              content: const Text('Dialog body'),
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Dialog body'), findsOneWidget);

      // No action callbacks were given, so only the close icon is shown.
      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pumpAndSettle();
      expect(find.text('Dialog body'), findsNothing);
    });
  });

  group('CKDialog.destructive', () {
    testWidgets('long default label does not overflow', (tester) async {
      await pumpCK(
        tester,
        Builder(
          builder: (context) => CKButton(
            onPressed: () => CKDialog.showDestructive<void>(
              context: context,
              title: 'Delete?',
              content: const Text('This cannot be undone'),
              onConfirm: () {},
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.textContaining('Delete Permanently'), findsOneWidget);
    });
  });

  group('CKBottomSheet', () {
    testWidgets('CKBottomSheet.show displays its children', (tester) async {
      await pumpCK(
        tester,
        Builder(
          builder: (context) => CKButton(
            onPressed: () => CKBottomSheet.show<void>(
              context: context,
              title: 'Pick one',
              children: const [Text('Option A')],
            ),
            child: const Text('Open'),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Option A'), findsOneWidget);
    });
  });

  group('CKMenu', () {
    testWidgets('opens on tap and fires the item callback', (tester) async {
      var edits = 0;
      await pumpCK(
        tester,
        CKMenu(
          trigger: const Text('Open'),
          items: [CKMenuItem(label: 'Edit', onTap: () => edits++)],
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Edit'), findsOneWidget);
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(edits, 1);
    });
  });
}
