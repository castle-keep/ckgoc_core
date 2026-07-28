import 'package:flutter/material.dart';

import 'package:ckcoreui/src/foundation/foundation.dart';
import 'package:ckcoreui/src/themes/ckcore_brand.dart';
import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
import 'package:ckcoreui/src/themes/brands/skygo/skygo_colors.dart';
import 'package:ckcoreui/src/themes/brands/skygo/skygo_typography.dart';

typedef _P = ckcorePrimitiveColors;
typedef _C = SkyGoColors;

final class SkyGoLightTheme {
  SkyGoLightTheme._();

  static CkcoreuiThemeData build() {
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

    return CkcoreuiThemeData(
      brand: ckcoreBrand.skyGo,
      brightness: Brightness.light,
      colors: colors,
      typography: SkyGoTypography.scale(defaultColor: _P.neutral950),
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
