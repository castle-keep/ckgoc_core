/// The brand identifier for the Company Design System.

///
/// Selecting a brand determines which color palette, typography, logos,
/// and other brand-specific tokens injected by the theme.
///
/// Example:
/// ```dart
/// ckcoreApp(
///   brand: ckcoreBrand.castleKeep,
///   child: MyApp(),
/// )
/// ```
///
/// To add a new brand:
/// 1. Add a new value here.
/// 2. Create `lib/src/themes/brands/<new_brand>/` directory.
/// 3. Implement light + dark [CkcoreuiThemeData] constructors.
/// 4. Register them in [ckcoreThemeResolver].
enum ckcoreBrand {
  // CastleKeep brand — deep navy, gold accents, stone grey neutrals.
  castleKeep,

  // SkyGo brand — sky blue, violet accents, clean modern aesthetic.
  skyGo,
}

extension ckcoreBrandX on ckcoreBrand {
  /// Human-readable display name.
  String get displayName => switch (this) {
    ckcoreBrand.castleKeep => 'CastleKeep',
    ckcoreBrand.skyGo => 'SkyGo',
  };
}

/// Backwards-compatible alias for the old `CkgocBrand` enum name.
typedef CkgocBrand = ckcoreBrand;
