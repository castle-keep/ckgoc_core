import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

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
  CkgocBrand _brand = CkgocBrand.skyGo;
  Brightness? _brightness; // null = follow system

  @override
  Widget build(BuildContext context) {
    return CkgocApp(
      brand: _brand,
      brightness: _brightness,
      child: MaterialApp(
        title: 'Company UI Showcase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: _brightness == null
            ? ThemeMode.dark
            : _brightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
        home: HomeScreen(
          currentBrand: _brand,
          currentBrightness: _brightness ?? Brightness.dark,
          onBrandChanged: (brand) => setState(() => _brand = brand),
          onBrightnessChanged: (b) => setState(() => _brightness = b),
        ),
      ),
    );
  }
}
