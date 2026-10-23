# Brand logos

CastleKeep and SkyGo logos ship inside the package and are exposed as `BrandIcon` constants.

## Quick use

```dart
// Rendered for the active brand (works for PNG and SVG)
BrandIcon.brandLogoWidget(context, ckcoreBrand.skyGo, size: 40);

// Choose the variant: master (symbol + name), logo (symbol only), name (wordmark)
BrandIcon.brandLogoWidget(
  context,
  ckcoreBrand.castleKeep,
  size: 160,
  variant: BrandIconVariant.name,
);

// Override with a specific packaged asset
BrandIcon.brandLogoWidget(
  context,
  ckcoreBrand.skyGo,
  assetPath: BrandIcon.skygoLogo2,
);
```

Use the constants directly with Flutter's loaders. **Always pass `package: 'ckcoreui'`** when loading from an app:

```dart
// PNG
Image.asset(BrandIcon.castlekeepName, package: 'ckcoreui', width: 160, fit: BoxFit.contain);

// SVG (needs flutter_svg, which ckcoreui already depends on)
SvgPicture.asset(BrandIcon.skygoMasterSvg, package: 'ckcoreui', width: 120);
```

Inject a logo into the side navigation:

```dart
CKSideNav(
  sections: sections,
  selectedIndex: selected,
  onItemSelected: onSelect,
  logo: Image.asset(BrandIcon.castlekeepSymbol, package: 'ckcoreui', width: 32, height: 32),
)
```

## Naming convention

Assets live under `assets/images/logos/<brand>/`. File names are lowercase `snake_case` with a type segment, plus an index when there are several variants:

| Segment | Meaning |
| --- | --- |
| `master_logo` | combined mark (symbol and name) |
| `logo` | symbol only |
| `name_logo` | name only (wordmark) |

Examples: `castlekeep_master_logo_1.png`, `castlekeep_logo_1.svg`, `skygo_name_logo_1.svg`.

Maintainers: run `./tools/normalize_logos.sh` to rename existing files to this convention (it uses `git mv` inside a git repo), and remove non-image files (`.DS_Store`, `.pages`, `.eps`) from the logo folders before publishing so the asset manifest only contains images. Adding a brand does **not** add logo assets; see [Brands](brands.md).

## All constants

The full list of `BrandIcon` constants and the asset each one points to is maintained with the design system: [CORE/brand_logos_constants.md](../CORE/brand_logos_constants.md).
