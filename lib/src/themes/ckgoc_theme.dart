import 'package:ckgoc_core/src/themes/ckgoc_theme_data.dart';
import 'package:flutter/material.dart';

// InheritedWidget that provides [CkgocThemeData] to the widget tree.
class CkgocTheme extends InheritedWidget {
  const CkgocTheme({required this.data, required super.child, super.key});
  final CkgocThemeData data;

  // Returns the nearest [CkgocThemeData] or throws if none is found.
  //
  // Use this inside any widget that is guaranteed to be wrapped by
  // [CkgocApp].
  static CkgocThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<CkgocTheme>();
    assert(
      theme != null,
      'No CkgocTheme found in context.\n'
      'Wrap your app with CkgocApp(brand: ...) to provide a theme.',
    );
    return theme!.data;
  }

  // Returns the nearest [CkgocThemeData], or null if none exists.
  //
  // Useful in widgets that can optionally participate in the design system.
  static CkgocThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CkgocTheme>()?.data;
  }

  @override
  bool updateShouldNotify(CkgocTheme oldWidget) {
    return data != oldWidget.data;
  }
}

// Convenience extension so widgets can read the theme with minimal ceremony.
extension CkgocThemeContext on BuildContext {
  // The active [CkgocThemeData] for this subtree.
  // The active [CkgocThemeData] for this subtree.
  CkgocThemeData get ckgocTheme => CkgocTheme.of(this);

  // The active [CkgocThemeData], or null if none is provided.
  CkgocThemeData? get ckgocThemeMaybe => CkgocTheme.maybeOf(this);

  // Backwards-compatible aliases. Prefer `ckgocTheme`.
  @Deprecated('Use ckgocTheme instead')
  CkgocThemeData get companyTheme => ckgocTheme;

  @Deprecated('Use ckgocThemeMaybe instead')
  CkgocThemeData? get companyThemeMaybe => ckgocThemeMaybe;
}
