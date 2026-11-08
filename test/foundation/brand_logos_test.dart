import 'dart:io';

import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('brand logos on the theme', () {
    for (final brand in ckcoreBrand.values) {
      for (final brightness in Brightness.values) {
        test('${brand.name}/${brightness.name} declares existing assets', () {
          final logos = ckcoreThemeResolver.resolve(brand, brightness).logos;
          for (final path in [
            logos.master,
            logos.symbol,
            logos.name,
            logos.nav,
          ]) {
            expect(path, isNotNull, reason: '${brand.name} is missing a logo');
            expect(
              File(path!).existsSync(),
              isTrue,
              reason: '$path should exist in the package assets',
            );
          }
        });
      }
    }

    test('forVariant maps each variant to its field', () {
      const logos = BrandLogos(master: 'm', symbol: 's', name: 'n', nav: 'x');
      expect(logos.forVariant(BrandIconVariant.master), 'm');
      expect(logos.forVariant(BrandIconVariant.logo), 's');
      expect(logos.forVariant(BrandIconVariant.name), 'n');
      expect(BrandLogos.none.forVariant(BrandIconVariant.master), isNull);
    });

    test('copyWith overrides logos and keeps them otherwise', () {
      final base = ckcoreThemeResolver.resolve(
        ckcoreBrand.skyGo,
        Brightness.light,
      );
      expect(base.copyWith().logos, base.logos);
      expect(base.copyWith(logos: BrandLogos.none).logos, BrandLogos.none);
    });

    testWidgets('brandLogoWidget picks the asset the theme declares', (
      tester,
    ) async {
      late Widget widget;
      await tester.pumpWidget(
        CKApp(
          brand: ckcoreBrand.castleKeep,
          brightness: Brightness.light,
          debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) {
              widget = BrandIcon.brandLogoWidget(
                context,
                ckcoreBrand.castleKeep,
                variant: BrandIconVariant.name,
              );
              return widget;
            },
          ),
        ),
      );
      expect(widget, isA<Image>());
      final image = widget as Image;
      expect(
        (image.image as AssetImage).assetName,
        ckcoreThemeResolver
            .resolve(ckcoreBrand.castleKeep, Brightness.light)
            .logos
            .name,
      );
    });
  });
}
