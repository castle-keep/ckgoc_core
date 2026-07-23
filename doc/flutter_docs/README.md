# Ckgoc Core Docs App

Minimal Flutter app that runs the component documentation UI.

Run locally from the repository root:

```bash
cd docs/flutter_docs
flutter pub get
flutter run -d chrome
```

Notes:
- The app depends on the local `ckgoc_core` package via a path dependency in `pubspec.yaml`.
- If you change `lib/src` components, re-run `flutter pub get` in this folder.
