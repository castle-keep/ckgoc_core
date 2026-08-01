import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';
import 'package:ckcoreui/src/foundation/colors/ckcore_colors.dart';
import 'package:ckcoreui/src/foundation/spacing/ckcore_spacing.dart';
import 'package:ckcoreui/src/foundation/typography/ckcore_typography.dart';
import 'package:ckcoreui/src/foundation/radius/ckcore_radius.dart';
import 'package:ckcoreui/src/foundation/elevation/ckcore_elevation.dart';
import 'package:ckcoreui/src/foundation/shadows/ckcore_shadows.dart';
import 'package:ckcoreui/src/foundation/motion/ckcore_motion.dart';
import 'package:ckcoreui/src/foundation/opacity/ckcore_opacity.dart';
import 'package:ckcoreui/src/foundation/breakpoints/ckcore_breakpoints.dart';
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

// ============================================================================
// Public CK* Static Accessors
// ============================================================================
// These provide ergonomic access to design tokens from the active theme.
// Usage: CKColors.of(context).primary or context.ckColors.primary

/// Public accessor for color tokens from the active theme.
///
/// Example:
/// ```dart
/// Container(color: CKColors.of(context).primary)
/// // or via extension:
/// Container(color: context.ckColors.primary)
/// ```
abstract final class CKColors {
  /// Returns the [ckcoreColors] from the active theme.
  static ckcoreColors of(BuildContext context) =>
      CkcoreuiTheme.of(context).colors;
}

/// Public accessor for spacing tokens from the active theme.
///
/// Example:
/// ```dart
/// SizedBox(width: CKSpacing.of(context).md)
/// // or via extension:
/// SizedBox(width: context.ckSpacing.md)
/// ```
abstract final class CKSpacing {
  /// Returns the [ckcoreSpacing] from the active theme.
  static ckcoreSpacing of(BuildContext context) =>
      CkcoreuiTheme.of(context).spacing;
}

/// Public accessor for typography tokens from the active theme.
///
/// Example:
/// ```dart
/// Text('Hello', style: CKTypography.of(context).textMd)
/// // or via extension:
/// Text('Hello', style: context.ckTypography.textMd)
/// ```
abstract final class CKTypography {
  /// Returns the [ckcoreTypography] from the active theme.
  static ckcoreTypography of(BuildContext context) =>
      CkcoreuiTheme.of(context).typography;
}

/// Public accessor for radius tokens from the active theme.
///
/// Example:
/// ```dart
/// BorderRadius.circular(CKRadius.of(context).md)
/// // or via extension:
/// BorderRadius.circular(context.ckRadius.md)
/// ```
abstract final class CKRadius {
  /// Returns the [ckcoreRadius] from the active theme.
  static ckcoreRadius of(BuildContext context) =>
      CkcoreuiTheme.of(context).radius;
}

/// Public accessor for elevation tokens from the active theme.
///
/// Example:
/// ```dart
/// elevation: CKElevation.of(context).sm
/// // or via extension:
/// elevation: context.ckElevation.sm
/// ```
abstract final class CKElevation {
  /// Returns the [ckcoreElevation] from the active theme.
  static ckcoreElevation of(BuildContext context) =>
      CkcoreuiTheme.of(context).elevation;
}

/// Public accessor for shadow tokens from the active theme.
///
/// Example:
/// ```dart
/// shadows: [CKShadows.of(context).sm]
/// // or via extension:
/// shadows: [context.ckShadows.sm]
/// ```
abstract final class CKShadows {
  /// Returns the [ckcoreShadows] from the active theme.
  static ckcoreShadows of(BuildContext context) =>
      CkcoreuiTheme.of(context).shadows;
}

/// Public accessor for motion tokens from the active theme.
///
/// Example:
/// ```dart
/// duration: CKMotion.of(context).fast
/// // or via extension:
/// duration: context.ckMotion.fast
/// ```
abstract final class CKMotion {
  /// Returns the [ckcoreMotion] from the active theme.
  static ckcoreMotion of(BuildContext context) =>
      CkcoreuiTheme.of(context).motion;
}

/// Public accessor for opacity tokens from the active theme.
///
/// Example:
/// ```dart
/// opacity: CKOpacity.of(context).disabled
/// // or via extension:
/// opacity: context.ckOpacity.disabled
/// ```
abstract final class CKOpacity {
  /// Returns the [ckcoreOpacity] from the active theme.
  static ckcoreOpacity of(BuildContext context) =>
      CkcoreuiTheme.of(context).opacity;
}

/// Public accessor for breakpoint tokens from the active theme.
///
/// Example:
/// ```dart
/// if (width > CKBreakpoints.of(context).md) { }
/// // or via extension:
/// if (width > context.ckBreakpoints.md) { }
/// ```
abstract final class CKBreakpoints {
  /// Returns the [ckcoreBreakpoints] from the active theme.
  static ckcoreBreakpoints of(BuildContext context) =>
      CkcoreuiTheme.of(context).breakpoints;
}

// ============================================================================
// BuildContext Extensions for Ergonomic Token Access
// ============================================================================
// Shortest syntax: context.ckColors.primary, context.ckSpacing.md, etc.

/// Extension providing ergonomic access to design tokens from the active theme.
extension ckTokensContext on BuildContext {
  /// Returns the color tokens from the active theme.
  ///
  /// Example: `context.ckColors.primary`
  ckcoreColors get ckColors => CKColors.of(this);

  /// Returns the spacing tokens from the active theme.
  ///
  /// Example: `context.ckSpacing.md`
  ckcoreSpacing get ckSpacing => CKSpacing.of(this);

  /// Returns the typography tokens from the active theme.
  ///
  /// Example: `context.ckTypography.textMd`
  ckcoreTypography get ckTypography => CKTypography.of(this);

  /// Returns the radius tokens from the active theme.
  ///
  /// Example: `context.ckRadius.md`
  ckcoreRadius get ckRadius => CKRadius.of(this);

  /// Returns the elevation tokens from the active theme.
  ///
  /// Example: `context.ckElevation.sm`
  ckcoreElevation get ckElevation => CKElevation.of(this);

  /// Returns the shadow tokens from the active theme.
  ///
  /// Example: `context.ckShadows.sm`
  ckcoreShadows get ckShadows => CKShadows.of(this);

  /// Returns the motion tokens from the active theme.
  ///
  /// Example: `context.ckMotion.fast`
  ckcoreMotion get ckMotion => CKMotion.of(this);

  /// Returns the opacity tokens from the active theme.
  ///
  /// Example: `context.ckOpacity.disabled`
  ckcoreOpacity get ckOpacity => CKOpacity.of(this);

  /// Returns the breakpoint tokens from the active theme.
  ///
  /// Example: `context.ckBreakpoints.md`
  ckcoreBreakpoints get ckBreakpoints => CKBreakpoints.of(this);
}
