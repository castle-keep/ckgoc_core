import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ckcoreBrand _brand = ckcoreBrand.skyGo;
  Brightness? _brightness; // null = follow system

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: _brand,
      brightness: _brightness,
      title: 'Company UI Showcase',
      debugShowCheckedModeBanner: false,
      themeMode: _brightness == null
          ? ThemeMode.system
          : _brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomeScreen(
        currentBrand: _brand,
        currentBrightness: _brightness ?? Brightness.dark,
        onBrandChanged: (brand) => setState(() => _brand = brand),
        onBrightnessChanged: (b) => setState(() => _brightness = b),
      ),
    );
  }
}
