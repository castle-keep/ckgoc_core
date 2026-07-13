The spacing system uses the package `CkgocSpacing` tokens. The base
unit is 4dp and the token names used in code are the canonical source of
truth. Use these tokens in layout and components rather than raw numbers.

## CkgocSpacing tokens

| Token | Value | Common Use |
|---|---:|---|
| `none` | 0dp | Explicit zero |
| `xxs` | 2dp | Hairline / micro gaps |
| `xs` | 4dp | Icon padding, micro gap |
| `sm` | 8dp | Tight padding, compact row |
| `s12` | 12dp | Small internal padding |
| `md` | 16dp | Standard padding |
| `s20` | 20dp | Comfortable padding |
| `lg` | 24dp | Section padding |
| `xl` | 32dp | Card padding |
| `s40` | 40dp | Large gap |
| `x2l` | 48dp | Section separator |
| `x3l` | 64dp | Large section |
| `s80` | 80dp | Page padding |
| `x4l` | 96dp | Hero section |
| `x5l` | 128dp | Full-bleed |

## Border radius (CkgocRadius)

Radius tokens are provided by `CkgocRadius`.

| Token | Value | Usage |
|---|---:|---|
| `none` | 0dp | Tables, dividers |
| `sm` | 4dp | Tags, checkboxes |
| `base` | 6dp | Buttons, inputs, selects |
| `md` | 8dp | Medium rounding |
| `lg` | 12dp | Cards, dialogs, modals |
| `xl` | 16dp | Strong rounding |
| `x2l` | 24dp | Large cards, panels |
| `x3l` | 32dp | Hero cards |
| `full` | 9999dp | Pills, chips, avatars |

## Grid System

| Property | Value |
|---|---|
| Mobile columns | 4 |
| Tablet columns | 8 |
| Desktop columns | 12 |
| Base gutter | 16dp |
| Mobile margin | 16dp |
| Tablet margin | 24dp |
| Desktop margin | 32dp |

## Flutter implementation (tokens)

These tokens are defined in `lib/src/foundation/` — prefer reading them from
`context.ckgocTheme.spacing` and `context.ckgocTheme.radius` in widgets.

```dart
final s = context.ckgocTheme.spacing;
Padding(padding: EdgeInsets.all(s.md));

final r = context.ckgocTheme.radius;
BorderRadius.circular(r.base);
```
