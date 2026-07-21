import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/foundation/foundation.dart';

// SkyGo typography scale.
//
// Scale matches the Figma Core Typography System (Inter).
// Font family: null = system default until brand font assets are added under
// [assets/fonts/skygo/]. Once added, set [_fontFamily] to 'SGSans' and
// uncomment the fonts section in pubspec.yaml.
abstract final class SkyGoTypography {
  // Inter via google_fonts for consistent typography.
  static TextStyle _interStyle({
    required double size,
    required FontWeight weight,
    required double height,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  static CkgocTypography scale({required Color defaultColor}) =>
      CkgocTypography(
        display2xl: _interStyle(
          size: 32,
          weight: FontWeight.w700,
          height: 40 / 32,
          color: defaultColor,
        ),
        displayXl: _interStyle(
          size: 28,
          weight: FontWeight.w700,
          height: 36 / 28,
          color: defaultColor,
        ),
        displayLg: _interStyle(
          size: 24,
          weight: FontWeight.w700,
          height: 32 / 24,
          color: defaultColor,
        ),
        displayMd: _interStyle(
          size: 20,
          weight: FontWeight.w700,
          height: 28 / 20,
          color: defaultColor,
        ),
        displaySm: _interStyle(
          size: 18,
          weight: FontWeight.w500,
          height: 24 / 18,
          color: defaultColor,
        ),
        textXl: _interStyle(
          size: 20,
          weight: FontWeight.w400,
          height: 28 / 20,
          color: defaultColor,
        ),
        textLg: _interStyle(
          size: 18,
          weight: FontWeight.w400,
          height: 24 / 18,
          color: defaultColor,
        ),
        textMd: _interStyle(
          size: 16,
          weight: FontWeight.w400,
          height: 24 / 16,
          color: defaultColor,
        ),
        textSm: _interStyle(
          size: 14,
          weight: FontWeight.w400,
          height: 20 / 14,
          color: defaultColor,
        ),
        textXs: _interStyle(
          size: 12,
          weight: FontWeight.w400,
          height: 18 / 12,
          color: defaultColor,
        ),
        labelXl: _interStyle(
          size: 18,
          weight: FontWeight.w500,
          height: 28 / 18,
          color: defaultColor,
        ),
        labelLg: _interStyle(
          size: 16,
          weight: FontWeight.w500,
          height: 24 / 16,
          color: defaultColor,
        ),
        labelMd: _interStyle(
          size: 14,
          weight: FontWeight.w500,
          height: 20 / 14,
          color: defaultColor,
        ),
        labelSm: _interStyle(
          size: 12,
          weight: FontWeight.w500,
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
