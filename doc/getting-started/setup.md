# Setup

## Wrap your app

Wrap your root widget with `ckcoreApp` to inject the design system into the widget tree.

```dart
void main() {
  runApp(
    ckcoreApp(
      brand: ckcoreBrand.skyGo,  // or ckcoreBrand.castleKeep
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

`ckcoreApp` reads the system brightness by default. To override:

```dart
ckcoreApp(
  brand: ckcoreBrand.castleKeep,
  brightness: Brightness.dark,  // force dark mode
  child: ...,
)
```

## Read the theme anywhere

```dart
// Preferred — extension method
final theme = context.ckcoreTheme;

// Explicit static method
final theme = ckcoreTheme.of(context);
```

## Override theme for a subtree

```dart
ckcoreTheme(
  data: ckcoreTheme.of(context).copyWith(
    colors: myOverrideColors,
  ),
  child: MySpecialSection(),
)
```

## Text Extensions

### Blockquote

Apply blockquote styling with the `.blockQuote` extension for clean, semantic text formatting:

```dart
const Text('This is a blockquote').blockQuote
```

This creates a left-bordered, italicized text container using the design system's primary color and spacing tokens.

### All available extensions

The package exposes a set of small, chainable text extension helpers for common typographic and semantic needs. Use them directly on `Text` widgets, for example: `Text('Hello').bold.primary`.

 - Text modifiers: `.bold`, `.regular`, `.medium`, `.semibold`, `.italic`, `.underline`, `.lineThrough`, `.uppercase`, `.lowercase`
 - Semantic heading shortcuts: `.h1`, `.h2`, `.h3`, `.h4`, `.h5`, `.h6` (maps to `display2xl`, `displayXl`, `displayLg`, `displayMd`, `displaySm`, `textXl`)
 - Typography styles: `.display2xl`, `.displayXl`, `.displayLg`, `.displayMd`, `.displaySm`, `.textXl`, `.textLg`, `.textMd`, `.textSm`, `.textXs`, `.labelXl`, `.labelLg`, `.labelMd`, `.labelSm`, `.codeMd`
 - Semantic & color helpers (public): `.primary`, `.secondary`, `.success`, `.warning`, `.error`, `.info`, `.surface`, `.onSurface`, `.outline`, `.muted`

**Golden rule — modifier order**: Apply modifiers (e.g. `.bold`, `.italic`, `.lineThrough`) before typography or color helpers because those return a `Widget`. Example: `Text('Hi').bold.h1` (preferred).

Example usages:

```dart
Text('Bold').bold
Text('Primary color').primary
Text('Bold + primary').bold.primary
Text('Code').codeMd.primary
const Text('Blockquote').blockQuote

// Semantic heading shortcuts
Text('Page Title').h1
Text('Section').h2.primary
Text('Subsection').h3
Text('Card Title').h4.bold
```

## Migration: Replace local widgets with `ckcoreui` components

Follow these steps to migrate an existing app that uses local/company widgets to the `ckcoreui` design system.

1. Add the dependency

```bash
flutter pub add ckcoreui
# or, during development using a local copy:
dart pub add --path ../ckcoreui
```

2. Import the package

```dart
import 'package:ckcoreui/ckcore_core.dart';
```

3. Replace your app root

Before:

```dart
void main() => runApp(MaterialApp(home: MyHomePage()));
```

After:

```dart
void main() => runApp(
  ckcoreApp(
    brand: ckcoreBrand.skyGo,
    child: MaterialApp(home: MyHomePage()),
  ),
);
```

4. Use the design system theme

Search for `context.companyTheme` and replace with `context.ckcoreTheme`.

Before:

```dart
final theme = context.companyTheme;
```

After:

```dart
final theme = context.ckcoreTheme;
```

5. Replace component types and imports

- Replace local widgets like `CompanyButton` with `ckcoreButton` and remove local imports in favor of the package import above.

Before:

```dart
import '../widgets/company_button.dart';

CompanyButton(onPressed: () {}, label: 'Save')
```

After:

```dart
import 'package:ckcoreui/ckcore_core.dart';

ckcoreButton(onPressed: () {}, label: 'Save')
```

6. Update assets & fonts

If your local widgets relied on custom fonts or icons, add them to your app's `pubspec.yaml` under `fonts:` and `assets:` and copy any required files from `ckcoreui`'s `assets/` directory.

7. Run dependency fetch, analyze, and test

```bash
flutter pub get
flutter analyze
flutter run
```

8. Debugging tips

- Use a workspace-wide search/replace for legacy `company_` identifiers: replace `company_` → `ckcore_` and `Company` → `ckcoreui` where appropriate.
- If you encounter duplicate-type errors, ensure you import only `package:ckcoreui/ckcoreui.dart` (not local `company_*` files) and remove any compatibility shims you previously added unless you need them.

9. Validate for pub.dev (optional)

After updating docs and example, run:

```bash
pana
flutter pub publish --dry-run
```

This will surface missing metadata or example/package issues before publishing.

If you'd like, I can run `flutter analyze` and `pana` now and fix any issues found.
