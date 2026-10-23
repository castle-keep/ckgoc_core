import 'dart:io';

import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  final source = File('lib/src/themes/brand_icon.dart').readAsStringSync();
  final paths = RegExp(r"'(assets/images/logos/[^']+)'")
      .allMatches(source)
      .map((m) => m.group(1)!)
      .toSet();

  group('BrandIcon assets', () {
    test('declares logo paths', () {
      expect(paths, isNotEmpty);
    });

    test('every referenced file exists on disk', () {
      final missing = paths.where((p) => !File(p).existsSync()).toList()..sort();
      expect(missing, isEmpty, reason: 'Missing logo assets: $missing');
    });

    test('every referenced folder is declared in pubspec.yaml', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final folders = paths.map((p) => '${p.substring(0, p.lastIndexOf('/'))}/').toSet();
      for (final folder in folders) {
        expect(pubspec, contains(folder), reason: '$folder not in pubspec assets');
      }
    });

    test('follow the lowercase snake_case naming convention', () {
      for (final p in paths) {
        final file = p.split('/').last;
        expect(file, matches(RegExp(r'^[a-z0-9_]+\.(png|svg)$')), reason: file);
      }
    });
  });

  group('BrandIcon.brandLogoWidget', () {
    for (final brand in ckcoreBrand.values) {
      testWidgets('renders for ${brand.name}', (tester) async {
        await pumpCK(
          tester,
          Builder(
            builder: (context) =>
                BrandIcon.brandLogoWidget(context, brand, size: 80),
          ),
          settle: false,
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
    }
  });
}
