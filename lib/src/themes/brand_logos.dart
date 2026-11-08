import 'package:flutter/foundation.dart';

import 'package:ckcoreui/src/components/component_enums.dart';

/// Packaged logo asset paths for one brand.
///
/// Each brand theme supplies its own [BrandLogos] through
/// `ckcoreThemeData.logos`, so widgets never need to switch on the brand to
/// pick a logo. Adding a brand means setting this in its theme builders.
///
/// Any path may be `null` when the brand has no such asset yet;
/// `BrandIcon.brandLogoWidget` then renders a typographic fallback.
@immutable
class BrandLogos {
  const BrandLogos({this.master, this.symbol, this.name, this.nav});

  /// Combined mark (symbol and name). Used for [BrandIconVariant.master].
  final String? master;

  /// Symbol only. Used for [BrandIconVariant.logo].
  final String? symbol;

  /// Wordmark only. Used for [BrandIconVariant.name].
  final String? name;

  /// Compact logo shown in navigation chrome (`CKSideNav`, `CKDrawer`).
  final String? nav;

  /// A brand with no logo assets.
  static const BrandLogos none = BrandLogos();

  /// The asset path for [variant], or `null` when the brand has none.
  String? forVariant(BrandIconVariant variant) => switch (variant) {
    BrandIconVariant.master => master,
    BrandIconVariant.logo => symbol,
    BrandIconVariant.name => name,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandLogos &&
          master == other.master &&
          symbol == other.symbol &&
          name == other.name &&
          nav == other.nav;

  @override
  int get hashCode => Object.hash(master, symbol, name, nav);
}
