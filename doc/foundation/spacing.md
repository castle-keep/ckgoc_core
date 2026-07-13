# Spacing

Spacing uses a **4pt grid**. All layout dimensions must use these tokens.

## Scale

| Token | Value | Common Use |
|---|---|---|
| `xxs` | 2px | Icon inner padding, micro gaps |
| `xs` | 4px | Tight spacing between related elements |
| `sm` | 8px | Component internal padding, small gaps |
| `md` | 16px | Default component padding |
| `lg` | 24px | Section internal padding |
| `xl` | 32px | Section-to-section spacing |
| `2xl` | 48px | Large section gaps |
| `3xl` | 64px | Page-level vertical rhythm |
| `4xl` | 96px | Hero vertical spacing |
| `5xl` | 128px | Maximum vertical whitespace |

## Usage

```dart
Padding(
  padding: EdgeInsets.all(theme.spacing.md),
  child: ...,
)

SizedBox(height: theme.spacing.lg)

EdgeInsets.symmetric(
  horizontal: theme.spacing.lg,
  vertical: theme.spacing.md,
)
```
