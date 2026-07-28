import 'package:ckcoreui/src/foundation/breakpoints/ckcore_breakpoints.dart';
import 'package:ckcoreui/src/foundation/colors/ckcore_colors.dart';
import 'package:ckcoreui/src/foundation/elevation/ckcore_elevation.dart';
import 'package:ckcoreui/src/foundation/motion/ckcore_motion.dart';
import 'package:ckcoreui/src/foundation/opacity/ckcore_opacity.dart';
import 'package:ckcoreui/src/foundation/radius/ckcore_radius.dart';
import 'package:ckcoreui/src/foundation/shadows/ckcore_shadows.dart';
import 'package:ckcoreui/src/foundation/spacing/ckcore_spacing.dart';
import 'package:ckcoreui/src/foundation/typography/ckcore_typography.dart';
import 'package:flutter/material.dart';

import 'package:ckcoreui/src/themes/ckcore_brand.dart';

/// Immutable theme data for a brand + brightness combination.
@immutable
class CkcoreuiThemeData {
  const CkcoreuiThemeData({
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
  final ckcoreBrand brand;
  final Brightness brightness;

  final ckcoreColors colors;
  final ckcoreTypography typography;
  final ckcoreSpacing spacing;
  final ckcoreRadius radius;
  final ckcoreElevation elevation;
  final ckcoreShadows shadows;
  final ckcoreMotion motion;
  final ckcoreOpacity opacity;
  final ckcoreBreakpoints breakpoints;

  /// True when the theme's brightness is `Brightness.dark`.
  bool get isDark => brightness == Brightness.dark;

  /// True when the theme's brightness is `Brightness.light`.
  bool get isLight => brightness == Brightness.light;

  /// Returns a copy of this theme with the given fields overridden.
  ///
  /// Useful for one-off overrides in a widget subtree.
  CkcoreuiThemeData copyWith({
    ckcoreBrand? brand,
    Brightness? brightness,
    ckcoreColors? colors,
    ckcoreTypography? typography,
    ckcoreSpacing? spacing,
    ckcoreRadius? radius,
    ckcoreElevation? elevation,
    ckcoreShadows? shadows,
    ckcoreMotion? motion,
    ckcoreOpacity? opacity,
    ckcoreBreakpoints? breakpoints,
  }) {
    return CkcoreuiThemeData(
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
      other is CkcoreuiThemeData &&
          brand == other.brand &&
          brightness == other.brightness;

  @override
  int get hashCode => Object.hash(brand, brightness);
}

/// Backwards-compatible alias used across examples/docs expecting the
/// lowercase `ckcoreThemeData` identifier.
typedef ckcoreThemeData = CkcoreuiThemeData;
