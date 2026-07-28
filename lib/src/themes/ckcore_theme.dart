import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
import 'package:flutter/material.dart';

/// InheritedWidget that provides [CkcoreuiThemeData] to the widget tree.
class CkcoreuiTheme extends InheritedWidget {
  const CkcoreuiTheme({required this.data, required super.child, super.key});
  final CkcoreuiThemeData data;

  /// Returns the nearest [CkcoreuiThemeData] or throws if none is found.
  ///
  /// Use this inside any widget that is guaranteed to be wrapped by
  /// [ckcoreApp].
  static CkcoreuiThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<CkcoreuiTheme>();
    assert(
      theme != null,
      'No CkcoreuiTheme found in context.\n'
      'Wrap your app with ckcoreApp(brand: ...) to provide a theme.',
    );
    return theme!.data;
  }

  /// Returns the nearest [CkcoreuiThemeData], or null if none exists.
  ///
  /// Useful in widgets that can optionally participate in the design system.
  static CkcoreuiThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CkcoreuiTheme>()?.data;
  }

  @override
  bool updateShouldNotify(CkcoreuiTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// Backwards-compatible widget with the old lowercase API used by docs/examples.
class ckcoreTheme extends StatelessWidget {
  const ckcoreTheme({required this.data, required this.child, super.key});
  final CkcoreuiThemeData data;
  final Widget child;

  /// Returns the nearest [CkcoreuiThemeData] or throws if none is found.
  static CkcoreuiThemeData of(BuildContext context) =>
      CkcoreuiTheme.of(context);

  /// Returns the nearest [CkcoreuiThemeData], or null if none exists.
  static CkcoreuiThemeData? maybeOf(BuildContext context) =>
      CkcoreuiTheme.maybeOf(context);

  @override
  Widget build(BuildContext context) => CkcoreuiTheme(data: data, child: child);
}

/// Convenience extension so widgets can read the theme with minimal ceremony.
extension ckcoreThemeContext on BuildContext {
  /// The active [CkcoreuiThemeData] for this subtree (short alias).
  CkcoreuiThemeData get ckcoreTheme => CkcoreuiTheme.of(this);

  /// The active [CkcoreuiThemeData] for this subtree (explicit name).
  CkcoreuiThemeData get ckcoreuiTheme => CkcoreuiTheme.of(this);

  /// The active [CkcoreuiThemeData], or null if none is provided.
  CkcoreuiThemeData? get ckcoreThemeMaybe => CkcoreuiTheme.maybeOf(this);

  /// Backwards-compatible aliases. Prefer `ckcoreTheme`/`ckcoreuiTheme`.
  @Deprecated('Use ckcoreTheme instead')
  CkcoreuiThemeData get companyTheme => ckcoreTheme;

  @Deprecated('Use ckcoreThemeMaybe instead')
  CkcoreuiThemeData? get companyThemeMaybe => ckcoreThemeMaybe;
}
