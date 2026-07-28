import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:ckcoreui/src/themes/ckcore_brand.dart';
import 'package:ckcoreui/src/themes/brands/castlekeep/castlekeep_light_theme.dart';
import 'package:ckcoreui/src/themes/brands/castlekeep/castlekeep_dark_theme.dart';
import 'package:ckcoreui/src/themes/brands/skygo/skygo_light_theme.dart';
import 'package:ckcoreui/src/themes/brands/skygo/skygo_dark_theme.dart';

// Resolves the correct [CkcoreuiThemeData] for a given brand + brightness.
//
// To add a new brand:
// 1. Add the brand value to [ckcoreBrand].
// 2. Create light and dark theme builders under `brands/<new_brand>/`.
// 3. Add a new case to [ckcoreThemeResolver.resolve].
abstract final class ckcoreThemeResolver {
  // Returns the [CkcoreuiThemeData] for [brand] at [brightness].
  static CkcoreuiThemeData resolve(ckcoreBrand brand, Brightness brightness) {
    return switch ((brand, brightness)) {
      (ckcoreBrand.castleKeep, Brightness.light) =>
        CastleKeepLightTheme.build(),
      (ckcoreBrand.castleKeep, Brightness.dark) => CastleKeepDarkTheme.build(),
      (ckcoreBrand.skyGo, Brightness.light) => SkyGoLightTheme.build(),
      (ckcoreBrand.skyGo, Brightness.dark) => SkyGoDarkTheme.build(),
    };
  }
}
