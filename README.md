

ckgoc_core — Company design system and UI components for Flutter
===============================================================

ckgoc_core packages a multi-brand design system (CastleKeep and SkyGo) with
consistent design tokens, components, and full-screen templates. It's
intended for apps that need a reusable, themeable UI foundation that follows
company design guidelines.

The package is designed to provide a consistent UI foundation across multiple
Flutter applications while supporting company-specific branding through a
shared design system.

Key features
- Multi-brand themes: CastleKeep and SkyGo with light/dark variants
- Design tokens: colors, typography, spacing, radius, elevation, motion
- A broad components library: buttons, inputs, cards, tables, overlays
- Templates: auth, CRUD, dashboard screens for fast scaffold
- Example application under `example/`

Installation
------------
Add the package from pub.dev to your application's `pubspec.yaml`:

```yaml
dependencies:
  ckgoc_core: ^0.1.1
```

Then run:

```bash
flutter pub get
```

Dependencies
------------
This package depends on the Flutter SDK and a small set of runtime
dependencies, including `flutter_svg` for SVG rendering and `lucide_icons` for
icons. Consumers only need to add `ckgoc_core` to their `pubspec.yaml`; the
package will bring the required runtime dependencies.

Logo asset naming
------------
Logo assets are stored under `assets/images/logos/<brand>/` and should follow
the project's canonical naming convention: lowercase, underscore-separated,
and include a type segment. Use these names for clarity:

- `brand_master_logo` — combined mark (both symbol and name)
- `brand_logo` — symbol-only (logo)
- `brand_name` — name-only (wordmark)

When there are multiple variants include an index suffix, for example:

- `assets/images/logos/castlekeep/castlekeep_master_logo_1.png`
- `assets/images/logos/castlekeep/castlekeep_logo_1.svg`
- `assets/images/logos/castlekeep/castlekeep_name_logo_1.png`

To normalize existing files, run the provided script from the project root:

```bash
./tools/normalize_logos.sh
```

Using packaged logos
--------------------
The package exports stable asset identifiers via `BrandIcon`. Use these
constants and Flutter's asset loaders to render specific variants from the
package. Examples:

Image (PNG) from the package:

```dart
import 'package:ckgoc_core/ckgoc_core.dart';

Image.asset(
  BrandIcon.castlekeepName,
  package: 'ckgoc_core',
  width: 160,
  fit: BoxFit.contain,
);
```

SVG from the package (rendered by the package using `flutter_svg`):

```dart
import 'package:ckgoc_core/ckgoc_core.dart';

// The package will render SVG assets where appropriate; you can also use
// SvgPicture.asset directly if you prefer.
Widget svg = BrandIcon.brandLogoWidget(context, CkgocBrand.skyGo, size: 160);
```

Side-nav specific logo injection:

```dart
CkgocSideNav(
  sections: sections,
  selectedIndex: selected,
  onItemSelected: onSelect,
  brandName: '',
  logo: Image.asset(
    BrandIcon.castlekeepSymbol,
    package: 'ckgoc_core',
    width: 32,
    height: 32,
  ),
)
```

Package helpers
---------------
`BrandIcon.brandLogoWidget(context, brand)` provides a packaged default
widget for the active brand. The package also exposes `BrandIcon` constants
for every bundled variant and a convenience `assetLogoWidget` helper that
renders raster assets and uses `flutter_svg` to render SVG assets.

Next steps
----------
- Remove non-image files from `assets/images/logos/` (e.g. `.DS_Store`, `.eps`) before publishing.
- Optionally add `flutter_svg` to your app to render SVG variants directly.
- Consider using `CkgocSideNav.logo` to inject a specific logo variant when you need precise control.
If you want a higher-level API, we added `BrandIconWidget` that accepts `brand` + `variant` enums and handles raster/SVG selection and rendering.

The script will rename files and directories under `assets/images/logos` to
the canonical underscore format and attempt to use `git mv` when run inside a
git repository.

Quick start
-----------
Wrap your app with `CkgocApp` to inject the design system:

```dart
void main() {
  runApp(
    CkgocApp(
      brand: CompanyBrand.skyGo,
      child: MaterialApp(home: MyHomePage()),
    ),
  );
}
```

Access tokens anywhere via `context.ckgocTheme`:

```dart
final theme = context.ckgocTheme;
final colors = theme.colors;
final typography = theme.typography;
```

Brand configuration
-------------------
Select `CompanyBrand.castleKeep` or `CompanyBrand.skyGo` when creating
`CkgocApp`. To add a new brand, create a brand folder under
`lib/src/themes/brands/` and register it in the theme resolver.

Brand scaffolding CLI
---------------------
This repository includes a small CLI to scaffold a new brand and auto-register it in the theme resolver. It creates a folder under `lib/src/themes/brands/<brand>/` with placeholder color, typography, and light/dark theme files, then updates the enum and resolver.

Run from the project root:

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

Components and usage
--------------------
The library exposes themed components such as `CkgocButton`,
`CkgocCard`, `CkgocDataTable`, `CkgocTextField`, and more. See the
component examples in the `example/` application for usage patterns.

More documentation
------------------
Detailed guides and API notes live in the `docs/` folder. Start with:

- `docs/getting-started/installation.md`
- `docs/getting-started/quickguide.md`
- `docs/getting-started/setup.md`
- `docs/getting-started/brand-configuration.md`
- `docs/getting-started/data-table.md`

Contributing
------------
Contributions are welcome. Follow the repository branching and pull request
guidelines, and run the `example/` application locally to test component
changes.

License
-------
See the `LICENSE` file for license details.