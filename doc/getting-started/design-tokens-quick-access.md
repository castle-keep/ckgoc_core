# Design Tokens: Quick Access Guide

The design token API provides two ergonomic ways to access design tokens from the active theme. Both approaches are **context-aware** and automatically reflect the current brand, brightness, and theme overrides.

## Option 1: BuildContext Extension (Recommended - Shortest Syntax)

Use the `context.ck*` extensions for the most concise syntax:

```dart
import 'package:ckcoreui/ckcoreui.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.ckColors.primary,              // Colors
      padding: EdgeInsets.all(context.ckSpacing.md), // Spacing
      child: Text(
        'Hello',
        style: context.ckTypography.textMd,         // Typography
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          context.ckRadius.md,                      // Radius
        ),
        boxShadow: [context.ckShadows.sm],          // Shadows
      ),
    );
  }
}
```

### Available Extensions

| Token Type | Extension | Example |
|---|---|---|
| Colors | `context.ckColors` | `context.ckColors.primary` |
| Spacing | `context.ckSpacing` | `context.ckSpacing.md` |
| Typography | `context.ckTypography` | `context.ckTypography.textMd` |
| Radius | `context.ckRadius` | `context.ckRadius.md` |
| Elevation | `context.ckElevation` | `context.ckElevation.sm` |
| Shadows | `context.ckShadows` | `context.ckShadows.sm` |
| Motion | `context.ckMotion` | `context.ckMotion.fast` |
| Opacity | `context.ckOpacity` | `context.ckOpacity.disabled` |
| Breakpoints | `context.ckBreakpoints` | `context.ckBreakpoints.md` |

## Option 2: Static `.of(context)` Method (Flutter Pattern)

Use the static `CK*.of(context)` pattern for explicit, discoverable access:

```dart
import 'package:ckcoreui/ckcoreui.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = CKColors.of(context);
    final spacing = CKSpacing.of(context);
    final typography = CKTypography.of(context);

    return Container(
      color: colors.primary,
      padding: EdgeInsets.all(spacing.md),
      child: Text('Hello', style: typography.textMd),
    );
  }
}
```

### Available Static Accessors

| Token Type | Static Class | Example |
|---|---|---|
| Colors | `CKColors` | `CKColors.of(context).primary` |
| Spacing | `CKSpacing` | `CKSpacing.of(context).md` |
| Typography | `CKTypography` | `CKTypography.of(context).textMd` |
| Radius | `CKRadius` | `CKRadius.of(context).md` |
| Elevation | `CKElevation` | `CKElevation.of(context).sm` |
| Shadows | `CKShadows` | `CKShadows.of(context).sm` |
| Motion | `CKMotion` | `CKMotion.of(context).fast` |
| Opacity | `CKOpacity` | `CKOpacity.of(context).disabled` |
| Breakpoints | `CKBreakpoints` | `CKBreakpoints.of(context).md` |

## Backward Compatibility

The existing patterns continue to work:

```dart
// Old pattern (still works):
context.ckcoreTheme.colors.primary
context.ckcoreTheme.spacing.md

// New pattern (recommended):
context.ckColors.primary
context.ckSpacing.md
```

## Why Context is Required

The design token values depend on three context-aware factors:

1. **Brand**: CastleKeep's primary ≠ SkyGo's primary
2. **Brightness**: Light theme primary ≠ Dark theme primary
3. **Theme Overrides**: Parent widgets can override tokens with `copyWith()`

By requiring `BuildContext`, the API automatically resolves tokens from the active `CKTheme` in the widget tree, ensuring consistency and supporting theme switching without global state.

## Common Patterns

### Responsive Spacing

```dart
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.ckSpacing.md,
    vertical: context.ckSpacing.xs,
  ),
  child: child,
)
```

### Themed Colors

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.ckColors.primary,
    foregroundColor: context.ckColors.onPrimary,
  ),
  onPressed: () {},
  child: Text('Click me'),
)
```

### Typography with Colors

```dart
Text(
  'Heading',
  style: context.ckTypography.displayMd.copyWith(
    color: context.ckColors.primary,
  ),
)
```

### Responsive Breakpoints

```dart
if (MediaQuery.of(context).size.width > context.ckBreakpoints.md) {
  // Desktop layout
} else {
  // Mobile layout
}
```

### Theme-Aware Animations

```dart
AnimatedContainer(
  duration: context.ckMotion.standard,
  curve: Curves.easeInOut,
  color: context.ckColors.primary,
  child: child,
)
```

## See Also

- [Existing Theme Access Pattern](../../CORE/overview_design_system.md)
- [Color Tokens](../../CORE/color.md)
- [Spacing & Grid](../../CORE/spacing_and_grid.md)
- [Typography](../foundation/typography.md)
