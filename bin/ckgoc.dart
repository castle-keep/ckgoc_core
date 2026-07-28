#!/usr/bin/env dart

import 'dart:io';

String toEnumValue(String raw) {
  final parts = raw
      .replaceAll(RegExp(r'[^A-Za-z0-9 ]'), ' ')
      .trim()
      .split(RegExp(r'\s+'));
  if (parts.isEmpty) return raw.toLowerCase();
  final first = parts.first.toLowerCase();
  final rest = parts
      .skip(1)
      .map((s) => s[0].toUpperCase() + s.substring(1).toLowerCase())
      .join();
  return '$first$rest';
}

String toPascal(String raw) {
  final parts = raw
      .replaceAll(RegExp(r'[^A-Za-z0-9 ]'), ' ')
      .trim()
      .split(RegExp(r'\s+'));
  return parts
      .map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase())
      .join();
}

String toDirName(String raw) =>
    raw.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toLowerCase();

void main(List<String> args) {
  if (args.length < 3 || args[0] != 'add' || args[1] != 'brand') {
    print('Usage: dart run bin/ckcoreui.dart add brand <BrandName>');
    exit(1);
  }

  final raw = args.sublist(2).join(' ');
  final enumValue = toEnumValue(raw);
  final pascal = toPascal(raw);
  final dirName = toDirName(raw);

  final projectRoot = Directory.current.path;
  final themesDir = '$projectRoot/lib/src/themes';
  final brandDir = '$themesDir/brands/$dirName';

  // 1) Create brand directory and files
  Directory(brandDir).createSync(recursive: true);

  final colorsFile = File('$brandDir/${dirName}_colors.dart');
  final typographyFile = File('$brandDir/${dirName}_typography.dart');
  final lightFile = File('$brandDir/${dirName}_light_theme.dart');
  final darkFile = File('$brandDir/${dirName}_dark_theme.dart');

  if (!colorsFile.existsSync()) {
    colorsFile.writeAsStringSync('''import 'package:flutter/material.dart';

abstract final class ${pascal}Colors {
  static const Color primary = Color(0xFF0055FF);
  static const Color primaryLight = Color(0xFF3D7BFF);
  static const Color primaryDark = Color(0xFF003ECC);
  static const Color primaryDisabled = Color(0xFFBFD8FF);
  static const Color primaryOnDark = Color(0xFF88C1FF);

  static const Color accent = Color(0xFFFFB100);
  static const Color accentLight = Color(0xFFFFCF66);
  static const Color accentDark = Color(0xFFCC8C00);
}
''');
    print('Created ${colorsFile.path}');
  }

  if (!typographyFile.existsSync()) {
    typographyFile.writeAsStringSync('''import 'package:flutter/material.dart';
  import 'package:ckcoreui/src/foundation/foundation.dart';

abstract final class ${pascal}Typography {
  static const String? _fontFamily = null;

  static ckcoreTypography scale({required Color defaultColor}) =>
      ckcoreTypography(
        display2xl: TextStyle(fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700, height: 40/32, color: defaultColor),
        displayXl: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700, height: 36/28, color: defaultColor),
        displayLg: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w700, height: 32/24, color: defaultColor),
        displayMd: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w700, height: 28/20, color: defaultColor),
        displaySm: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w500, height: 24/18, color: defaultColor),
        textXl: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w400, height: 28/20, color: defaultColor),
        textLg: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w400, height: 24/18, color: defaultColor),
        textMd: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 24/16, color: defaultColor),
        textSm: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400, height: 20/14, color: defaultColor),
        textXs: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 18/12, color: defaultColor),
        labelXl: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w500, height: 28/18, color: defaultColor),
        labelLg: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w500, height: 24/16, color: defaultColor),
        labelMd: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, height: 20/14, color: defaultColor),
        labelSm: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, height: 18/12, color: defaultColor),
        codeMd: TextStyle(fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.w400, height: 20/14, color: defaultColor),
      );
}
''');
    print('Created ${typographyFile.path}');
  }

  if (!lightFile.existsSync()) {
    lightFile.writeAsStringSync('''import 'package:flutter/material.dart';

  import 'package:ckcoreui/src/foundation/foundation.dart';
  import 'package:ckcoreui/src/themes/ckcore_brand.dart';
  import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
  import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_colors.dart';
  import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_typography.dart';

typedef _P = ckcorePrimitiveColors;
typedef _C = ${pascal}Colors;

final class ${pascal}LightTheme {
  ${pascal}LightTheme._();

  static ckcoreThemeData build() {
    const colors = ckcoreColors(
      primary: _C.primary,
      primaryHover: _C.primaryLight,
      primaryActive: _C.primaryDark,
      primaryDisabled: _C.primaryDisabled,
      onPrimary: _C.accent,

      secondary: _P.neutral100,
      secondaryHover: _P.neutral200,
      secondaryActive: _P.neutral300,
      onSecondary: _P.neutral900,

      accent: _C.accent,
      onAccent: _P.neutral900,

      background: Color(0xFFFAFAFA),
      surface: _P.neutral0,
      surfaceVariant: _P.neutral200,
      surfaceElevated: _P.neutral0,
      inverseSurface: _P.neutral900,
      onBackground: _P.neutral950,
      onSurface: _P.neutral900,
      onSurfaceVariant: _P.neutral600,
      onInverseSurface: _P.neutral50,

      outline: _P.neutral300,
      outlineVariant: _P.neutral300,

      error: _P.error,
      errorContainer: _P.errorSurface,
      onError: Color(0xFFFFFFFF),
      onErrorContainer: _P.errorDark,

      success: _P.success,
      successContainer: _P.successSurface,
      onSuccess: Color(0xFFFFFFFF),
      onSuccessContainer: _P.successDark,

      warning: _P.warning,
      warningContainer: _P.warningSurface,
      onWarning: Color(0xFFFFFFFF),
      onWarningContainer: _P.warningDark,

      info: _P.info,
      infoContainer: _P.infoSurface,
      onInfo: Color(0xFFFFFFFF),
      onInfoContainer: _P.infoDark,

      neutral: _P.neutral400,
      neutralVariant: _P.neutral300,

      shadow: Color(0x1A000000),
      scrim: Color(0x80000000),
      ring: _P.neutral500,
      muted: _P.neutral100,
      onMuted: _P.neutral600,
      tagLive: _P.error,
      onTagLive: _P.neutral0,
      tagNew: _P.cyan,
      onTagNew: _P.neutral0,
      tagBeta: _P.orange,
      onTagBeta: _P.neutral0,
      tagProStart: _P.violet,
      tagProEnd: _P.blue,
      onTagPro: _P.neutral0,
    );

    return ckcoreThemeData(
      brand: ckcoreBrand.$enumValue,
      brightness: Brightness.light,
      colors: colors,
      typography: ${pascal}Typography.scale(defaultColor: _P.neutral950),
      spacing: ckcoreSpacing.defaults,
      radius: ckcoreRadius.defaults,
      elevation: ckcoreElevation.defaults,
      shadows: ckcoreShadows.light(),
      motion: ckcoreMotion.defaults,
      opacity: ckcoreOpacity.defaults,
      breakpoints: ckcoreBreakpoints.defaults,
    );
  }
}
''');
    print('Created ${lightFile.path}');
  }

  if (!darkFile.existsSync()) {
    darkFile.writeAsStringSync('''import 'package:flutter/material.dart';

  import 'package:ckcoreui/src/foundation/foundation.dart';
  import 'package:ckcoreui/src/themes/ckcore_brand.dart';
  import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
  import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_colors.dart';
  import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_typography.dart';

typedef _P = ckcorePrimitiveColors;
typedef _C = ${pascal}Colors;

final class ${pascal}DarkTheme {
  ${pascal}DarkTheme._();

  static ckcoreThemeData build() {
    const colors = ckcoreColors(
      primary: _C.primaryOnDark,
      primaryHover: _C.primaryLight,
      primaryActive: _C.primaryDark,
      primaryDisabled: _C.primaryDisabled,
      onPrimary: _C.accent,

      secondary: _P.neutral500,
      secondaryHover: _P.neutral400,
      secondaryActive: _P.neutral300,
      onSecondary: _P.neutral950,

      accent: _C.accentLight,
      onAccent: _P.neutral900,

      background: _P.neutral950,
      surface: Color(0xFF161B22),
      surfaceVariant: Color(0xFF21262D),
      surfaceElevated: Color(0xFF21262D),
      inverseSurface: _P.neutral100,
      onBackground: _P.neutral100,
      onSurface: _P.neutral100,
      onSurfaceVariant: Color(0xFF8B949E),
      onInverseSurface: _P.neutral900,

      outline: Color(0xFF30363D),
      outlineVariant: Color(0xFF21262D),

      error: _P.errorLight,
      errorContainer: _P.errorDark,
      onError: _P.errorDark,
      onErrorContainer: Color(0xFFFECACA),

      success: _P.successLight,
      successContainer: _P.successDark,
      onSuccess: _P.successDark,
      onSuccessContainer: Color(0xFFBBF7D0),

      warning: _P.warningLight,
      warningContainer: _P.warningDark,
      onWarning: _P.warningDark,
      onWarningContainer: Color(0xFFFDE68A),

      info: _P.infoLight,
      infoContainer: _P.infoDark,
      onInfo: _P.infoDark,
      onInfoContainer: Color(0xFFBFDBFE),

      neutral: _P.neutral500,
      neutralVariant: _P.neutral600,

      shadow: Color(0x33000000),
      scrim: Color(0x99000000),
      ring: Color(0xFF58A6FF),
      muted: Color(0xFF21262D),
      onMuted: Color(0xFF8B949E),
      tagLive: _P.errorLight,
      onTagLive: _P.errorDark,
      tagNew: _P.cyan,
      onTagNew: _P.neutral0,
      tagBeta: _P.orange,
      onTagBeta: _P.neutral0,
      tagProStart: _P.violet,
      tagProEnd: _P.blue,
      onTagPro: _P.neutral0,
    );

    return ckcoreThemeData(
      brand: ckcoreBrand.$enumValue,
      brightness: Brightness.dark,
      colors: colors,
      typography: ${pascal}Typography.scale(defaultColor: _P.neutral100),
      spacing: ckcoreSpacing.defaults,
      radius: ckcoreRadius.defaults,
      elevation: ckcoreElevation.defaults,
      shadows: ckcoreShadows.dark(),
      motion: ckcoreMotion.defaults,
      opacity: ckcoreOpacity.defaults,
      breakpoints: ckcoreBreakpoints.defaults,
    );
  }
}
''');
    print('Created ${darkFile.path}');
  }

  // 2) Update enum + extension in ckcore_brand.dart
  final brandFile = File('$themesDir/ckcore_brand.dart');
  if (!brandFile.existsSync()) {
    print('Could not find ckcore_brand.dart at $themesDir');
    exit(2);
  }
  var brandContent = brandFile.readAsStringSync();

  final enumRegex = RegExp(r'enum ckcoreBrand\s*{([\s\S]*?)}');
  final enumMatch = enumRegex.firstMatch(brandContent);
  if (enumMatch != null) {
    final inside = enumMatch.group(1)!;
    if (!inside.contains('\n  $enumValue')) {
      final newInside = inside.trimRight() + '\n\n  $enumValue,';
      brandContent = brandContent.replaceFirst(inside, newInside);
      print('Inserted enum value $enumValue into ckcore_brand.dart');
    } else {
      print('Enum already contains $enumValue');
    }
  }

  // Add displayName case
  final switchRegex = RegExp(
    r'String get displayName => switch \(this\) \{([\s\S]*?)\};',
  );
  final switchMatch = switchRegex.firstMatch(brandContent);
  if (switchMatch != null) {
    final inside = switchMatch.group(1)!;
    final caseLine = "    ckcoreBrand.$enumValue => '$pascal',\n";
    if (!inside.contains('ckcoreBrand.$enumValue')) {
      final newInside = inside.trimRight() + '\n' + caseLine;
      brandContent = brandContent.replaceFirst(inside, newInside);
      print('Added displayName mapping for $enumValue');
    } else {
      print('displayName mapping already present');
    }
  }

  brandFile.writeAsStringSync(brandContent);

  // 3) Update theme resolver
  final resolverFile = File('$themesDir/ckcore_theme_resolver.dart');
  if (!resolverFile.existsSync()) {
    print('Could not find ckcore_theme_resolver.dart at $themesDir');
    exit(3);
  }
  var resolverContent = resolverFile.readAsStringSync();

  final importLight =
      "import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_light_theme.dart';";
  final importDark =
      "import 'package:ckcoreui/src/themes/brands/$dirName/${dirName}_dark_theme.dart';";

  if (!resolverContent.contains(importLight)) {
    // insert after existing brand imports block
    final insertPoint = resolverContent.indexOf(
      "import 'package:ckcoreui/src/themes/brands/",
    );
    if (insertPoint != -1) {
      // append at end of brand imports area (just before comment or switch)
      // fallback: insert near other brand imports: after last import of brands
      final lastBrandImportIdx = resolverContent.lastIndexOf(
        "import 'package:ckcoreui/src/themes/brands/",
      );
      final nl = '\n';
      final pos = resolverContent.indexOf('\n', lastBrandImportIdx);
      final insertAt = pos != -1 ? pos + 1 : lastBrandImportIdx + 1;
      resolverContent =
          resolverContent.substring(0, insertAt) +
          importLight +
          nl +
          importDark +
          nl +
          resolverContent.substring(insertAt);
      print('Inserted imports for $pascal themes into resolver');
    } else {
      // simple append near top
      resolverContent =
          importLight + '\n' + importDark + '\n' + resolverContent;
    }
  } else {
    print('Resolver already imports brand themes');
  }

  // Insert cases into switch
  final caseLight =
      '      (ckcoreBrand.$enumValue, Brightness.light) => ${pascal}LightTheme.build(),\n';
  final caseDark =
      '      (ckcoreBrand.$enumValue, Brightness.dark) => ${pascal}DarkTheme.build(),\n';

  final switchCasesRegex = RegExp(
    r'return switch \(\(brand, brightness\)\) \{([\s\S]*?)\};',
  );
  final switchCasesMatch = switchCasesRegex.firstMatch(resolverContent);
  if (switchCasesMatch != null) {
    final casesInside = switchCasesMatch.group(1)!;
    if (!casesInside.contains('ckcoreBrand.$enumValue')) {
      final newCases = casesInside.trimRight() + '\n' + caseLight + caseDark;
      resolverContent = resolverContent.replaceFirst(casesInside, newCases);
      print('Registered $pascal in resolver switch');
    } else {
      print('Resolver already contains cases for $enumValue');
    }
  }

  resolverFile.writeAsStringSync(resolverContent);

  print('Done. Run: dart run bin/ckcoreui.dart add brand "$raw"');
}
