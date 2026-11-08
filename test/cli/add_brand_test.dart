import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Scaffolds a brand with `bin/ckgoc.dart` inside a throwaway copy of the
/// package and checks that the result still passes the analyzer. The real
/// working tree is never modified.
void main() {
  late Directory tmp;
  final repo = Directory.current.path;

  setUp(() {
    tmp = Directory.systemTemp.createTempSync('ckgoc_add_brand_');
    for (final name in const ['lib', 'bin']) {
      _copyDir(Directory('$repo/$name'), Directory('${tmp.path}/$name'));
    }
    for (final name in const ['pubspec.yaml', 'analysis_options.yaml']) {
      File('$repo/$name').copySync('${tmp.path}/$name');
    }
    // pubspec.yaml lists these asset folders; the analyzer warns if they are
    // missing. Empty folders are enough (the real assets are large).
    for (final dir in const ['ck', 'skygo']) {
      Directory('${tmp.path}/assets/images/logos/$dir').createSync(
        recursive: true,
      );
    }
  });

  tearDown(() {
    if (tmp.existsSync()) tmp.deleteSync(recursive: true);
  });

  test(
    'add brand scaffolds a brand that registers and analyzes cleanly',
    () async {
      final scaffold = await Process.run('dart', [
        'bin/ckgoc.dart',
        'add',
        'brand',
        'Acme',
      ], workingDirectory: tmp.path);
      expect(
        scaffold.exitCode,
        0,
        reason: '${scaffold.stdout}\n${scaffold.stderr}',
      );

      // Generated brand files.
      for (final f in const [
        'acme_colors.dart',
        'acme_typography.dart',
        'acme_light_theme.dart',
        'acme_dark_theme.dart',
      ]) {
        expect(
          File('${tmp.path}/lib/src/themes/brands/acme/$f').existsSync(),
          isTrue,
          reason: '$f should be generated',
        );
      }

      // Registered in the enum and the resolver.
      final brand = File(
        '${tmp.path}/lib/src/themes/ckcore_brand.dart',
      ).readAsStringSync();
      expect(brand, contains('acme,'));
      expect(brand, contains("ckcoreBrand.acme => 'Acme'"));
      final resolver = File(
        '${tmp.path}/lib/src/themes/ckcore_theme_resolver.dart',
      ).readAsStringSync();
      expect(resolver, contains('(ckcoreBrand.acme, Brightness.light)'));
      expect(resolver, contains('(ckcoreBrand.acme, Brightness.dark)'));

      // The scaffolded package must have no analyzer errors or warnings
      // (infos such as existing deprecations are tolerated).
      final analyze = await Process.run('flutter', [
        'analyze',
        '--no-fatal-infos',
      ], workingDirectory: tmp.path);
      expect(
        analyze.exitCode,
        0,
        reason: '${analyze.stdout}\n${analyze.stderr}',
      );
    },
    timeout: const Timeout(Duration(minutes: 5)),
  );
}

void _copyDir(Directory from, Directory to) {
  to.createSync(recursive: true);
  for (final entity in from.listSync(followLinks: false)) {
    final name = entity.uri.pathSegments.where((s) => s.isNotEmpty).last;
    if (name == '.DS_Store') continue;
    if (entity is Directory) {
      _copyDir(entity, Directory('${to.path}/$name'));
    } else if (entity is File) {
      entity.copySync('${to.path}/$name');
    }
  }
}
