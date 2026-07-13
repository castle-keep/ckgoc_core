import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/foundation/foundation.dart';
import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme_data.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_colors.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_typography.dart';

typedef _P = CkgocPrimitiveColors;
typedef _C = SkyGoColors;

final class SkyGoLightTheme {
  SkyGoLightTheme._();

  static CkgocThemeData build() {
    const colors = CkgocColors(
      primary: _C.primary,
      primaryHover: _C.primaryLight,
      primaryActive: _C.primaryDark,
      primaryDisabled: _C.primaryDisabled,
      onPrimary: Color(0xFFFFFFFF),

      secondary: _P.neutral700,
      secondaryHover: _P.neutral800,
      secondaryActive: _P.neutral900,
      onSecondary: Color(0xFFFFFFFF),

      accent: _C.accentDark,
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

    return CkgocThemeData(
      brand: CkgocBrand.skyGo,
      brightness: Brightness.light,
      colors: colors,
      typography: SkyGoTypography.scale(defaultColor: _P.neutral950),
      spacing: CkgocSpacing.defaults,
      radius: CkgocRadius.defaults,
      elevation: CkgocElevation.defaults,
      shadows: CkgocShadows.light(),
      motion: CkgocMotion.defaults,
      opacity: CkgocOpacity.defaults,
      breakpoints: CkgocBreakpoints.defaults,
    );
  }
}
