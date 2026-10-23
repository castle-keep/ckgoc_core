# Getting Started with ckcoreui

Go from an empty Flutter project to a themed, branded screen in about five minutes.

> **Prefer to click around?** Run the interactive docs app and open **Get Started**
> (see [Explore the docs app](#explore-the-docs-app)). Every snippet below has a live version there.

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

This edits `pubspec.yaml` and runs `pub get` for you. `flutter_svg` and `lucide_icons_flutter` come along automatically, and so do the bundled fonts and brand logos. You don't need to declare them.

Working from a local checkout instead? Use a path dependency:

```yaml
dependencies:
  ckcoreui:
    path: ../ckcoreui
```

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
| `responsive` | Wraps the app in a responsive-aware layout provider. Defaults to `false`. |
| everything else | Forwarded to `MaterialApp` (`home`, `routes`, `title`, `locale`, ...). |

Using `go_router` or another Navigator 2.0 setup? Use `CKApp.router(brand: ..., routerConfig: ...)`. See [Setup](setup.md#router--delegate-navigator-20).

> **Coming from `ckcoreApp(child: MaterialApp(...))`?** It still works but is deprecated. Move your `home:` and other options onto `CKApp` directly. See [Migrating](setup.md#migrating-from-ckcoreapp).

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
            CKButton(
              onPressed: () {},
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Run it with `flutter run`. Then change `ckcoreBrand.castleKeep` to `ckcoreBrand.skyGo` and hot reload. The whole app re-skins.

Three things to notice:

- **Components are prefixed `CK`**: `CKButton`, `CKTextField`, `CKCard`, `CKDataTable`.
- **Buttons take a `child`**, not a `label` string. Use `CKButton.outline`, `.ghost`, `.secondary`, `.accent` for other variants, or `variant: ButtonVariant.destructive`.
- **Tokens come from `BuildContext`.** Never hard-code colours or pixel values.

## 4. Use design tokens

Read tokens from any widget below `CKApp`:

| Accessor | Gives you | Example |
| --- | --- | --- |
| `context.ckColors` | semantic colours | `.primary`, `.surface`, `.onSurface`, `.error`, `.success` |
| `context.ckSpacing` | spacing scale | `.xs` `.sm` `.md` `.lg` `.xl` |
| `context.ckTypography` | text styles | `.displayLg`, `.textMd`, `.labelSm`, `.codeMd` |
| `context.ckRadius` | corner radii | `.sm` `.md` `.lg` |
| `context.ckElevation` / `ckShadows` | depth | `.sm` `.md` |
| `context.ckMotion` | durations and curves | `.fast` `.normal` `.slow` |
| `context.ckBreakpoints` | responsive thresholds | `.md` |
| `context.ckcoreTheme` | the whole bundle | `.colors`, `.spacing`, `.typography` |

Text also has chainable helpers, so you can skip manual `TextStyle`s:

```dart
Text('Page title').h1
Text('Saved!').bold.success      // modifiers first, then colour/style
Text('Muted caption').textSm.muted
```

More in [Design Tokens Quick Access](design-tokens-quick-access.md).

---

## Where to next?

| I want to... | Read |
| --- | --- |
| Add a table with sorting, paging and editing | [Data Table Guide](data-table.md) |
| Make table cells editable | [Editable cells](editable-cells.md) |
| Set up routing, text extensions or migrate an old app | [Setup](setup.md) |
| Understand, switch or add a brand | [Brands](brands.md) |
| Use or add logos | [Brand logos](brand-logos.md) |
| Look up tokens | [Design Tokens Quick Access](design-tokens-quick-access.md) · [Colors](../foundation/colors.md) · [Typography](../foundation/typography.md) · [Spacing](../foundation/spacing.md) |
| Add motion to screens | [Animation (`CKAnimate`)](animation.md) |
| Let Copilot, Claude Code or Cursor write ckcoreui correctly | [AI tools: MCP server and skills](ai-tools.md) |

## Explore the docs app

The repo ships a Flutter app where every component has a live demo, copy-ready code, a parameter table and FAQs. Switch brand and light/dark from the top-right corner and watch every demo update.

```bash
cd doc/flutter_docs
flutter pub get
flutter run -d chrome
```

The docs app depends on the local package by path, so after changing `lib/src` re-run `flutter pub get` in that folder. Or browse the hosted version at <https://castle-keep.github.io/ckgoc_core/>.

There's also a smaller showcase in `example/`:

```bash
cd example
flutter run -d chrome
```

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `No CkcoreuiTheme found in context` | The widget is above `CKApp`. Move `CKApp` to the root of `runApp`. (The message says `ckcoreApp`; `CKApp` provides the same theme.) |
| `ckcoreApp is deprecated` warning | Switch to `CKApp`. See [Migrating](setup.md#migrating-from-ckcoreapp). |
| `The named parameter 'label' isn't defined` on `CKButton` | Use `child: Text('...')`. |
| Fonts look different from the docs | Make sure you didn't override `theme:` on `CKApp`. Let `brand` supply it. |
| Logos don't show | Pass `package: 'ckcoreui'` when using `Image.asset`, or use `BrandIcon.brandLogoWidget(...)`. |
| Version conflict on `flutter_svg` | Run `flutter pub upgrade flutter_svg`. |

Still stuck? [Open an issue](https://github.com/castle-keep/ckgoc_core/issues/new/choose).
