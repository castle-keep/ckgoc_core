import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/foundation/foundation.dart';

// SkyGo typography scale.
//
// Scale matches the Figma Core Typography System (Inter).
// Font family: null = system default until brand font assets are added under
// [assets/fonts/skygo/]. Once added, set [_fontFamily] to 'SGSans' and
// uncomment the fonts section in pubspec.yaml.
abstract final class SkyGoTypography {
  // TODO: set to 'SGSans' and add font assets under assets/fonts/skygo/
  static const String? _fontFamily = null;

  static CkgocTypography scale({required Color defaultColor}) =>
      CkgocTypography(
        display2xl: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          color: defaultColor,
        ),
        displayXl: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 36 / 28,
          color: defaultColor,
        ),
        displayLg: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 32 / 24,
          color: defaultColor,
        ),
        displayMd: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: defaultColor,
        ),
        displaySm: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 24 / 18,
          color: defaultColor,
        ),
        textXl: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          height: 28 / 20,
          color: defaultColor,
        ),
        textLg: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 24 / 18,
          color: defaultColor,
        ),
        textMd: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: defaultColor,
        ),
        textSm: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: defaultColor,
        ),
        textXs: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 18 / 12,
          color: defaultColor,
        ),
        labelXl: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 28 / 18,
          color: defaultColor,
        ),
        labelLg: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 24 / 16,
          color: defaultColor,
        ),
        labelMd: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
          color: defaultColor,
        ),
        labelSm: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 18 / 12,
          color: defaultColor,
        ),
        codeMd: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
      );
}
