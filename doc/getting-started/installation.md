# Installation

## 1. Add the dependency

In your app's `pubspec.yaml`:

```yaml
dependencies:
  ckgoc_core:
    git:
      url: https://github.com/company/ckgoc_core.git
      ref: main
```

Or using a local path during development:

```yaml
dependencies:
  ckgoc_core:
    path: ../ckgoc_core
```

Quick add from the command line (recommended for pub.dev releases):

```bash
flutter pub add ckgoc_core
# or, with Dart CLI
dart pub add ckgoc_core
```

Note: `flutter pub add`/`dart pub add` updates your `pubspec.yaml` and runs `pub get` automatically.

## 2. Run pub get

```bash
flutter pub get
```

## 3. Import

```dart
import 'package:ckgoc_core/ckgoc_core.dart';
```
