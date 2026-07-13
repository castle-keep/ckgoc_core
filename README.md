

ckgoc_core — Company design system and UI components for Flutter
===============================================================

ckgoc_core packages a multi-brand design system (CastleKeep and SkyGo) with
consistent design tokens, components, and full-screen templates. It's
intended for apps that need a reusable, themeable UI foundation that follows
company design guidelines.

Key features
- Multi-brand themes: CastleKeep and SkyGo with light/dark variants
- Design tokens: colors, typography, spacing, radius, elevation, motion
- A broad components library: buttons, inputs, cards, tables, overlays
- Templates: auth, CRUD, dashboard screens for fast scaffold
- Small standalone showcase app under `showcase/`

Installation
------------
Add the dependency to your app's `pubspec.yaml` (git or local path during
development):

```yaml
dependencies:
	ckgoc_core:
		git:
			url: https://github.com/company/ckgoc_core.git
			ref: main
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
`CkgocCard`, `CkgocDataTable`, `CkgocTextField` and more. See the
component examples in the `showcase/` app for usage patterns.

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
Contributions are welcome. Follow the repo branching and PR guidelines and
run the `showcase/` app locally to test component changes.

License
-------
See the `LICENSE` file for license details.

