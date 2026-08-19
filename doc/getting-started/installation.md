# Installation

## 1. Add the dependency

Add the released package from pub.dev to your app's `pubspec.yaml`:

```yaml
dependencies:
  ckcoreui: ^0.4.3
```

Or, while developing locally, point to a path:

```yaml
dependencies:
  ckcoreui:
    path: ../ckcoreui
```

Quick add from the command line (recommended for pub.dev releases):

```bash
flutter pub add ckcoreui
# or, with Dart CLI
dart pub add ckcoreui
```

Note: `flutter pub add`/`dart pub add` updates your `pubspec.yaml` and runs `pub get` automatically.

## 2. Run pub get

```bash
flutter pub get
```

## 3. Import

```dart
import 'package:ckcoreui/ckcore_core.dart';
```

## Router & Delegate (brief)

If your app uses Navigator 2.0, `CKApp` supports `router` and `delegate` constructors. See `doc/getting-started/setup.md` for expanded examples.

```dart
// Router-based (RouterConfig or GoRouter)
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  routerConfig: myRouterConfig,
)

// Delegate-based (explicit RouterDelegate + RouteInformationParser)
CKApp.delegate(
  brand: ckcoreBrand.castleKeep,
  routerDelegate: myRouterDelegate,
  routeInformationParser: myRouteInformationParser,
)
```

## Using packaged logos

`ckcoreui` exports `BrandIcon` constants which point to bundled logo
assets. Consumers should load them using `Image.asset` for raster files or
`SvgPicture.asset` (from `flutter_svg`) for SVG variants. Examples:

```dart
// PNG from package
Image.asset(
  BrandIcon.castlekeepName,
  package: 'ckcoreui',
  width: 160,
);

// SVG from package (rendered by the package using `flutter_svg`)
Widget svg = BrandIcon.brandLogoWidget(context, ckcoreBrand.skyGo, size: 160);
```

Tip: Use `ckcoreSideNav.logo` to inject a custom logo widget into the
side navigation instead of relying on the package default widget.
