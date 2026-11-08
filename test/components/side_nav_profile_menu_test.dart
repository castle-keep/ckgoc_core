import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

/// The profile menu is an OverlayEntry owned by CKSideNav. It must close
/// cleanly however it is dismissed, and never outlive the nav.
Widget _nav({VoidCallback? onLogout}) => Scaffold(
      body: Row(children: [
        CKSideNav(
          sections: const [
            CKSideNavSection(
              items: [CKSideNavItem(icon: Icons.home, label: 'Home')],
            ),
          ],
          selectedIndex: 0,
          onItemSelected: (_) {},
          brandName: 'Brand',
          profileName: 'Jane Doe',
          profileAuthProvider: 'Google',
          onLogout: onLogout,
        ),
      ]),
    );

Future<void> _openMenu(WidgetTester tester) async {
  await tester.tap(find.text('Jane Doe'));
  await tester.pumpAndSettle();
  expect(find.text('Google'), findsOneWidget, reason: 'menu should be open');
}

void main() {
  testWidgets('Cancel closes the menu', (tester) async {
    await pumpCK(tester, _nav(), fullScreen: true);
    await _openMenu(tester);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Google'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Log out closes the menu and calls onLogout once', (tester) async {
    var calls = 0;
    await pumpCK(tester, _nav(onLogout: () => calls++), fullScreen: true);
    await _openMenu(tester);

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(calls, 1);
    expect(find.text('Google'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opening the menu twice does not leave an orphan', (tester) async {
    await pumpCK(tester, _nav(), fullScreen: true);
    await _openMenu(tester);

    // The backdrop covers the card, so a second open goes through the
    // same code path as a re-trigger: close first, then show a fresh entry.
    await tester.tapAt(const Offset(2, 2)); // backdrop
    await tester.pumpAndSettle();
    expect(find.text('Google'), findsNothing);

    await _openMenu(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Google'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('removing the nav while the menu is open removes the menu', (
    tester,
  ) async {
    await pumpCK(tester, _nav(), fullScreen: true);
    await _openMenu(tester);

    // Navigate away: the nav (and its State) is disposed with the menu open.
    await tester.pumpWidget(
      const CKApp(
        brand: ckcoreBrand.castleKeep,
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SizedBox()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Google'), findsNothing, reason: 'menu must not leak');
    expect(tester.takeException(), isNull);
  });
}
