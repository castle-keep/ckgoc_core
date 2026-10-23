# Animation: `CKAnimate`

`CKAnimate` wraps any widget with a fade, slide or scale entrance. Duration and easing come from the brand's motion tokens, and the animation is skipped when the device asks for reduced motion.

```dart
CKAnimate(
  animation: CKAnimation.slideUp,
  child: CKCard(title: 'Welcome'),
)
```

> Try it live: open **Animation** in the docs app (`doc/flutter_docs`) and change effect, duration and delay.

## Effects

| `CKAnimation` | Looks like |
| --- | --- |
| `fade` (default) | Opacity 0 to 1 |
| `slideUp` | Fades in travelling up from below |
| `slideDown` | Fades in travelling down from above |
| `slideLeft` | Fades in travelling left from the right |
| `slideRight` | Fades in travelling right from the left |
| `scale` | Fades in growing from 90% to 100% |

## Parameters

| Name | Type | Default | Notes |
| --- | --- | --- | --- |
| `child` | `Widget` | required | The widget to animate |
| `animation` | `CKAnimation` | `fade` | Effect |
| `duration` | `Duration?` | theme `motion.slow` | |
| `delay` | `Duration` | `Duration.zero` | Wait before starting |
| `curve` | `Curve?` | theme `motion.decelerate` | |
| `offset` | `double` | `16` | Slide distance in px |
| `autoPlay` | `bool` | `true` | When `false`, waits for `trigger` to change |
| `trigger` | `Object?` | none | Change it to replay |

## Cascade a list

`CKAnimate.stagger` wraps each child with an increasing delay (default 60 ms apart):

```dart
Column(
  children: CKAnimate.stagger(
    animation: CKAnimation.slideUp,
    interval: const Duration(milliseconds: 80),
    children: [
      CKCard(title: 'One'),
      CKCard(title: 'Two'),
      CKCard(title: 'Three'),
    ],
  ),
)
```

## Replay on change

```dart
CKAnimate(
  trigger: selectedTab, // animates again whenever this value changes
  child: TabContent(selectedTab),
)
```

## Notes

- **Entrance only.** For exits use `AnimatedSwitcher` or `AnimatedOpacity`.
- **Lazy lists** (`ListView.builder`) rebuild items as they re-enter the viewport, so they'd animate again. Use it on content shown once per screen.
- **Reduced motion:** when `MediaQuery.disableAnimations` is true the child appears immediately.
- **Speed brand-wide:** override the theme's `motion` tokens; `CKAnimate` reads `motion.slow` and `motion.decelerate`.
