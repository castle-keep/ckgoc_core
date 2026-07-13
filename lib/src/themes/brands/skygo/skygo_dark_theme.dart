import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/foundation/foundation.dart';
import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme_data.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_colors.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_typography.dart';

typedef _P = CkgocPrimitiveColors;
typedef _C = SkyGoColors;

final class SkyGoDarkTheme {
  SkyGoDarkTheme._();

  static CkgocThemeData build() {
    const colors = CkgocColors(
      primary: _C.primaryOnDark,
      primaryHover: _C.primaryLight,
      primaryActive: Color(0xFF80C3FA),
      primaryDisabled: Color(0xFF1A3A6B),
      onPrimary: _P.neutral950,

      secondary: _P.neutral500,
      secondaryHover: _P.neutral400,
      secondaryActive: _P.neutral300,
      onSecondary: _P.neutral950,

      accent: _C.accent,
      onAccent: _C.primaryDark,

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
      onErrorContainer: Color(0xFFFFE4E6),

      success: _P.successLight,
      successContainer: _P.successDark,
      onSuccess: _P.successDark,
      onSuccessContainer: Color(0xFFD1FAE5),

      warning: _P.warningLight,
      warningContainer: _P.warningDark,
      onWarning: _P.warningDark,
      onWarningContainer: Color(0xFFFEF3C7),

      info: _P.infoLight,
      infoContainer: _P.infoDark,
      onInfo: _P.infoDark,
      onInfoContainer: Color(0xFFBFDBFE),

      neutral: _P.neutral500,
      neutralVariant: _P.neutral600,

      shadow: Color(0x33000000),
      scrim: Color(0x99000000),
      ring: _C.primaryOnDark,
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

    return CkgocThemeData(
      brand: CkgocBrand.skyGo,
      brightness: Brightness.dark,
      colors: colors,
      typography: SkyGoTypography.scale(defaultColor: _P.neutral100),
      spacing: CkgocSpacing.defaults,
      radius: CkgocRadius.defaults,
      elevation: CkgocElevation.defaults,
      shadows: CkgocShadows.dark(),
      motion: CkgocMotion.defaults,
      opacity: CkgocOpacity.defaults,
      breakpoints: CkgocBreakpoints.defaults,
    );
  }
}
