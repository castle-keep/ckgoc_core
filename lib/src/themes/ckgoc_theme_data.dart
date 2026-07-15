import 'package:ckgoc_core/src/foundation/breakpoints/ckgoc_breakpoints.dart';
import 'package:ckgoc_core/src/foundation/colors/ckgoc_colors.dart';
import 'package:ckgoc_core/src/foundation/elevation/ckgoc_elevation.dart';
import 'package:ckgoc_core/src/foundation/motion/ckgoc_motion.dart';
import 'package:ckgoc_core/src/foundation/opacity/ckgoc_opacity.dart';
import 'package:ckgoc_core/src/foundation/radius/ckgoc_radius.dart';
import 'package:ckgoc_core/src/foundation/shadows/ckgoc_shadows.dart';
import 'package:ckgoc_core/src/foundation/spacing/ckgoc_spacing.dart';
import 'package:ckgoc_core/src/foundation/typography/ckgoc_typography.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';

/// Immutable theme data for a brand + brightness combination.
@immutable
class CkgocThemeData {
  const CkgocThemeData({
    required this.brand,
    required this.brightness,
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.elevation,
    required this.shadows,
    required this.motion,
    required this.opacity,
    required this.breakpoints,
  });

  /// Which brand this theme belongs to.
  final CkgocBrand brand;
  final Brightness brightness;

  final CkgocColors colors;
  final CkgocTypography typography;
  final CkgocSpacing spacing;
  final CkgocRadius radius;
  final CkgocElevation elevation;
  final CkgocShadows shadows;
  final CkgocMotion motion;
  final CkgocOpacity opacity;
  final CkgocBreakpoints breakpoints;

  /// True when the theme's brightness is `Brightness.dark`.
  bool get isDark => brightness == Brightness.dark;

  /// True when the theme's brightness is `Brightness.light`.
  bool get isLight => brightness == Brightness.light;

  /// Returns a copy of this theme with the given fields overridden.
  ///
  /// Useful for one-off overrides in a widget subtree.
  CkgocThemeData copyWith({
    CkgocBrand? brand,
    Brightness? brightness,
    CkgocColors? colors,
    CkgocTypography? typography,
    CkgocSpacing? spacing,
    CkgocRadius? radius,
    CkgocElevation? elevation,
    CkgocShadows? shadows,
    CkgocMotion? motion,
    CkgocOpacity? opacity,
    CkgocBreakpoints? breakpoints,
  }) {
    return CkgocThemeData(
      brand: brand ?? this.brand,
      brightness: brightness ?? this.brightness,
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      elevation: elevation ?? this.elevation,
      shadows: shadows ?? this.shadows,
      motion: motion ?? this.motion,
      opacity: opacity ?? this.opacity,
      breakpoints: breakpoints ?? this.breakpoints,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CkgocThemeData &&
          brand == other.brand &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(brand, brightness);
}
