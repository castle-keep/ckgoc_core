import 'package:flutter/material.dart';

import 'package:ckcoreui/src/foundation/foundation.dart';
import 'package:ckcoreui/src/themes/ckcore_brand.dart';
import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
import 'package:ckcoreui/src/themes/brands/castlekeep/castlekeep_colors.dart';
import 'package:ckcoreui/src/themes/brands/castlekeep/castlekeep_typography.dart';

typedef _P = ckcorePrimitiveColors;
typedef _C = CastleKeepColors;

final class CastleKeepDarkTheme {
  CastleKeepDarkTheme._();

  static CkcoreuiThemeData build() {
    const colors = ckcoreColors(
      primary: _C.primaryOnDark,
      primaryHover: Color(0xFF8ECBC2),
      primaryActive: Color(0xFFB5DDD8),
      primaryDisabled: Color(0xFF1A4A42),
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

    return CkcoreuiThemeData(
      brand: ckcoreBrand.castleKeep,
      brightness: Brightness.dark,
      colors: colors,
      typography: CastleKeepTypography.scale(defaultColor: _P.neutral100),
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
