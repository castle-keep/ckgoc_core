---
name: ckcoreui
description: Build Flutter UI with the ckcoreui design system (CKApp, CK* components, design tokens, CastleKeep and SkyGo brands). Use when writing or reviewing Flutter screens in a project that depends on ckcoreui, or when asked for a CK component, theme, brand or token.
---

# ckcoreui

Flutter design system with two brands (CastleKeep, SkyGo), light and dark. Use it instead of raw Material widgets and hard-coded values.

## Setup

```dart
import 'package:ckcoreui/ckcoreui.dart';

void main() => runApp(
  CKApp(brand: ckcoreBrand.castleKeep, home: const HomePage()), // or skyGo
);
```

- `CKApp` replaces `MaterialApp` (same parameters plus `brand`, `brightness`). Never nest a `MaterialApp` inside it.
- `ckcoreApp(child: MaterialApp(...))` is deprecated. Migrate it to `CKApp`.
- Everything below `CKApp` can read the theme. Widgets above it cannot.

## Rules

1. **Tokens, never literals.** Colours `context.ckColors.*`, spacing `context.ckSpacing.*` (`xs sm md lg xl`), type `context.ckTypography.*` (`displayLg`, `textMd`, `labelSm`, `codeMd`), radius `context.ckRadius.*`, motion `context.ckMotion.*`.
2. **Prefer `CK*` components**: `CKButton`, `CKTextField`, `CKCard`, `CKDataTable`, `CKDialog`, `CKBadge`, `CKAnimate`.
3. **Buttons take `child`, not `label`**: `CKButton(onPressed: f, child: Text('Save'))`. Variants via constructors (`CKButton.outline`, `.ghost`, `.secondary`, `.accent`) or `variant: ButtonVariant.destructive`. Sizes via `ButtonSize.xs..xl`.
4. **Text helpers** chain on `Text`: modifiers first, then style or colour. `Text('Hi').bold.h1`, `Text('Saved').success`.
5. **Brand and mode are runtime state**: keep `ckcoreBrand` and `Brightness?` in state and pass them to `CKApp`.
6. **Animate with `CKAnimate`**, not hand-rolled controllers: `CKAnimate(animation: CKAnimation.slideUp, child: ...)`; lists via `CKAnimate.stagger(children: [...])`.
7. **Logos**: `BrandIcon.brandLogoWidget(context, brand)`; with `Image.asset` pass `package: 'ckcoreui'`.

## Common mistakes

| Wrong | Right |
| --- | --- |
| `CKApp(child: MaterialApp(...))` | `CKApp(home: ...)` |
| `CKButton(label: 'Save')` | `CKButton(child: Text('Save'))` |
| `Color(0xFF0070DE)` | `context.ckColors.primary` |
| `EdgeInsets.all(16)` | `EdgeInsets.all(context.ckSpacing.md)` |
| `Brand.skyGo` | `ckcoreBrand.skyGo` |
| `CKDataTable` editing via `editableColumns` / `onCellChanged` | `editableCells` with `CKEditableCell.validator` |
| `CKSideNav(selectedIndex:, onItemSelected:)` | `selectedKey:`, `onItemSelectedKey:` |

## Looking things up

If the `ckcoreui` MCP server is connected, call `getComponent`, `getTokens`, `getPattern`, `getBrandConfig` or `generateCode` instead of guessing. Otherwise read the package source in `lib/src/components/` or the docs at https://castle-keep.github.io/ckgoc_core/.
