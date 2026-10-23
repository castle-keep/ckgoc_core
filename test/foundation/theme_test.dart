import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  group('ckcoreThemeResolver', () {
    for (final theme in themeMatrix) {
      test('resolves ${themeLabel(theme)}', () {
        final data = ckcoreThemeResolver.resolve(theme.$1, theme.$2);
        expect(data.brand, theme.$1);
        expect(data.brightness, theme.$2);
        expect(data.isDark, theme.$2 == Brightness.dark);
        expect(data.isLight, theme.$2 == Brightness.light);
      });
    }

    test('brands have distinct primary colours', () {
      final ck = ckcoreThemeResolver.resolve(
        ckcoreBrand.castleKeep,
        Brightness.light,
      );
      final sky = ckcoreThemeResolver.resolve(
        ckcoreBrand.skyGo,
        Brightness.light,
      );
      expect(ck.colors.primary, isNot(sky.colors.primary));
    });

    test('light and dark differ in background', () {
      for (final brand in ckcoreBrand.values) {
        final light = ckcoreThemeResolver.resolve(brand, Brightness.light);
        final dark = ckcoreThemeResolver.resolve(brand, Brightness.dark);
        expect(light.colors.background, isNot(dark.colors.background));
      }
    });

    test('every brand has a display name', () {
      expect(ckcoreBrand.castleKeep.displayName, 'CastleKeep');
      expect(ckcoreBrand.skyGo.displayName, 'SkyGo');
    });
  });

  group('token scales', () {
    for (final theme in themeMatrix) {
      final data = ckcoreThemeResolver.resolve(theme.$1, theme.$2);

      test('spacing is ordered (${themeLabel(theme)})', () {
        final s = data.spacing;
        final scale = [s.none, s.xxs, s.xs, s.sm, s.md, s.lg, s.xl, s.x2l, s.x3l, s.x4l, s.x5l];
        for (var i = 1; i < scale.length; i++) {
          expect(scale[i], greaterThanOrEqualTo(scale[i - 1]));
        }
      });

      test('radius is ordered (${themeLabel(theme)})', () {
        final r = data.radius;
        final scale = [r.none, r.sm, r.base, r.md, r.lg, r.xl, r.x2l, r.x3l];
        for (var i = 1; i < scale.length; i++) {
          expect(scale[i], greaterThanOrEqualTo(scale[i - 1]));
        }
      });

      test('breakpoints ascend (${themeLabel(theme)})', () {
        final b = data.breakpoints;
        final scale = [b.xs, b.sm, b.md, b.lg, b.xl, b.x2l];
        for (var i = 1; i < scale.length; i++) {
          expect(scale[i], greaterThan(scale[i - 1]));
        }
      });

      test('opacity values are within 0..1 (${themeLabel(theme)})', () {
        final o = data.opacity;
        for (final v in [o.disabled, o.muted, o.hover, o.scrim, o.subtle, o.transparent, o.full]) {
          expect(v, inInclusiveRange(0.0, 1.0));
        }
        expect(o.full, 1.0);
        expect(o.transparent, 0.0);
      });

      test('motion durations are ordered (${themeLabel(theme)})', () {
        final m = data.motion;
        final scale = [m.instant, m.fast, m.normal, m.slow, m.lazy];
        for (var i = 1; i < scale.length; i++) {
          expect(scale[i], greaterThan(scale[i - 1]));
        }
      });

      test('on-colours contrast with their surfaces (${themeLabel(theme)})', () {
        final c = data.colors;
        // WCAG-ish sanity: text colours must not equal the colour they sit on.
        expect(c.onPrimary, isNot(c.primary));
        expect(c.onSurface, isNot(c.surface));
        expect(c.onError, isNot(c.error));
        expect(c.onSuccess, isNot(c.success));
      });
    }
  });

  group('copyWith', () {
    test('overrides only the given fields', () {
      final base = ckcoreThemeResolver.resolve(
        ckcoreBrand.castleKeep,
        Brightness.light,
      );
      final copy = base.copyWith(
        spacing: const ckcoreSpacing(md: 99),
      );
      expect(copy.spacing.md, 99);
      expect(copy.colors, same(base.colors));
      expect(copy.brand, base.brand);
    });
  });

  group('context accessors', () {
    testWidgets('every token family resolves under CKApp', (tester) async {
      late BuildContext ctx;
      await pumpCK(
        tester,
        Builder(builder: (c) {
          ctx = c;
          return const SizedBox();
        }),
        brand: ckcoreBrand.skyGo,
        brightness: Brightness.dark,
      );
      final data = ctx.ckcoreTheme;
      expect(data.brand, ckcoreBrand.skyGo);
      expect(data.isDark, isTrue);
      expect(ctx.ckColors, same(data.colors));
      expect(ctx.ckSpacing, same(data.spacing));
      expect(ctx.ckTypography, same(data.typography));
      expect(ctx.ckRadius, same(data.radius));
      expect(ctx.ckElevation, same(data.elevation));
      expect(ctx.ckShadows, same(data.shadows));
      expect(ctx.ckMotion, same(data.motion));
      expect(ctx.ckOpacity, same(data.opacity));
      expect(ctx.ckBreakpoints, same(data.breakpoints));
    });

    testWidgets('ckcoreThemeMaybe is null outside CKApp', (tester) async {
      BuildContext? ctx;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(builder: (c) {
            ctx = c;
            return const SizedBox();
          }),
        ),
      );
      expect(ctx!.ckcoreThemeMaybe, isNull);
    });

    testWidgets('a nested ckcoreTheme overrides the subtree', (tester) async {
      late BuildContext inner;
      await pumpCK(
        tester,
        Builder(builder: (outer) {
          final overridden = outer.ckcoreTheme.copyWith(
            spacing: const ckcoreSpacing(md: 77),
          );
          return ckcoreTheme(
            data: overridden,
            child: Builder(builder: (c) {
              inner = c;
              return const SizedBox();
            }),
          );
        }),
      );
      expect(inner.ckSpacing.md, 77);
    });
  });
}
