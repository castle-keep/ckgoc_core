## 0.4.0

### Added
- Added `CKTooltip`.
- Expanded theme customization options.
- Added migration guide for upgrading from 0.3.x.

### Changed
- Improved accessibility and keyboard navigation.
- Improved component documentation and examples.
- Refined typography, spacing, and theme performance.
- Standardized component APIs for consistency.

### Fixed
- Fixed overlay stability (`CKAlert`, `CKToast`, `CKDialog`).
- Improved responsive data tables.
- Fixed form validation edge cases.
- Improved theme consistency across light and dark modes.

## 0.3.1

Updated documentation

## 0.3.0

Changed:
- Renamed package from `ckgoc_core` to `ckcoreui`. Deprecated aliases are preserved for backward compatibility.
- Refactored theme structure: introduced `CKCoreThemeData`, `CKCoreTheme`, and new brand management enums. Removed `CkgocTheme` and `CkgocThemeData` (deprecated aliases still available).
- Updated `bin/ckgoc.dart` CLI, README, LICENSE, and all internal references to use the new package name.

Added:
- Semantic heading extension getters `.h1`–`.h6` on `Text`, mapping to `display2xl`, `displayXl`, `displayLg`, `displayMd`, `displaySm`, and `textXl` typography tokens.
- Significantly expanded Flutter docs app: new `ScreenLayoutPage` and `RouterPage` using `DocSection`/`ComponentDocData` pattern; updated `OverviewPage` with CKApp theme-injection guide; updated `FoundationPage` with heading-shorthand showcase.
- `CKApp.router` documentation explaining theme-context injection for descendants.

Fixed:
- Layout exceptions (`RenderDecoratedBox`/`_RenderInkFeatures` given infinite size) in `CKCard`, `CKAlert`, and `CKToast` when placed in unbounded-width parents (e.g. `Wrap`).
- `CKCard` horizontal layout: replaced `Expanded` with `Flexible` and added `mainAxisSize: MainAxisSize.min` to prevent infinite-width propagation.

## 0.2.1

Added:
- Flutter documentation app for browsing ckcoreui components and usage examples.
- `ckcoreNumberStepper` input component and expanded `ckcoreDropdown` support.

Changed:
- Migrated icon usage from `lucide_icons` to `lucide_icons_flutter`.
- Expanded example and quick-start documentation for the updated input components.

## 0.2.0

Added:
- Brand scaffolding CLI via `bin/ckcoreui.dart` for generating brand configuration and setup artifacts.
- Data table sorting support, including updated table behavior and documentation.
- Bundled Inter font assets and brand logo assets for CastleKeep and SkyGo.

Changed:
- Expanded public API and getting-started documentation, including brand scaffolding, data table usage, installation, and quick guide updates.
- Updated README and package configuration to support the new CLI/assets release.

## 0.1.1

Fixed:
- Updated GitHub repository and homepage URLs.
- Updated installation instructions to use the published package from pub.dev.
- Replaced outdated `showcase/` references with `example/`.
- Improved README and package documentation.
- Minor documentation and metadata improvements.

## 0.1.0

- Release: initial package published as `0.1.0`.

Highlights:
- Add multi-brand design system with CastleKeep and SkyGo themes.
- Provide design tokens: colors, typography, spacing, radius, elevation, motion.
- Core components: buttons, inputs, cards, overlays, navigation, tables.
- Templates for common screens: auth, CRUD, dashboard, states.
- `showcase/` app demonstrating component usage and integration.

See `doc/` for usage guides and API notes.

## 0.0.1

- Initial public release (historical entry)

