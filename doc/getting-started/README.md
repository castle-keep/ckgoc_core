# Getting Started with ckcoreui

## Essential Guides

### Component Guides

- **[Data Table Guide](data-table.md)** - All features of CKDataTable including selection, sorting, pagination, and filtering
  - **[Editable Cells with Custom Inputs](editable-data-table-custom-inputs.md)** - Custom input widgets, row-aware validation, and visual feedback
  - **[Editable Cells Quick Reference](editable-cells-quick-reference.md)** - API reference and common patterns

### Setup & Installation

- **[Installation](installation.md)** - How to install and set up ckcoreui
- **[Setup](setup.md)** - Initial app configuration
- **[Brand Configuration](brand-configuration.md)** - Configuring your brand theme
- **[Brand Scaffolding](brand-scaffolding.md)** - Complete scaffolding structure for a new brand

### Design System

- **[Design Tokens Quick Access](design-tokens-quick-access.md)** - Using colors, spacing, typography, and other design tokens

---

## Quick Start

### 1. Install the Package
```dart
// pubspec.yaml
dependencies:
  ckcoreui: ^0.1.0
```

### 2. Create Your App
```dart
import 'package:ckcoreui/ckcore_core.dart';

void main() {
  runApp(
    CKApp(
      brand: ckcoreBrand.castleKeep,
      home: HomePage(),
      title: 'My App',
    ),
  );
}
```

### 3. Access Design Tokens
```dart
// In any widget with BuildContext
Container(
  color: context.ckColors.primary,
  padding: EdgeInsets.all(context.ckSpacing.md),
  child: Text('Hello', style: context.ckTypography.textMd),
)
```

---

## Common Tasks

### Use CKDataTable with Selection
See [Data Table Guide - Selection](data-table.md#selection)

### Make CKDataTable Cells Editable
See [Editable Cells Guide](editable-data-table-custom-inputs.md)

### Implement Row-Aware Validation
See [Editable Cells Guide - Row-Aware Validation](editable-data-table-custom-inputs.md#row-aware-validation)

### Sort or Filter Server-Side
See [Data Table Guide - Sorting](data-table.md#sorting)

---

## Example App

The example app in `example/lib/screens/data_table_screen.dart` demonstrates all CKDataTable features including:

1. Inline editable cells (legacy API)
2. Delete multiple rows
3. Multiple row selection
4. Pagination with custom page sizes
5. Sortable & filterable columns
6. **NEW:** Editable cells with custom inputs and row-aware validation (Section 7)

Run it with:
```bash
flutter run -d chrome -t example/lib/main.dart
```

---

## Need Help?

- **API Reference**: See inline documentation in the source files
- **Examples**: Check `example/lib/screens/` for working examples
- **Design System**: Visit the design documentation at https://castle-keep.github.io/ckgoc_core/
