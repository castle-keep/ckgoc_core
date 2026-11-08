# Brands and logos

## Available brands

| Enum | Display name | Description |
| --- | --- | --- |
| `ckcoreBrand.castleKeep` | CastleKeep | Deep green primary (`#02372E`), gold accent (`#E9BB43`) |
| `ckcoreBrand.skyGo` | SkyGo | Sky blue primary (`#0070DE`), pale-blue accent (`#F4FCFF`) |

Both brands share the same neutral scale and semantic (success, warning, error, info) colours. Exact values: [CORE/color.md](../CORE/color.md).

Pick one on `CKApp(brand: ...)`. To switch at runtime, keep the brand in state and rebuild `CKApp` (see [Getting started](README.md#2-wrap-your-app-in-ckapp)). Each brand has a light and a dark theme, resolved from the system brightness unless you pass `brightness:`.

## Logos

CastleKeep and SkyGo logos ship inside the package and are exposed as `BrandIcon` constants. Each brand theme also declares which ones it uses (`context.ckcoreTheme.logos`: `master`, `symbol`, `name`, `nav`).

```dart
// Rendered for a brand (works for PNG and SVG)
BrandIcon.brandLogoWidget(context, ckcoreBrand.skyGo, size: 40);

// Choose the variant: master (symbol + name), logo (symbol only), name (wordmark)
BrandIcon.brandLogoWidget(
  context,
  ckcoreBrand.castleKeep,
  size: 160,
  variant: BrandIconVariant.name,
);

// Override with a specific packaged asset
BrandIcon.brandLogoWidget(context, ckcoreBrand.skyGo, assetPath: BrandIcon.skygoLogo2);
```

If a brand has no logo assets (`BrandLogos.none`), `brandLogoWidget` shows the brand's initial instead.

Use the constants directly with Flutter's loaders. **Always pass `package: 'ckcoreui'`** when loading from an app:

```dart
Image.asset(BrandIcon.castlekeepName, package: 'ckcoreui', width: 160, fit: BoxFit.contain);   // PNG
SvgPicture.asset(BrandIcon.skygoMasterSvg, package: 'ckcoreui', width: 120);                  // SVG
```

Inject a logo into the side navigation (otherwise it uses the theme's `nav` logo):

```dart
CKSideNav(
  sections: sections,
  selectedIndex: selected,
  onItemSelected: onSelect,
  logo: Image.asset(BrandIcon.castlekeepSymbol, package: 'ckcoreui', width: 32, height: 32),
)
```

The full list of constants and the file each one points to is in [CORE/brand_logos_constants.md](../CORE/brand_logos_constants.md).

**Asset naming.** Files live under `assets/images/logos/ck/` (CastleKeep) and `assets/images/logos/skygo/` (SkyGo), lowercase `snake_case` with a type segment and an index: `master_logo` (symbol and name), `logo` (symbol only), `name_logo` (wordmark). Examples: `castlekeep_master_logo_1.png`, `castlekeep_logo_1.svg`, `skygo_name_logo_1.svg`. Maintainers can run `./tools/normalize_logos.sh` to rename files to this convention (it uses `git mv` inside a git repo); remove non-image files (`.DS_Store`, `.pages`, `.eps`) from the logo folders before publishing.

## Adding a new brand

1. Add a value to `ckcoreBrand` in `lib/src/themes/ckcore_brand.dart`, with a case in its `displayName` switch.
2. Create `lib/src/themes/brands/<name>/` with:
   - `<name>_colors.dart`: primitive palette
   - `<name>_typography.dart`: type scale
   - `<name>_light_theme.dart` and `<name>_dark_theme.dart`: each returns a `ckcoreThemeData`
3. Register both themes in `ckcoreThemeResolver.resolve()`.
4. Export the new files from `lib/src/themes/themes.dart`.
5. Optionally set `logos: const BrandLogos(master:, symbol:, name:, nav:)` in both theme builders. It defaults to `BrandLogos.none`. No other file needs to know about the new brand.

### Scaffolding with the CLI

Inside a clone of this repo, from the project root, for a brand named "Acme":

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

It creates the four files with placeholder colours and typography, adds the enum value and its `displayName` case, and adds the imports and switch cases to the resolver. It does not do step 4 (the export) or add logo assets.

- The tool does simple textual edits. Review and commit what it changes.
- Directory names drop spaces and punctuation; the enum value is lowerCamelCase.
- Generated themes use `logos: BrandLogos.none`.
- `test/cli/add_brand_test.dart` runs the CLI on a throwaway copy of the package and checks that the result passes `flutter analyze`.
