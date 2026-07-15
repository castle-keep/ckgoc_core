import 'package:flutter/material.dart';

@immutable
/// Typography styles used across the design system.
class CkgocTypography {
  const CkgocTypography({
    required this.display2xl,
    required this.displayXl,
    required this.displayLg,
    required this.displayMd,
    required this.displaySm,
    required this.textXl,
    required this.textLg,
    required this.textMd,
    required this.textSm,
    required this.textXs,
    required this.labelXl,
    required this.labelLg,
    required this.labelMd,
    required this.labelSm,
    required this.codeMd,
  });
  final TextStyle display2xl;
  final TextStyle displayXl;
  final TextStyle displayLg;
  final TextStyle displayMd;
  final TextStyle displaySm;
  final TextStyle textXl;
  final TextStyle textLg;
  final TextStyle textMd;
  final TextStyle textSm;
  final TextStyle textXs;
  final TextStyle labelXl;
  final TextStyle labelLg;
  final TextStyle labelMd;
  final TextStyle labelSm;
  final TextStyle codeMd;

  CkgocTypography copyWith({
    TextStyle? display2xl,
    TextStyle? displayXl,
    TextStyle? displayLg,
    TextStyle? displayMd,
    TextStyle? displaySm,
    TextStyle? textXl,
    TextStyle? textLg,
    TextStyle? textMd,
    TextStyle? textSm,
    TextStyle? textXs,
    TextStyle? labelXl,
    TextStyle? labelLg,
    TextStyle? labelMd,
    TextStyle? labelSm,
    TextStyle? codeMd,
  }) {
    return CkgocTypography(
      display2xl: display2xl ?? this.display2xl,
      displayXl: displayXl ?? this.displayXl,
      displayLg: displayLg ?? this.displayLg,
      displayMd: displayMd ?? this.displayMd,
      displaySm: displaySm ?? this.displaySm,
      textXl: textXl ?? this.textXl,
      textLg: textLg ?? this.textLg,
      textMd: textMd ?? this.textMd,
      textSm: textSm ?? this.textSm,
      textXs: textXs ?? this.textXs,
      labelXl: labelXl ?? this.labelXl,
      labelLg: labelLg ?? this.labelLg,
      labelMd: labelMd ?? this.labelMd,
      labelSm: labelSm ?? this.labelSm,
      codeMd: codeMd ?? this.codeMd,
    );
  }

  /// Applies [color] to every style in this typography set.
  CkgocTypography applyColor(Color color) {
    return CkgocTypography(
      display2xl: display2xl.copyWith(color: color),
      displayXl: displayXl.copyWith(color: color),
      displayLg: displayLg.copyWith(color: color),
      displayMd: displayMd.copyWith(color: color),
      displaySm: displaySm.copyWith(color: color),
      textXl: textXl.copyWith(color: color),
      textLg: textLg.copyWith(color: color),
      textMd: textMd.copyWith(color: color),
      textSm: textSm.copyWith(color: color),
      textXs: textXs.copyWith(color: color),
      labelXl: labelXl.copyWith(color: color),
      labelLg: labelLg.copyWith(color: color),
      labelMd: labelMd.copyWith(color: color),
      labelSm: labelSm.copyWith(color: color),
      codeMd: codeMd.copyWith(color: color),
    );
  }
}
