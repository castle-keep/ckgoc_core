Brand scaffolding CLI
=====================

What it does
------------

The project includes a small Dart CLI to scaffold a new brand and auto-register it in the theme resolver. The tool:

- Creates a new folder under `lib/src/themes/brands/<brand>/`.
- Adds placeholder files: `<brand>_colors.dart`, `<brand>_typography.dart`, `<brand>_light_theme.dart`, `<brand>_dark_theme.dart`.
- Updates the `CkgocBrand` enum in `lib/src/themes/ckgoc_brand.dart` and the `displayName` mapping.
- Adds imports and switch cases to `lib/src/themes/ckgoc_theme_resolver.dart` to register the new brand's light/dark theme builders.

How to use
----------

Run the command from the project root. For example to add a brand named "Acme":

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

Notes
-----

- The tool performs simple textual edits; review the modified files and commit them as appropriate.
- Filenames and Dart identifiers follow simple transformations: spaces/punctuation are removed for directory names and enum values are lowerCamelCase derived from the brand name.
To normalize existing logo files in the repo run the included script:

- If you want different default colors/typography, edit the generated files in `lib/src/themes/brands/<brand>/`.

Files touched
------------

- [bin/ckgoc.dart](bin/ckgoc.dart)
- [lib/src/themes/ckgoc_brand.dart](lib/src/themes/ckgoc_brand.dart)
- [lib/src/themes/ckgoc_theme_resolver.dart](lib/src/themes/ckgoc_theme_resolver.dart)

Logo asset naming
-----------------

The scaffold creates placeholder brand folders but does not add logo assets.
Logo assets live under `assets/images/logos/<brand>/` and should follow the
project's canonical naming convention: lowercase, underscore_separated, and
include a type segment (e.g. `master_logo`, `logo`, `name_logo`) followed by
an index if needed.

Examples:

- `assets/images/logos/castlekeep/castlekeep_master_logo_1.svg`
- `assets/images/logos/castlekeep/castlekeep_name_logo_1.svg`
- `assets/images/logos/skygo/skygo_master_logo_1.svg`

To normalize existing logo files in the repo run the included script:

```bash
./tools/normalize_logos.sh
```

This will rename files and directories under `assets/images/logos` to the
canonical kebab-case format and attempt to use `git mv` when run inside a
git repository.

Using packaged logo constants
The package exposes constants in `BrandIcon` that map to the canonical
asset paths. Consumers can reference these constants directly and load them
from the package. Example usage:

```dart
// PNG
Image.asset(
	BrandIcon.castlekeepMaster,
	package: 'ckgoc_core',
	width: 120,
);

// SVG (use flutter_svg)
SvgPicture.asset(
	BrandIcon.skygoMasterSvg,
	package: 'ckgoc_core',
	width: 120,
);
```

Rendering in package components
-------------------------------
The package provides `BrandIcon.brandLogoWidget(context, brand)` as a
default renderer for the active brand. For precise control (choose master,
name, or symbol variants), pass a widget to `CkgocSideNav.logo` or build
your own `Image.asset`/`SvgPicture.asset` using the `BrandIcon` paths.

Next steps for maintainers
-------------------------
- Remove non-image files (e.g. `.DS_Store`, `.pages`, `.eps`) from the
	`assets/images/logos` folders before publishing so the asset manifest
	only includes intended image files.
- Consider using the bundled `BrandIcon` helper that accepts `brand`
	and `variant` enums to standardize logo selection and rendering across
	the codebase.
