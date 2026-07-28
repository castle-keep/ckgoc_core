# Brand Configuration

## Available Brands

| Enum | Display Name | Description |
|---|---|---|
| `ckcoreBrand.castleKeep` | CastleKeep | Navy, gold accents, warm stone neutrals |
| `ckcoreBrand.skyGo` | SkyGo | Sky blue, violet accents, clean slate neutrals |

## Selecting a Brand

```dart
ckcoreApp(
  brand: ckcoreBrand.castleKeep,
  child: ...,
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
    return ckcoreApp(
      brand: _brand,
      child: MaterialApp(
        home: SettingsScreen(
          onBrandChanged: (b) => setState(() => _brand = b),
        ),
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
