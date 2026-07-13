import 'package:ckgoc_core/src/themes/ckgoc_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/themes/brands/castlekeep/castlekeep_light_theme.dart';
import 'package:ckgoc_core/src/themes/brands/castlekeep/castlekeep_dark_theme.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_light_theme.dart';
import 'package:ckgoc_core/src/themes/brands/skygo/skygo_dark_theme.dart';

// Resolves the correct [CkgocThemeData] for a given brand + brightness.
//
// To add a new brand:
// 1. Add the brand value to [CkgocBrand].
// 2. Create light and dark theme builders under `brands/<new_brand>/`.
// 3. Add a new case to [CkgocThemeResolver.resolve].
abstract final class CkgocThemeResolver {
  // Returns the [CkgocThemeData] for [brand] at [brightness].
  static CkgocThemeData resolve(CkgocBrand brand, Brightness brightness) {
    return switch ((brand, brightness)) {
      (CkgocBrand.castleKeep, Brightness.light) => CastleKeepLightTheme.build(),
      (CkgocBrand.castleKeep, Brightness.dark) => CastleKeepDarkTheme.build(),
      (CkgocBrand.skyGo, Brightness.light) => SkyGoLightTheme.build(),
      (CkgocBrand.skyGo, Brightness.dark) => SkyGoDarkTheme.build(),
    };
  }
}
