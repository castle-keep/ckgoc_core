import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';
// theme imports not required in this file
import 'package:flutter_svg/flutter_svg.dart';

/// Normalized brand icon asset paths and helpers.
///
/// This file provides stable identifiers for icon assets that live under
/// `assets/images/logos/` and a lightweight helper that returns a reasonable
/// widget to render a brand icon without adding extra dependencies.
class BrandIcon {
  // CastleKeep logos
  static const castlekeepMaster =
      'assets/images/logos/ck/castlekeep_master_logo_1.png';
  static const castlekeepName =
      'assets/images/logos/ck/castlekeep_name_logo_1.png';
  static const castlekeepSymbol =
      'assets/images/logos/ck/castlekeep_logo_1.png';
  static const castlekeepLogo1 = 'assets/images/logos/ck/castlekeep_logo_1.png';
  static const castlekeepLogo1Svg =
      'assets/images/logos/ck/castlekeep_logo_1.svg';
  static const castlekeepLogo2 = 'assets/images/logos/ck/castlekeep_logo_2.png';
  static const castlekeepLogo2Svg =
      'assets/images/logos/ck/castlekeep_logo_2.svg';
  static const castlekeepLogo3 = 'assets/images/logos/ck/castlekeep_logo_3.png';
  static const castlekeepLogo3Svg =
      'assets/images/logos/ck/castlekeep_logo_3.svg';
  static const castlekeepLogo4Svg =
      'assets/images/logos/ck/castlekeep_logo_4.svg';
  static const castlekeepLogoB = 'assets/images/logos/ck/castlekeep_logo_b.png';
  static const castlekeepLogoC1 =
      'assets/images/logos/ck/castlekeep_logo_c1.png';
  static const castlekeepLogoC2 =
      'assets/images/logos/ck/castlekeep_logo_c2.png';
  static const castlekeepMaster2 =
      'assets/images/logos/ck/castlekeep_master_logo_2.png';
  static const castlekeepMaster2Svg =
      'assets/images/logos/ck/castlekeep_master_logo_2.svg';
  static const castlekeepMaster3 =
      'assets/images/logos/ck/castlekeep_master_logo_3.png';
  static const castlekeepMaster3Svg =
      'assets/images/logos/ck/castlekeep_master_logo_3.svg';
  static const castlekeepMaster4Svg =
      'assets/images/logos/ck/castlekeep_master_logo_4.svg';
  static const castlekeepMasterC1 =
      'assets/images/logos/ck/castlekeep_master_logo_c1.png';
  static const castlekeepMasterC2 =
      'assets/images/logos/ck/castlekeep_master_logo_c2.png';
  static const castlekeepMasterW =
      'assets/images/logos/ck/castlekeep_master_logo_w.png';
  static const castlekeepName2 =
      'assets/images/logos/ck/castlekeep_name_logo_2.png';
  static const castlekeepName2Svg =
      'assets/images/logos/ck/castlekeep_name_logo_2.svg';
  static const castlekeepName3 =
      'assets/images/logos/ck/castlekeep_name_logo_3.png';
  static const castlekeepName3Svg =
      'assets/images/logos/ck/castlekeep_name_logo_3.svg';
  static const castlekeepName4Svg =
      'assets/images/logos/ck/castlekeep_name_logo_4.svg';
  static const castlekeepNameB =
      'assets/images/logos/ck/castlekeep_name_logo_b.png';

  // skygo logos
  static const skygoMasterSvg =
      'assets/images/logos/skygo/skygo_master_logo_1.svg';
  static const skygoName = 'assets/images/logos/skygo/skygo_name_logo_1.svg';
  static const skygoSymbol = 'assets/images/logos/skygo/skygo_logo_1.svg';

  // Additional SkyGo variants
  static const skygoLogo1 = 'assets/images/logos/skygo/skygo_logo_1.svg';
  static const skygoLogo2 = 'assets/images/logos/skygo/skygo_logo_2.svg';
  static const skygoLogo3 = 'assets/images/logos/skygo/skygo_logo_3.svg';
  static const skygoMaster2 =
      'assets/images/logos/skygo/skygo_master_logo_2.svg';
  static const skygoMaster3 =
      'assets/images/logos/skygo/skygo_master_logo_3.svg';
  static const skygoName2 = 'assets/images/logos/skygo/skygo_name_logo_2.svg';
  static const skygoName3 = 'assets/images/logos/skygo/skygo_name_logo_3.svg';

  /// Returns a widget appropriate for displaying the brand icon.
  ///
  /// Uses packaged PNG assets when available; otherwise falls back to a
  /// typographic mark using the current theme.
  static Widget brandLogoWidget(
    BuildContext context,
    CkgocBrand brand, {
    double size = 40,
    BrandIconVariant variant = BrandIconVariant.master,
    String? assetPath,
  }) {
    // Intentionally lightweight: theming is applied inside helpers when needed.

    // If a specific asset path override was provided, prefer it.
    if (assetPath != null)
      return assetLogoWidget(context, assetPath, size: size);

    // Pick the path based on brand + variant.
    String path;
    switch (brand) {
      case CkgocBrand.castleKeep:
        switch (variant) {
          case BrandIconVariant.master:
            path = castlekeepMaster;
            break;
          case BrandIconVariant.name:
            path = castlekeepName;
            break;
          case BrandIconVariant.logo:
            path = castlekeepSymbol;
            break;
        }
        break;
      case CkgocBrand.skyGo:
        switch (variant) {
          case BrandIconVariant.master:
            path = skygoMasterSvg;
            break;
          case BrandIconVariant.name:
            path = skygoName;
            break;
          case BrandIconVariant.logo:
            path = skygoSymbol;
            break;
        }
        break;
    }

    return assetLogoWidget(context, path, size: size);
  }

  /// Returns a widget for a specific packaged asset path.
  ///
  /// For raster images (`.png`, `.jpg`) this uses `Image.asset`. For SVGs
  /// the package avoids pulling in `flutter_svg` as a dependency; consumers
  /// should prefer `SvgPicture.asset(BrandIcon.someSvg, package: 'ckgoc_core')`
  /// when available. When `flutter_svg` is not used this method renders a
  /// lightweight placeholder for SVG assets.
  static Widget assetLogoWidget(
    BuildContext context,
    String assetPath, {
    double size = 40,
  }) {
    // theme intentionally unused here; helpers may use it for coloring.
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        package: 'ckgoc_core',
        width: size,
        height: size,
        fit: BoxFit.contain,
        semanticsLabel: 'Brand logo',
      );
    }

    return Image.asset(
      assetPath,
      package: 'ckgoc_core',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
