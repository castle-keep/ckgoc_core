import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  smokeMatrix({
    'CKBadge': () => const CKBadge(label: 'New'),
    'CKBadge.success': () => const CKBadge.success(label: 'Done'),
    'CKBadge.warning': () => const CKBadge.warning(label: 'Careful'),
    'CKBadge.error': () => const CKBadge.error(label: 'Failed'),
    'CKBadge.outline': () => const CKBadge.outline(label: 'Outline'),
    'CKCard': () => const CKCard(title: 'Title', subtitle: 'Sub', description: 'Body'),
    'CKCard elevated horizontal': () => const CKCard(
          title: 'Title',
          elevated: true,
          layout: CardLayout.horizontal,
          trailing: Icon(Icons.chevron_right),
        ),
    'CKCard.success': () => const CKCard.success(title: 'Saved'),
    'CKCard.error': () => const CKCard.error(title: 'Broke'),
    'CKContainer': () => const CKContainer(child: Text('Surface')),
    'CKContainer.muted': () => const CKContainer.muted(child: Text('Muted')),
    'CKContainer.outlined': () =>
        const CKContainer.outlined(elevated: true, child: Text('Outlined')),
    'CKDivider': () => const CKDivider(),
    'CKDivider vertical': () => const SizedBox(
          height: 40,
          child: CKDivider(direction: Axis.vertical),
        ),
    'CKAvatar initials': () => const CKAvatar(initials: 'AB'),
    for (final size in AvatarSize.values)
      'CKAvatar ${size.name}': () => CKAvatar(initials: 'CK', size: size),
    'CKAvatar status': () =>
        const CKAvatar(initials: 'CK', status: AvatarStatus.online),
    'CKAvatarGroup': () => const CKAvatarGroup(
          avatars: [
            CKAvatar(initials: 'A'),
            CKAvatar(initials: 'B'),
            CKAvatar(initials: 'C'),
            CKAvatar(initials: 'D'),
          ],
          maxVisible: 3,
        ),
    'CKListTile': () => const CKListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.chevron_right),
        ),
    'CKFilterChip': () => CKFilterChip(label: 'Filter', onTap: () {}),
    'CKFilterChip selected': () =>
        CKFilterChip(label: 'Filter', selected: true, onTap: () {}),
    'CKInputChip': () => const CKInputChip(label: 'Tag'),
    'CKAccordion': () => const CKAccordion(
          items: [
            CKAccordionItem(title: 'One', content: Text('First body')),
            CKAccordionItem(title: 'Two', content: Text('Second body')),
          ],
        ),
    'CKStepper vertical': () => const CKStepper(steps: _steps),
    'CKStepper horizontal': () => const CKStepper(
          steps: _steps,
          orientation: CKStepperOrientation.horizontal,
        ),
    'CKTimeline': () => const CKTimeline(events: _events),
    'CKTimeline horizontal': () => const SizedBox(
          height: 160,
          child: CKTimeline(
            events: _events,
            orientation: CKTimelineOrientation.horizontal,
          ),
        ),
  });

  group('CKAccordion', () {
    testWidgets('expands and collapses an item on tap', (tester) async {
      await pumpCK(
        tester,
        const CKAccordion(
          items: [CKAccordionItem(title: 'One', content: Text('First body'))],
        ),
      );
      expect(find.text('First body').hitTestable(), findsNothing);
      await tester.tap(find.text('One'));
      await tester.pumpAndSettle();
      expect(find.text('First body').hitTestable(), findsOneWidget);
      await tester.tap(find.text('One'));
      await tester.pumpAndSettle();
      expect(find.text('First body').hitTestable(), findsNothing);
    });
  });

  group('CKListTile / CKCard / chips', () {
    testWidgets('card onTap fires', (tester) async {
      var taps = 0;
      await pumpCK(tester, CKCard(title: 'Tap me', onTap: () => taps++));
      await tester.tap(find.text('Tap me'));
      expect(taps, 1);
    });

    testWidgets('card shows title, subtitle and description', (tester) async {
      await pumpCK(
        tester,
        const CKCard(title: 'T', subtitle: 'S', description: 'D'),
      );
      expect(find.text('T'), findsOneWidget);
      expect(find.text('S'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
    });

    testWidgets('filter chip onTap fires', (tester) async {
      var taps = 0;
      await pumpCK(tester, CKFilterChip(label: 'Chip', onTap: () => taps++));
      await tester.tap(find.text('Chip'));
      expect(taps, 1);
    });

    testWidgets('badge shows its label', (tester) async {
      await pumpCK(tester, const CKBadge.success(label: 'Approved'));
      expect(find.text('Approved'), findsOneWidget);
    });

    testWidgets('avatar group collapses overflow into a +N count', (tester) async {
      await pumpCK(
        tester,
        const CKAvatarGroup(
          avatars: [
            CKAvatar(initials: 'A'),
            CKAvatar(initials: 'B'),
            CKAvatar(initials: 'C'),
            CKAvatar(initials: 'D'),
          ],
          maxVisible: 2,
        ),
      );
      expect(find.byType(CKAvatar), findsNWidgets(2));
      expect(find.text('+2'), findsOneWidget);
    });
  });
}

const _steps = [
  CKStep(title: 'Account', status: StepStatus.completed),
  CKStep(title: 'Profile', status: StepStatus.inProgress),
  CKStep(title: 'Review', status: StepStatus.pending),
  CKStep(title: 'Rejected', status: StepStatus.rejected),
];

const _events = [
  CKTimelineEvent(title: 'Created', timestamp: 'Mon'),
  CKTimelineEvent(title: 'Updated', timestamp: 'Tue'),
];
