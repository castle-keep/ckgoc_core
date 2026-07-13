

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