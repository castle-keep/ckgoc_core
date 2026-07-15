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
- If you want different default colors/typography, edit the generated files in `lib/src/themes/brands/<brand>/`.

Files touched
------------

- [bin/ckgoc.dart](bin/ckgoc.dart)
- [lib/src/themes/ckgoc_brand.dart](lib/src/themes/ckgoc_brand.dart)
- [lib/src/themes/ckgoc_theme_resolver.dart](lib/src/themes/ckgoc_theme_resolver.dart)
