import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  smokeMatrix({
    'CKTextField': () => const CKTextField(label: 'Email', hint: 'you@x.com'),
    'CKTextField error': () =>
        const CKTextField(label: 'Email', errorText: 'Required'),
    'CKTextField success': () =>
        const CKTextField(label: 'Email', successText: 'Looks good'),
    'CKTextField disabled': () =>
        const CKTextField(label: 'Email', enabled: false),
    'CKTextField multiline': () => const CKTextField(label: 'Bio', maxLines: 3),
    'CKPasswordField': () => const CKPasswordField(label: 'Password'),
    'CKSearchField': () => const CKSearchField(hint: 'Search'),
    'CKNumberStepper': () =>
        CKNumberStepper(value: 3, min: 0, max: 10, onChanged: (_) {}),
    'CKCheckbox': () =>
        CKCheckbox(value: true, label: 'Agree', onChanged: (_) {}),
    'CKCheckbox unchecked': () =>
        CKCheckbox(value: false, label: 'Agree', onChanged: (_) {}),
    'CKSwitch': () => CKSwitch(value: true, label: 'On', onChanged: (_) {}),
    'CKSwitch.success': () =>
        CKSwitch.success(value: true, onChanged: (_) {}),
    'CKSwitch.error': () => CKSwitch.error(value: true, onChanged: (_) {}),
    'CKOtpField': () => const CKOtpField(length: 4),
    'CKDatePicker': () => CKDatePicker(label: 'Date', onChanged: (_) {}),
    'CKDatePicker month': () => CKDatePicker(
          label: 'Month',
          mode: CKDatePickerMode.month,
          onChanged: (_) {},
        ),
    'CKDatePicker preset': () => CKDatePicker(
          label: 'Date',
          value: DateTime(2024, 5, 17),
          onChanged: (_) {},
        ),
    'CKTimePicker': () => CKTimePicker(label: 'Time', onChanged: (_) {}),
  });

  group('CKTextField', () {
    testWidgets('reports typed text through onChanged', (tester) async {
      String? latest;
      await pumpCK(
        tester,
        CKTextField(label: 'Name', onChanged: (v) => latest = v),
      );
      await tester.enterText(find.byType(TextField), 'Ada');
      expect(latest, 'Ada');
    });

    testWidgets('writes to a provided controller', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      await pumpCK(tester, CKTextField(controller: controller));
      await tester.enterText(find.byType(TextField), 'hello');
      expect(controller.text, 'hello');
    });

    testWidgets('shows label, helper and error text', (tester) async {
      await pumpCK(
        tester,
        const CKTextField(
          label: 'Email',
          helperText: 'We never share it',
          errorText: 'Required',
        ),
      );
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('does not accept input when disabled', (tester) async {
      String? latest;
      await pumpCK(
        tester,
        CKTextField(enabled: false, onChanged: (v) => latest = v),
      );
      await tester.enterText(find.byType(TextField), 'nope');
      expect(latest, isNull);
    });
  });

  group('CKPasswordField', () {
    testWidgets('obscures text by default', (tester) async {
      await pumpCK(tester, const CKPasswordField(label: 'Password'));
      final field = tester.widget<EditableText>(find.byType(EditableText));
      expect(field.obscureText, isTrue);
    });

    testWidgets('reports typed text', (tester) async {
      String? latest;
      await pumpCK(
        tester,
        CKPasswordField(onChanged: (v) => latest = v),
      );
      await tester.enterText(find.byType(TextField), 'secret');
      expect(latest, 'secret');
    });
  });

  group('CKSearchField', () {
    testWidgets('reports typed text', (tester) async {
      String? latest;
      await pumpCK(tester, CKSearchField(onChanged: (v) => latest = v));
      await tester.enterText(find.byType(TextField), 'query');
      expect(latest, 'query');
    });
  });

  group('CKCheckbox', () {
    testWidgets('toggles via onChanged', (tester) async {
      bool? latest;
      await pumpCK(
        tester,
        CKCheckbox(value: false, label: 'Agree', onChanged: (v) => latest = v),
      );
      await tester.tap(find.text('Agree'));
      expect(latest, isTrue);
    });
  });

  group('CKSwitch', () {
    testWidgets('toggles via onChanged', (tester) async {
      bool? latest;
      await pumpCK(
        tester,
        CKSwitch(value: false, onChanged: (v) => latest = v),
      );
      await tester.tap(find.byType(Switch));
      expect(latest, isTrue);
    });

    testWidgets('shows its label', (tester) async {
      await pumpCK(
        tester,
        CKSwitch(value: false, label: 'Notifications', onChanged: (_) {}),
      );
      expect(find.text('Notifications'), findsOneWidget);
    });
  });

  group('CKOtpField', () {
    testWidgets('captures input with a single hidden field', (tester) async {
      await pumpCK(tester, const CKOtpField(length: 4));
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('reports changes and completes at the full length',
        (tester) async {
      final changes = <String>[];
      String? completed;
      await pumpCK(
        tester,
        CKOtpField(
          length: 4,
          onChanged: changes.add,
          onCompleted: (v) => completed = v,
        ),
      );
      await tester.enterText(find.byType(TextField), '12');
      expect(changes.last, '12');
      expect(completed, isNull);
      await tester.enterText(find.byType(TextField), '1234');
      expect(completed, '1234');
    });

    testWidgets('ignores non-numeric input', (tester) async {
      String? latest;
      await pumpCK(tester, CKOtpField(length: 4, onChanged: (v) => latest = v));
      await tester.enterText(find.byType(TextField), 'ab');
      expect(latest ?? '', isEmpty);
    });
  });

  group('CKNumberStepper', () {
    testWidgets('shows the current value', (tester) async {
      await pumpCK(
        tester,
        CKNumberStepper(value: 7, onChanged: (_) {}),
      );
      expect(find.text('7'), findsOneWidget);
    });
  });
}
