# Getting Started with ckcoreui

Go from an empty Flutter project to a themed, branded screen in about five minutes.

> **Maintaining or contributing?** Start with the [Architecture overview](../architecture.md). It has the file tree, how the package is designed, the widget list and answers to common developer questions.

## Prerequisites

| You need | Version |
| --- | --- |
| Flutter | `>=3.10.0` |
| Dart SDK | `^3.9.2` |
| Platforms | Android, iOS, Web, macOS, Linux, Windows |

Check yours with `flutter --version`. No Flutter project yet? `flutter create my_app && cd my_app`.

---

## 1. Install

```bash
flutter pub add ckcoreui
```

This edits `pubspec.yaml` and runs `pub get`. `flutter_svg` and `lucide_icons_flutter` come along, and so do the bundled fonts and brand logos. Working from a local checkout? Use a path dependency (`ckcoreui: {path: ../ckcoreui}`).

## 2. Wrap your app in `CKApp`

`CKApp` is a drop-in replacement for `MaterialApp`. It takes the same parameters, plus `brand` and `brightness`.

```dart
import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: ckcoreBrand.castleKeep, // or ckcoreBrand.skyGo
      title: 'My App',
      home: const HomePage(),
    );
  }
}
```

| Parameter | What it does |
| --- | --- |
| `brand` | **Required.** Picks the colour palette, typography and logos: `ckcoreBrand.castleKeep` or `ckcoreBrand.skyGo`. |
| `brightness` | `Brightness.light` / `Brightness.dark` to force a mode. Leave `null` to follow the device. |
| `responsive` | Accepted but currently has no effect (the value is not read). Defaults to `false`. |
| everything else | Forwarded to `MaterialApp` (`home`, `routes`, `title`, `locale`, ...). |

**Switch brand or mode at runtime.** Keep the choice in state and rebuild `CKApp`:

```dart
class _MyAppState extends State<MyApp> {
  ckcoreBrand _brand = ckcoreBrand.castleKeep;
  Brightness? _brightness; // null = follow system

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: _brand,
      brightness: _brightness,
      home: Switch(
        value: _brand == ckcoreBrand.skyGo,
        onChanged: (v) => setState(
          () => _brand = v ? ckcoreBrand.skyGo : ckcoreBrand.castleKeep,
        ),
      ),
    );
  }
}
```

**Routers.** For `go_router` or any Navigator 2.0 setup use `CKApp.router(brand:, routerConfig:)`. For a custom delegate use `CKApp.delegate(brand:, routerDelegate:, routeInformationParser:)`.

> **Coming from `ckcoreApp(child: MaterialApp(...))`?** It still works but is deprecated. Move `home:` and the other `MaterialApp` options onto `CKApp`:
>
> ```dart
> // Before
> ckcoreApp(brand: ckcoreBrand.skyGo, child: MaterialApp(home: MyHomePage()))
> // After
> CKApp(brand: ckcoreBrand.skyGo, home: MyHomePage())
> ```

## 3. Build your first screen

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.ckColors.background,
      body: Padding(
        padding: EdgeInsets.all(context.ckSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back').h2,
            SizedBox(height: context.ckSpacing.md),
            const CKTextField(label: 'Email', hint: 'you@company.com'),
            SizedBox(height: context.ckSpacing.md),
            CKButton(onPressed: () {}, child: const Text('Continue')),
          ],
        ),
      ),
    );
  }
}
```

Run it with `flutter run`, then change `ckcoreBrand.castleKeep` to `ckcoreBrand.skyGo` and hot reload. The whole app re-skins.

Three things to notice:

- **Components are prefixed `CK`**: `CKButton`, `CKTextField`, `CKCard`, `CKDataTable`.
- **Buttons take a `child`**, not a `label` string. Use `CKButton.outline`, `.ghost`, `.secondary`, `.accent` for other variants, or `variant: ButtonVariant.destructive`.
- **Tokens come from `BuildContext`.** Never hard-code colours or pixel values.

---

## 4. Design tokens

Tokens depend on the active brand, brightness and any theme override, so they always come from a `BuildContext` below `CKApp`. Three equivalent ways:

```dart
context.ckColors.primary                 // 1. context extension (shortest)
CKColors.of(context).primary             // 2. static accessor (like Theme.of)
context.ckcoreTheme.colors.primary       // 3. the whole bundle
```

| Family | Extension | Examples |
| --- | --- | --- |
| Colours | `context.ckColors` | `.primary`, `.surface`, `.onSurface`, `.error`, `.success` |
| Spacing | `context.ckSpacing` | `.xs` `.sm` `.md` `.lg` `.xl` (also `.none`, `.s12`, `.s20`, `.s40`, `.x2l` to `.x5l`) |
| Typography | `context.ckTypography` | `.displayLg`, `.textMd`, `.labelSm`, `.codeMd` |
| Radius | `context.ckRadius` | `.sm` `.md` `.lg` |
| Elevation / shadows | `context.ckElevation`, `context.ckShadows` | `.sm` `.md`. `ckShadows.sm` is already a `List<BoxShadow>`: `boxShadow: context.ckShadows.sm`. |
| Motion | `context.ckMotion` | durations `.fast` `.normal` `.slow`; curves `.standard` `.decelerate` |
| Opacity | `context.ckOpacity` | `.disabled`, `.muted`, `.hover` |
| Breakpoints | `context.ckBreakpoints` | `.md` (600), `.lg` (840) |
| Theme bundle | `context.ckcoreTheme` | `.colors`, `.spacing`, `.typography`, `.logos` |

```dart
Container(
  padding: EdgeInsets.all(context.ckSpacing.md),
  decoration: BoxDecoration(
    color: context.ckColors.surface,
    borderRadius: BorderRadius.circular(context.ckRadius.md),
    boxShadow: context.ckShadows.sm,
  ),
  child: Text('Hello', style: context.ckTypography.textMd),
)

AnimatedContainer(
  duration: context.ckMotion.normal,
  curve: context.ckMotion.standard,
  color: context.ckColors.primary,
)
```

Override tokens for one subtree:

```dart
ckcoreTheme(
  data: ckcoreTheme.of(context).copyWith(colors: myOverrideColors),
  child: MySpecialSection(),
)
```

Token values and rationale come from the design team: see [Color](../CORE/color.md), [Spacing & grid](../CORE/spacing_and_grid.md) and the [foundation notes](../foundation/typography.md). The names in the table above are what the code exposes.

## 5. Text helpers

`Text` has chainable helpers so you can skip manual `TextStyle`s. **Modifiers** return a `Text` and chain; **style and colour helpers** return a `Widget`, so use at most one and put it last.

| Kind | Helpers |
| --- | --- |
| Modifiers | `.bold` `.regular` `.medium` `.semibold` `.italic` `.underline` `.lineThrough` `.uppercase` `.lowercase` |
| Headings | `.h1` to `.h6` (map to `display2xl`, `displayXl`, `displayLg`, `displayMd`, `displaySm`, `textXl`) |
| Styles | `.display2xl` ... `.textXs`, `.labelXl` ... `.labelSm`, `.codeMd` |
| Colours | `.primary` `.secondary` `.success` `.warning` `.error` `.info` `.surface` `.onSurface` `.outline` `.muted` |
| Other | `.blockQuote` (left-bordered, italic, primary colour) |

```dart
Text('Page title').h1
Text('Saved!').bold.success      // modifiers first, then one colour/style
Text('Section').bold.h2
Text('Muted caption').muted
Text('Code').codeMd
// Does not compile: Text('Hi').h1.primary, Text('Hi').h1.bold
```

---

## Where to next?

| I want to... | Read |
| --- | --- |
| Add a table with sorting, paging and inline editing | [Data table](data-table.md) |
| Understand, switch or add a brand, or use logos | [Brands](brands.md) |
| Add motion to screens | [Animation (`CKAnimate`)](animation.md) |
| Let Copilot, Claude Code or Cursor write ckcoreui correctly | [AI tools](ai-tools.md) |
| Understand how the package is built, or contribute | [Architecture](../architecture.md) |

## Explore the docs app and the example

The repo ships a Flutter app where every component has a live demo, copy-ready code, a parameter table and FAQs. Switch brand and light/dark from the top-right corner.

```bash
cd doc/flutter_docs
flutter pub get
flutter run -d chrome
```

It depends on the local package by path, so re-run `flutter pub get` there after changing `lib/src`. The hosted version is at <https://castle-keep.github.io/ckgoc_core/>. A smaller showcase lives in `example/` (`cd example && flutter run -d chrome`).

## Migrating an app that has its own widgets

1. `flutter pub add ckcoreui` and import `package:ckcoreui/ckcoreui.dart`.
2. Replace the app root with `CKApp(brand: ..., home: ...)`.
3. Replace `context.companyTheme` with `context.ckcoreTheme`, and local widgets with their `CK*` equivalents (for example `CompanyButton(label: 'Save')` becomes `CKButton(child: Text('Save'))`).
4. Add any fonts or assets your old widgets needed to your app's `pubspec.yaml`; the package already bundles Inter and the brand logos.
5. Run `flutter pub get`, `flutter analyze` and `flutter run`. Duplicate-type errors usually mean a leftover local `company_*` import.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `No CkcoreuiTheme found in context` | The widget is above `CKApp`. Move `CKApp` to the root of `runApp`. (The message mentions `ckcoreApp`; `CKApp` provides the same theme.) |
| `ckcoreApp is deprecated` warning | Switch to `CKApp` (see above). |
| `The named parameter 'label' isn't defined` on `CKButton` | Use `child: Text('...')`. |
| Fonts look different from the docs | Don't override `theme:` on `CKApp`; let `brand` supply it. |
| Logos don't show | Pass `package: 'ckcoreui'` with `Image.asset`, or use `BrandIcon.brandLogoWidget(...)`. |
| Version conflict on `flutter_svg` | Run `flutter pub upgrade flutter_svg`. |

Still stuck? [Open an issue](https://github.com/castle-keep/ckgoc_core/issues/new/choose).
