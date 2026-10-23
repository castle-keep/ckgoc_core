import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

const _navItems = [
  CKNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
  CKNavItem(icon: Icons.search, label: 'Search'),
  CKNavItem(icon: Icons.person_outline, label: 'Profile'),
];

void main() {
  smokeMatrix({
    'CKListTile': () => const CKListTile(
          title: Text('Row'),
          subtitle: Text('Sub'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.chevron_right),
        ),
    'CKTimePicker': () => CKTimePicker(label: 'Time', onChanged: (_) {}),
    'CKTimePicker preset': () => CKTimePicker(
          label: 'Time',
          value: const TimeOfDay(hour: 9, minute: 30),
          onChanged: (_) {},
        ),
    'CKBreadcrumb': () => const CKBreadcrumb(
          items: [BreadcrumbItem(label: 'Home'), BreadcrumbItem(label: 'Page')],
        ),
    'CKTooltip': () => const CKTooltip(message: 'Tip', child: Text('Hover')),
    'CKPopover': () => const CKPopover(
          trigger: Text('Open'),
          content: Text('Content'),
        ),
  });

  group('CKDivider', () {
    testWidgets('horizontal divider is a 1px line spanning the width',
        (tester) async {
      await pumpCK(tester, const CKDivider());
      final size = tester.getSize(find.byType(Divider));
      expect(size.height, 1);
      expect(size.width, 720);
    });

    testWidgets('vertical divider is a 1px line spanning the height',
        (tester) async {
      await pumpCK(
        tester,
        const Align(
          alignment: Alignment.topLeft,
          child: SizedBox(height: 40, child: CKDivider(direction: Axis.vertical)),
        ),
      );
      final size = tester.getSize(find.byType(VerticalDivider));
      expect(size.width, 1);
      expect(size.height, 40);
    });

    testWidgets('uses the theme outline colour', (tester) async {
      late ckcoreColors colors;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          colors = c.ckColors;
          return const CKDivider();
        }),
      );
      expect(tester.widget<Divider>(find.byType(Divider)).color,
          colors.outlineVariant);
    });
  });

  group('CKListTile', () {
    testWidgets('shows title, subtitle, leading and trailing', (tester) async {
      await pumpCK(
        tester,
        const CKListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.chevron_right),
        ),
      );
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('fires onTap', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKListTile(title: const Text('Row'), onTap: () => taps++),
      );
      await tester.tap(find.text('Row'));
      expect(taps, 1);
    });

    testWidgets('is not tappable without onTap', (tester) async {
      await pumpCK(tester, const CKListTile(title: Text('Row')));
      expect(find.byType(InkWell), findsNothing);
    });
  });

  group('CKBreadcrumb', () {
    testWidgets('renders every item with separators between', (tester) async {
      await pumpCK(
        tester,
        const CKBreadcrumb(
          items: [
            BreadcrumbItem(label: 'Home'),
            BreadcrumbItem(label: 'Users'),
            BreadcrumbItem(label: 'Ada'),
          ],
        ),
      );
      for (final l in ['Home', 'Users', 'Ada']) {
        expect(find.text(l), findsOneWidget);
      }
      expect(find.byIcon(LucideIcons.chevronRight), findsNWidgets(2));
    });

    testWidgets('earlier items fire onTap', (tester) async {
      var taps = 0;
      await pumpCK(
        tester,
        CKBreadcrumb(
          items: [
            BreadcrumbItem(label: 'Home', onTap: () => taps++),
            const BreadcrumbItem(label: 'Page'),
          ],
        ),
      );
      await tester.tap(find.text('Home'));
      expect(taps, 1);
    });

    testWidgets('the current (last) item is not a link', (tester) async {
      await pumpCK(
        tester,
        CKBreadcrumb(
          items: [
            const BreadcrumbItem(label: 'Home'),
            BreadcrumbItem(label: 'Page', onTap: () {}),
          ],
        ),
      );
      // Only "Home" is wrapped in an InkWell.
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('wraps instead of overflowing when narrow', (tester) async {
      await pumpCK(
        tester,
        SizedBox(
          width: 140,
          child: CKBreadcrumb(
            items: [
              for (var i = 0; i < 6; i++) BreadcrumbItem(label: 'Level $i'),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('CKNavigationRail', () {
    testWidgets('shows every destination label', (tester) async {
      await pumpCK(
        tester,
        const Scaffold(
          body: Row(children: [
            CKNavigationRail(selectedIndex: 0, items: _navItems),
          ]),
        ),
        fullScreen: true,
      );
      for (final l in ['Home', 'Search', 'Profile']) {
        expect(find.text(l), findsOneWidget);
      }
    });

    testWidgets('reports the tapped destination', (tester) async {
      int? picked;
      await pumpCK(
        tester,
        Scaffold(
          body: Row(children: [
            CKNavigationRail(
              selectedIndex: 0,
              items: _navItems,
              onDestinationSelected: (i) => picked = i,
            ),
          ]),
        ),
        fullScreen: true,
      );
      await tester.tap(find.text('Profile'));
      expect(picked, 2);
    });

    testWidgets('selected item uses its active icon', (tester) async {
      await pumpCK(
        tester,
        const Scaffold(
          body: Row(children: [
            CKNavigationRail(selectedIndex: 0, items: _navItems),
          ]),
        ),
        fullScreen: true,
      );
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.home_outlined), findsNothing);
    });

    testWidgets('exposes selected state to accessibility', (tester) async {
      await pumpCK(
        tester,
        const Scaffold(
          body: Row(children: [
            CKNavigationRail(selectedIndex: 1, items: _navItems),
          ]),
        ),
        fullScreen: true,
      );
      expect(
        tester.getSemantics(find.text('Search')),
        containsSemantics(
          label: 'Search',
          isButton: true,
          isSelected: true,
          hasSelectedState: true,
        ),
      );
    });
  });

  group('CKTimePicker', () {
    testWidgets('shows the formatted value', (tester) async {
      await pumpCK(
        tester,
        CKTimePicker(
          value: const TimeOfDay(hour: 9, minute: 30),
          onChanged: (_) {},
        ),
      );
      expect(find.text('9:30 AM'), findsOneWidget);
    });

    testWidgets('shows a hint when empty', (tester) async {
      await pumpCK(tester, CKTimePicker(onChanged: (_) {}));
      expect(find.text('Pick a time'), findsOneWidget);
    });

    testWidgets('opens the picker dialog on tap', (tester) async {
      await pumpCK(tester, CKTimePicker(label: 'Time', onChanged: (_) {}));
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('confirming reports the picked time', (tester) async {
      TimeOfDay? picked;
      await pumpCK(
        tester,
        CKTimePicker(
          value: const TimeOfDay(hour: 9, minute: 30),
          onChanged: (t) => picked = t,
        ),
      );
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(picked, const TimeOfDay(hour: 9, minute: 30));
    });

    testWidgets('cancelling reports nothing', (tester) async {
      var calls = 0;
      await pumpCK(tester, CKTimePicker(onChanged: (_) => calls++));
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(calls, 0);
    });

    testWidgets('remembers the pick when uncontrolled', (tester) async {
      await pumpCK(tester, CKTimePicker(onChanged: (_) {}));
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      final text = tester.widget<EditableText>(find.byType(EditableText));
      expect(text.controller.text, isNotEmpty);
    });

    testWidgets('required field shows an error when dismissed empty',
        (tester) async {
      await pumpCK(
        tester,
        CKTimePicker(isRequired: true, onChanged: (_) {}),
      );
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('validator error is shown for an invalid pick', (tester) async {
      await pumpCK(
        tester,
        CKTimePicker(
          value: const TimeOfDay(hour: 9, minute: 0),
          validator: (t) => 'Too early',
          onChanged: (_) {},
        ),
      );
      await tester.tap(find.byType(CKTextField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Too early'), findsOneWidget);
    });
  });

  group('CKTooltip', () {
    testWidgets('shows its message on long press', (tester) async {
      await pumpCK(
        tester,
        const CKTooltip(message: 'Helpful tip', child: Text('Hover me')),
      );
      expect(find.text('Helpful tip'), findsNothing);
      await tester.longPress(find.text('Hover me'));
      await tester.pumpAndSettle();
      expect(find.text('Helpful tip'), findsOneWidget);
    });

    testWidgets('shows on mouse hover', (tester) async {
      await pumpCK(
        tester,
        const CKTooltip(message: 'Helpful tip', child: Text('Hover me')),
      );
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(gesture.removePointer);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(find.text('Hover me')));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Helpful tip'), findsOneWidget);
    });
  });

  group('CKPopover', () {
    Widget popover({VoidCallback? onContentTap}) => Padding(
          padding: const EdgeInsets.only(top: 100),
          child: CKPopover(
            trigger: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Open'),
            ),
            content: GestureDetector(
              onTap: onContentTap,
              child: const Text('Panel content'),
            ),
          ),
        );

    testWidgets('is closed until the trigger is tapped', (tester) async {
      await pumpCK(tester, popover());
      expect(find.text('Panel content'), findsNothing);
    });

    testWidgets('opens below the trigger on tap', (tester) async {
      await pumpCK(tester, popover());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Panel content'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('Panel content')).dy,
        greaterThan(tester.getBottomLeft(find.text('Open')).dy),
      );
    });

    testWidgets('tapping the trigger again closes it', (tester) async {
      await pumpCK(tester, popover());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(tester.getCenter(find.text('Open')));
      await tester.pumpAndSettle();
      // The barrier sits above the trigger, so this dismisses via the barrier.
      expect(find.text('Panel content'), findsNothing);
    });

    testWidgets('tapping outside closes it', (tester) async {
      await pumpCK(tester, popover());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(1000, 800));
      await tester.pumpAndSettle();
      expect(find.text('Panel content'), findsNothing);
    });

    testWidgets('tapping content does not close it', (tester) async {
      var taps = 0;
      await pumpCK(tester, popover(onContentTap: () => taps++));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Panel content'));
      await tester.pumpAndSettle();
      expect(taps, 1);
      expect(find.text('Panel content'), findsOneWidget);
    });

    testWidgets('is removed cleanly when the widget is disposed', (tester) async {
      await pumpCK(tester, popover());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await pumpCK(tester, const SizedBox());
      expect(find.text('Panel content'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });
}
