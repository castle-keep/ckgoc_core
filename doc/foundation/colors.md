# Colors

## Overview

The color system is split into two layers:

1. **Primitive colors** (`color_primitives.dart`) — raw swatches by name and step.
2. **Semantic colors** (`CkgocColors`) — role-based aliases used by widgets.

## Accessing Colors

```dart
final theme = context.ckgocTheme;

// Primary brand color
theme.colors.primary

// Text on primary
theme.colors.onPrimary

// Page background
theme.colors.background

// Error feedback
theme.colors.error
```

## Semantic Roles

| Token | Role |
|---|---|
| `primary` | Main brand color — CTAs, links, focus rings |
| `primaryHover` | Primary on hover |
| `primaryActive` | Primary on press |
| `primaryDisabled` | Primary in disabled state |
| `onPrimary` | Text/icon on primary background |
| `secondary` | Secondary action color |
| `accent` | Accent / highlight color |
| `background` | Page / scaffold background |
| `surface` | Card, modal, panel background |
| `surfaceVariant` | Alternate surface (e.g. table row stripe) |
| `onSurface` | Text/icon on surface |
| `outline` | Border, divider |
| `error` | Error state foreground |
| `errorContainer` | Error state background |
| `success` | Success state foreground |
| `warning` | Warning state foreground |
| `info` | Informational state foreground |

## Adding a New Brand Color

1. Add primitives to `brands/<name>/<name>_colors.dart`
2. Map primitives to `CkgocColors` roles in the brand theme builders
