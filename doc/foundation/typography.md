# Typography

## Overview

All text in the product uses styles from `ckcoreTypography`.
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

### Direct typography styles

```dart
Text(
  'Welcome back',
  style: context.ckcoreTheme.typography.headingLg,
)
```

### Semantic heading shortcuts

Use `.h1` through `.h6` extensions for semantic HTML-style headings:

```dart
// Shorthand for semantic headings
Text('Page Title').h1           // display2xl (32px, Bold)
Text('Section').h2              // displayXl (28px, Bold)
Text('Subsection').h3           // displayLg (24px, Bold)
Text('Card Title').h4           // displayMd (20px, Bold)
Text('Label').h5                // displaySm (18px, Medium)
Text('Secondary').h6            // textXl (20px, Regular)

// Combine with color extensions
Text('Page Title').h1.primary    // h1 with primary color
Text('Section').h2.bold         // h2 with bold emphasis
```

## Brand Fonts

Each brand defines its own font family in `<brand>_typography.dart`.
Font assets live in `assets/fonts/<brand>/`.

TODO: Add `.ttf` / `.otf` files and register them in `pubspec.yaml`.
