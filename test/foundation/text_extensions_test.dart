import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

TextStyle _styleOf(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text)).style ??
    DefaultTextStyle.of(tester.element(find.text(text))).style;

void main() {
  group('modifiers', () {
    testWidgets('bold / italic / underline / lineThrough', (tester) async {
      await pumpCK(
        tester,
        Column(children: [
          const Text('b').bold,
          const Text('i').italic,
          const Text('u').underline,
          const Text('l').lineThrough,
        ]),
      );
      expect(_styleOf(tester, 'b').fontWeight, FontWeight.bold);
      expect(_styleOf(tester, 'i').fontStyle, FontStyle.italic);
      expect(_styleOf(tester, 'u').decoration, TextDecoration.underline);
      expect(_styleOf(tester, 'l').decoration, TextDecoration.lineThrough);
    });

    testWidgets('weights', (tester) async {
      await pumpCK(
        tester,
        Column(children: [
          const Text('r').regular,
          const Text('m').medium,
          const Text('s').semibold,
        ]),
      );
      expect(_styleOf(tester, 'r').fontWeight, FontWeight.w400);
      expect(_styleOf(tester, 'm').fontWeight, FontWeight.w500);
      expect(_styleOf(tester, 's').fontWeight, FontWeight.w600);
    });

    testWidgets('case transforms change the text', (tester) async {
      await pumpCK(
        tester,
        Column(children: [
          const Text('Hello').uppercase,
          const Text('World').lowercase,
        ]),
      );
      expect(find.text('HELLO'), findsOneWidget);
      expect(find.text('world'), findsOneWidget);
    });

    testWidgets('modifiers chain', (tester) async {
      await pumpCK(tester, const Text('x').bold.italic);
      expect(_styleOf(tester, 'x').fontWeight, FontWeight.bold);
      expect(_styleOf(tester, 'x').fontStyle, FontStyle.italic);
    });
  });

  group('typography styles', () {
    testWidgets('heading shortcuts use the matching tokens', (tester) async {
      late CkcoreuiThemeData theme;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          theme = c.ckcoreTheme;
          return Column(children: [
            const Text('h1').h1,
            const Text('h2').h2,
            const Text('h3').h3,
            const Text('h4').h4,
            const Text('h5').h5,
            const Text('h6').h6,
          ]);
        }),
      );
      final t = theme.typography;
      expect(_styleOf(tester, 'h1').fontSize, t.display2xl.fontSize);
      expect(_styleOf(tester, 'h2').fontSize, t.displayXl.fontSize);
      expect(_styleOf(tester, 'h3').fontSize, t.displayLg.fontSize);
      expect(_styleOf(tester, 'h4').fontSize, t.displayMd.fontSize);
      expect(_styleOf(tester, 'h5').fontSize, t.displaySm.fontSize);
      expect(_styleOf(tester, 'h6').fontSize, t.textXl.fontSize);
    });

    testWidgets('size styles resolve', (tester) async {
      await pumpCK(
        tester,
        Column(children: [
          const Text('a').textXl,
          const Text('b').textLg,
          const Text('c').textMd,
          const Text('d').textSm,
          const Text('e').textXs,
          const Text('f').labelMd,
          const Text('g').codeMd,
        ]),
      );
      expect(tester.takeException(), isNull);
      expect(find.byType(Text), findsNWidgets(7));
    });
  });

  group('colour helpers', () {
    for (final theme in themeMatrix) {
      testWidgets('map to theme colours (${themeLabel(theme)})', (tester) async {
        late ckcoreColors colors;
        await pumpCK(
          tester,
          Builder(builder: (c) {
            colors = c.ckColors;
            return Column(children: [
              const Text('p').primary,
              const Text('s').success,
              const Text('w').warning,
              const Text('e').error,
              const Text('n').info,
              const Text('m').muted,
            ]);
          }),
          brand: theme.$1,
          brightness: theme.$2,
        );
        expect(_styleOf(tester, 'p').color, colors.primary);
        expect(_styleOf(tester, 's').color, colors.success);
        expect(_styleOf(tester, 'w').color, colors.warning);
        expect(_styleOf(tester, 'e').color, colors.error);
        expect(_styleOf(tester, 'n').color, colors.info);
        expect(_styleOf(tester, 'm').color, colors.muted);
      });
    }

    testWidgets('modifier then colour keeps both', (tester) async {
      late ckcoreColors colors;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          colors = c.ckColors;
          return const Text('x').bold.primary;
        }),
      );
      expect(_styleOf(tester, 'x').fontWeight, FontWeight.bold);
      expect(_styleOf(tester, 'x').color, colors.primary);
    });
  });

  testWidgets('blockQuote renders its text', (tester) async {
    await pumpCK(tester, const Text('Quote').blockQuote);
    expect(find.text('Quote'), findsOneWidget);
  });
}
