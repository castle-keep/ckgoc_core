# Company UI — Documentation

> The single source of truth for all UI components, design tokens, and brand themes.

---

## Quick Start

```dart
import 'package:ckgoc_core/ckgoc_core.dart';

void main() {
  runApp(
    CkgocApp(
      brand: CkgocBrand.skyGo,
      child: MaterialApp(home: MyHomePage()),
    ),
  );
}
```

---

## Package Philosophy

- **No business logic** — only presentation, styling, layout, animations, and composition.
- **Stateless by default** — widgets receive state; they do not own it.
- **Token-driven** — every visual value comes from `CkgocThemeData`. No hardcoded numbers.
- **Multi-brand** — one package, many visual identities.
