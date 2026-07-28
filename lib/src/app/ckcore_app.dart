import 'package:flutter/material.dart';

import 'package:ckcoreui/src/app/ck_app.dart';
import 'package:ckcoreui/src/themes/ckcore_brand.dart';

/// Deprecated: Use [CKApp] instead.
///
/// This is a legacy wrapper that applies [CKApp] as a thin provider.
/// For new code, prefer using [CKApp] directly:
///
/// ```dart
/// // Old way (deprecated):
/// ckcoreApp(
///   brand: ckcoreBrand.castleKeep,
///   child: MaterialApp(home: HomePage()),
/// )
///
/// // New way:
/// CKApp(
///   brand: ckcoreBrand.castleKeep,
///   home: HomePage(),
/// )
/// ```
@Deprecated('Use CKApp instead. See CKApp documentation for migration.')
class ckcoreApp extends StatelessWidget {
  const ckcoreApp({
    required this.brand,
    required this.child,
    super.key,
    this.brightness,
  });
  final ckcoreBrand brand;

  /// Override system brightness. Leave null to follow the device setting.
  final Brightness? brightness;

  /// The widget subtree wrapped by `ckcoreApp`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Delegate to CKApp for theme resolution
    // This provides a migration path for existing code
    return CKApp(brand: brand, brightness: brightness, home: child);
  }
}

/// Deprecated typedef for backward compatibility.
/// Use [CKApp] instead.
@Deprecated('Use CKApp instead')
typedef CkgocApp = ckcoreApp;
