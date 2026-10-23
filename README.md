

ckcoreui — Company design system and UI components for Flutter
===============================================================

ckcoreui packages a multi-brand design system (CastleKeep and SkyGo) with
consistent design tokens, components, and a responsive screen layout. It's
intended for apps that need a reusable, themeable UI foundation that follows
company design guidelines.

The package is designed to provide a consistent UI foundation across multiple
Flutter applications while supporting company-specific branding through a
shared design system.

Key features
- Multi-brand themes: CastleKeep and SkyGo with light/dark variants
- Design tokens: colors, typography, spacing, radius, elevation, motion
- A broad components library: buttons, inputs, cards, tables, overlays
- `CKScreenLayout`: responsive side-nav shell for app screens
- `CKAnimate` entrance animations driven by motion tokens
- MCP server and AI skills for Copilot, Claude Code and Cursor
- Example application under `example/`

Design principles
-----------------
- **No business logic**: only presentation, styling, layout, animation and composition.
- **Stateless by default**: widgets receive state; they do not own it.
- **Token-driven**: every visual value comes from the theme. No hard-coded numbers.
- **Multi-brand**: one package, many visual identities.

Installation
------------
Add the package from pub.dev to your application's `pubspec.yaml`:

```yaml
dependencies:
  ckcoreui: ^0.6.0
```

Then run:

```bash
flutter pub get
```

Quick start
-----------
`CKApp` is a drop-in replacement for `MaterialApp`. Pick a brand and build:

```dart
import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    CKApp(
      brand: ckcoreBrand.skyGo, // or ckcoreBrand.castleKeep
      home: Scaffold(
        body: Center(
          child: CKButton(
            onPressed: () {},
            child: const Text('Hello ckcoreui'),
          ),
        ),
      ),
    ),
  );
}
```

Read design tokens from any widget below `CKApp`:

```dart
Container(
  color: context.ckColors.primary,
  padding: EdgeInsets.all(context.ckSpacing.md),
  child: Text('Hello', style: context.ckTypography.textMd),
)
```

Next steps
- [Getting Started guide](doc/getting-started/README.md): five-minute walkthrough, tokens, troubleshooting
- [Interactive docs](https://castle-keep.github.io/ckgoc_core/): live demos for every component
- Run it yourself: `cd doc/flutter_docs && flutter pub get && flutter run -d chrome`

AI-assisted development (MCP and skills)
-----------------------------------------
Give Copilot, Claude Code or Cursor live knowledge of ckcoreui so the code it writes uses the right components, props and tokens.

1. **MCP server** (component, token and pattern lookup). Add it to your editor's MCP config, for example `.vscode/mcp.json`:

   ```json
   {
     "servers": {
       "ckcoreui": { "type": "stdio", "command": "npx", "args": ["-y", "@ckcore/ui-mcp"] }
     }
   }
   ```

   Claude Code: `claude mcp add ckcoreui -- npx -y @ckcore/ui-mcp`. Installing does not register it automatically.
2. **Skill / instructions** (house rules): copy [`skills/ckcoreui`](skills/ckcoreui) to `.claude/skills/`, or [`skills/copilot-instructions.md`](skills/copilot-instructions.md) to `.github/copilot-instructions.md`.

Then ask, for example:
- *"How do I use CKButton?"*: props, variants, examples
- *"What colors are available?"*: design tokens
- *"Generate a login form using ckcoreui"*: Dart code
- *"How do I set up the SkyGo theme?"*: brand configuration

Step-by-step guide (all editors, troubleshooting): [doc/getting-started/ai-tools.md](doc/getting-started/ai-tools.md). Server reference: [mcp/README.md](mcp/README.md).

Animation
---------
Wrap any widget in `CKAnimate` for a token-driven entrance, and use `CKAnimate.stagger` to cascade a list:

```dart
CKAnimate(animation: CKAnimation.slideUp, child: CKCard(title: 'Hello'))
```

See [doc/getting-started/animation.md](doc/getting-started/animation.md).

Dependencies
------------
This package depends on the Flutter SDK and a small set of runtime
dependencies, including `flutter_svg` for SVG rendering and `lucide_icons` for
icons. Consumers only need to add `ckcoreui` to their `pubspec.yaml`; the
package will bring the required runtime dependencies.

Logos
-----
Logos ship in the package as `BrandIcon` constants:

```dart
BrandIcon.brandLogoWidget(context, ckcoreBrand.skyGo, size: 40);
```

Naming rules, all constants and more examples: [doc/getting-started/brand-logos.md](doc/getting-started/brand-logos.md).

Brands
------
Pick `ckcoreBrand.castleKeep` or `ckcoreBrand.skyGo` on `CKApp`. To add a brand, run
`dart run bin/ckgoc.dart add brand "Acme"`. Switching at runtime and the manual steps are in
[doc/getting-started/brands.md](doc/getting-started/brands.md).

Components and usage
--------------------
The library exposes themed components such as `CKButton`,
`CKCard`, `CKDataTable`, `CKTextField`, and more. See the
component examples in the `example/` application for usage patterns.

More documentation
------------------
Browse the interactive docs (live demos, code, parameters) at <https://castle-keep.github.io/ckgoc_core/>, or read the written guides in [`doc/getting-started`](doc/getting-started/README.md).

Contributing
------------
Contributions are welcome. Follow the repository branching and pull request
guidelines, and run the `example/` application locally to test component
changes.

License
-------
See the `LICENSE` file for license details.