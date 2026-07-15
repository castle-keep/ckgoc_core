/// The brand identifier for the Company Design System.
///
/// Selecting a brand determines which color palette, typography, logos,
/// and other brand-specific tokens injected by the theme.
///
/// Example:
/// ```dart
/// CkgocApp(
///   brand: CkgocBrand.castleKeep,
///   child: MyApp(),
/// )
/// ```
///
/// To add a new brand:
/// 1. Add a new value here.
/// 2. Create `lib/src/themes/brands/<new_brand>/` directory.
/// 3. Implement light + dark [CkgocThemeData] constructors.
/// 4. Register them in [CkgocThemeResolver].
enum CkgocBrand {
  // CastleKeep brand — deep navy, gold accents, stone grey neutrals.
  castleKeep,

  // SkyGo brand — sky blue, violet accents, clean modern aesthetic.
  skyGo,
}

extension CkgocBrandX on CkgocBrand {
  /// Human-readable display name.
  String get displayName => switch (this) {
    CkgocBrand.castleKeep => 'CastleKeep',
    CkgocBrand.skyGo => 'SkyGo',
  };
}
