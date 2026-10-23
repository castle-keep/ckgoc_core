# Brand Configuration

## Available Brands

| Enum | Display Name | Description |
|---|---|---|
| `ckcoreBrand.castleKeep` | CastleKeep | Navy, gold accents, warm stone neutrals |
| `ckcoreBrand.skyGo` | SkyGo | Sky blue, violet accents, clean slate neutrals |

## Selecting a Brand

```dart
CKApp(
  brand: ckcoreBrand.castleKeep,
  home: ...,
)
```

## Switching Brands at Runtime

Lift the brand into your app state:

```dart
class MyApp extends StatefulWidget { ... }
class _MyAppState extends State<MyApp> {
  ckcoreBrand _brand = ckcoreBrand.skyGo;

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: _brand,
      home: SettingsScreen(
        onBrandChanged: (b) => setState(() => _brand = b),
      ),
    );
  }
}
```

## Adding a New Brand

1. Add a new value to `lib/src/themes/ckcore_brand.dart`
2. Create `lib/src/themes/brands/<name>/` with:
   - `<name>_colors.dart` — primitive palette
   - `<name>_typography.dart` — type scale
   - `<name>_light_theme.dart` — `ckcoreThemeData` light
   - `<name>_dark_theme.dart` — `ckcoreThemeData` dark
3. Register both themes in `ckcoreThemeResolver.resolve()`
4. Export from `lib/src/themes/themes.dart`

### Scaffolding with the CLI

The repo includes a small Dart CLI that scaffolds a new brand and registers it for you. From the project root, for a brand named "Acme":

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

It:

- creates `lib/src/themes/brands/<brand>/` with placeholder `<brand>_colors.dart`, `<brand>_typography.dart`, `<brand>_light_theme.dart` and `<brand>_dark_theme.dart`;
- adds the value (and its `displayName`) to the `ckcoreBrand` enum in `lib/src/themes/ckcore_brand.dart`;
- adds imports and switch cases to `lib/src/themes/ckcore_theme_resolver.dart` so both themes resolve.

Notes:

- The tool does simple textual edits. Review and commit the changes it makes.
- Directory names drop spaces and punctuation; the enum value is lowerCamelCase derived from the name.
- Edit the generated files to set your real colours and typography.
- Logo assets are **not** created. See [Brand logos](brand-logos.md).
