import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_brand.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme_resolver.dart';

/// Root widget. Wraps your app to inject [CkgocThemeData] for the given brand.
class CkgocApp extends StatelessWidget {
  const CkgocApp({
    required this.brand,
    required this.child,
    super.key,
    this.brightness,
  });
  final CkgocBrand brand;

  /// Override system brightness. Leave null to follow the device setting.
  final Brightness? brightness;

  /// The widget subtree wrapped by `CkgocApp`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final systemBrightness = MediaQuery.platformBrightnessOf(context);
    final activeBrightness = brightness ?? systemBrightness;
    final themeData = CkgocThemeResolver.resolve(brand, activeBrightness);

    return CkgocTheme(data: themeData, child: child);
  }
}
