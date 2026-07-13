# Typography

## Overview

All text in the product uses styles from `CkgocTypography`.
Never use `TextStyle(fontSize: 16)` directly — always reference a token.

## Scale

| Token | Size | Weight | Use Case |
|---|---|---|---|
| `displayXl` | 56 | Bold | Hero / splash screens |
| `displayLg` | 48 | Bold | Large marketing headings |
| `displayMd` | 40 | SemiBold | Sub-display headings |
| `headingXl` | 32 | Bold | Page title |
| `headingLg` | 24 | Bold | Section heading |
| `headingMd` | 20 | SemiBold | Card heading |
| `headingSm` | 16 | SemiBold | Sub-section heading |
| `headingXs` | 14 | SemiBold | Small heading, label |
| `bodyLg` | 18 | Regular | Long-form text |
| `bodyMd` | 16 | Regular | Default body text |
| `bodySm` | 14 | Regular | Secondary body |
| `bodyXs` | 12 | Regular | Caption, footnote |
| `labelLg` | 16 | Medium | Button, input label |
| `labelMd` | 14 | Medium | Tag, chip label |
| `labelSm` | 12 | Medium | Badge, micro label |
| `codeMd` | 14 | Regular | Inline code |
| `codeSm` | 12 | Regular | Code caption |

## Usage

```dart
Text(
  'Welcome back',
  style: context.ckgocTheme.typography.headingLg,
)
```

## Brand Fonts

Each brand defines its own font family in `<brand>_typography.dart`.
Font assets live in `assets/fonts/<brand>/`.

TODO: Add `.ttf` / `.otf` files and register them in `pubspec.yaml`.
