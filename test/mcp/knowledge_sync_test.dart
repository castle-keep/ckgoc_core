import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Keeps `mcp/src/knowledge/components.json` in step with the library: every
/// public `CK*` class (plus `BreadcrumbItem`) must have an entry, and every
/// entry must name a class that exists.
void main() {
  // Token accessor classes (CKColors, CKSpacing, ...) live in lib/src/themes
  // and are documented in tokens.json, so only these folders are scanned.
  const scanned = ['lib/src/components', 'lib/src/templates', 'lib/src/app'];
  const extra = {'BreadcrumbItem'};

  Set<String> libraryClasses() {
    final names = <String>{...extra};
    final decl = RegExp(
      r'^(?:(?:abstract|final|sealed)\s+)*class (CK\w+)',
      multiLine: true,
    );
    for (final dir in scanned) {
      for (final f in Directory(dir).listSync(recursive: true)) {
        if (f is File && f.path.endsWith('.dart')) {
          for (final m in decl.allMatches(f.readAsStringSync())) {
            names.add(m.group(1)!);
          }
        }
      }
    }
    return names;
  }

  final documented =
      ((jsonDecode(
                    File(
                      'mcp/src/knowledge/components.json',
                    ).readAsStringSync(),
                  )
                  as Map<String, dynamic>)['components']
              as Map<String, dynamic>)
          .keys
          .toSet();

  test('every public CK* class has an MCP knowledge entry', () {
    final missing = libraryClasses().difference(documented);
    expect(
      missing,
      isEmpty,
      reason: 'Add these to mcp/src/knowledge/components.json: $missing',
    );
  });

  test('every MCP knowledge entry names a class that exists', () {
    final unknown = documented.difference(libraryClasses());
    expect(
      unknown,
      isEmpty,
      reason: 'Remove or rename in components.json: $unknown',
    );
  });
}
