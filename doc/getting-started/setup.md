# Setup

## Wrap your app

Wrap your root widget with `CkgocApp` to inject the design system into the widget tree.

```dart
void main() {
  runApp(
    CkgocApp(
      brand: CkgocBrand.skyGo,  // or CkgocBrand.castleKeep
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

`CkgocApp` reads the system brightness by default. To override:

```dart
CkgocApp(
  brand: CkgocBrand.castleKeep,
  brightness: Brightness.dark,  // force dark mode
  child: ...,
)
```

## Read the theme anywhere

```dart
// Preferred — extension method
final theme = context.ckgocTheme;

// Explicit static method
final theme = CkgocTheme.of(context);
```

## Override theme for a subtree

```dart
CkgocTheme(
  data: CkgocTheme.of(context).copyWith(
    colors: myOverrideColors,
  ),
  child: MySpecialSection(),
)
```

## Migration: Replace local widgets with `ckgoc_core` components

Follow these steps to migrate an existing app that uses local/company widgets to the `ckgoc_core` design system.

1. Add the dependency

```bash
flutter pub add ckgoc_core
# or, during development using a local copy:
dart pub add --path ../ckgoc_core
```

2. Import the package

```dart
import 'package:ckgoc_core/ckgoc_core.dart';
```

3. Replace your app root

Before:

```dart
void main() => runApp(MaterialApp(home: MyHomePage()));
```

After:

```dart
void main() => runApp(
  CkgocApp(
    brand: CkgocBrand.skyGo,
    child: MaterialApp(home: MyHomePage()),
  ),
);
```

4. Use the design system theme

Search for `context.companyTheme` and replace with `context.ckgocTheme`.

Before:

```dart
final theme = context.companyTheme;
```

After:

```dart
final theme = context.ckgocTheme;
```

5. Replace component types and imports

- Replace local widgets like `CompanyButton` with `CkgocButton` and remove local imports in favor of the package import above.

Before:

```dart
import '../widgets/company_button.dart';

CompanyButton(onPressed: () {}, label: 'Save')
```

After:

```dart
import 'package:ckgoc_core/ckgoc_core.dart';

CkgocButton(onPressed: () {}, label: 'Save')
```

6. Update assets & fonts

If your local widgets relied on custom fonts or icons, add them to your app's `pubspec.yaml` under `fonts:` and `assets:` and copy any required files from `ckgoc_core`'s `assets/` directory.

7. Run dependency fetch, analyze, and test

```bash
flutter pub get
flutter analyze
flutter run
```

8. Debugging tips

- Use a workspace-wide search/replace for legacy `company_` identifiers: replace `company_` → `ckgoc_` and `Company` → `Ckgoc` where appropriate.
- If you encounter duplicate-type errors, ensure you import only `package:ckgoc_core/ckgoc_core.dart` (not local `company_*` files) and remove any compatibility shims you previously added unless you need them.

9. Validate for pub.dev (optional)

After updating docs and example, run:

```bash
pana
flutter pub publish --dry-run
```

This will surface missing metadata or example/package issues before publishing.

If you'd like, I can run `flutter analyze` and `pana` now and fix any issues found.
