# ckcoreDataTable — Component Guide & Migration Plan

## Overview

`CKDataTable` is a fully-themed, stateless data table for the Company design system. It renders UI and emits callbacks only — it never owns repositories, makes network calls, or mutates data.

---

## Quick Start

```dart
CKDataTable(
  columns: [
    const CKTableColumn(key: 'name', label: 'Name',
        type: CKColumnType.avatarText, flex: 2, sortable: true),
    const CKTableColumn(key: 'email', label: 'Email', flex: 2),
    CKTableColumn(
      key: 'role', label: 'Role', width: 120,
      type: CKColumnType.badge,
      badgeVariantBuilder: (v) => v == 'Admin'
          ? BadgeVariant.primary : BadgeVariant.outline,
    ),
  ],
  rows: _rows,        // List<Map<String, dynamic>>
  rowKey: 'id',
  title: 'Users',
  subtitle: '${_total} records',
  totalCount: _total,
  currentPage: _page,
  pageSize: 20,
  onPageChanged: (p) => setState(() => _page = p),
  selectionMode: TableSelectionMode.multiple,
  selectedKeys: _selected,
  onSelectionChanged: (s) => setState(() => _selected = s),
  sortColumnKey: _sortKey,
  sortAscending: _sortAsc,
  onSortChanged: (k, asc) => setState(() { _sortKey = k; _sortAsc = asc; }),
  searchQuery: _search,
  searchHint: 'Search users…',
  onSearchChanged: (v) => setState(() { _search = v; _page = 1; }),
)
```

---

## Setup

- Add the package and import the component where you need it. If you're working in this repo, the component lives under `lib/src/components/data_table` and is exported from `lib/ckcoreui.dart`.
- Ensure your app provides a `ckcoreThemeData` (example themes are in `lib/src/themes/brands`). The table uses `colors.surfaceVariant` for header/footer and `colors.background` for stripe backgrounds.

Example import:

```dart
import 'package:ckcoreui/ckcore_core.dart';
```

Run the example app to see the table in action:

```bash
flutter run -d chrome -t example/lib/main.dart
```

---

## Getting started

1. Define your `columns` using `CKTableColumn`. Mark sortable columns with `sortable: true`.
2. Provide `rows` as a `List<Map<String, dynamic>>` and a `rowKey` that uniquely identifies each row.
3. For server-driven paging/sorting, use the controlled pattern: pass `sortColumnKey`, `sortAscending`, and implement `onSortChanged`/`onPageChanged` to fetch sorted pages.
4. For small client-side datasets, omit `onSortChanged` to use the internal sorting fallback.
5. Use `editableColumns` + `onCellChanged` for inline editing, and `selectionMode`/`onSelectionChanged` for row selection.


---

## Sorting

CKDataTable renders a sort affordance in the header when a column is declared with `sortable: true` on `CKTableColumn`.

- Controlled sorting (recommended for server-side paging): provide `sortColumnKey`, `sortAscending`, and `onSortChanged`. The table will call `onSortChanged(columnKey, ascending)` when the user taps a sortable header; your parent widget is responsible for sorting the `rows` and passing the new values back into the table props.

Example (controlled):

```dart
// parent state: _sortKey, _sortAsc
ckcoreDataTable(
  columns: [...],
  rows: _rows,
  sortColumnKey: _sortKey,
  sortAscending: _sortAsc,
  onSortChanged: (k, asc) => setState(() { _sortKey = k; _sortAsc = asc; /* re-sort or refetch */ }),
  // ...
)
```

- Uncontrolled (client-side) fallback: if you omit `onSortChanged`, the table will perform sorting internally for you. It initializes from the optional `sortColumnKey`/`sortAscending` props and will sort the in-memory `rows` when the user taps sortable headers. This is useful for local, client-side datasets where you don't need server-driven sorting.

Example (uncontrolled):

```dart
ckcoreDataTable(
  columns: [
    ckcoreTableColumn(key: 'name', label: 'Name', sortable: true),
    ckcoreTableColumn(key: 'age', label: 'Age', sortable: true),
  ],
  rows: _localRows, // small in-memory dataset
  // omit onSortChanged -> table sorts internally when headers are tapped
)
```

Comparators: the internal comparator supports numbers and `DateTime`, and falls back to string comparison; nulls sort last. If you need special ordering for enums or custom types, sort in the parent and use controlled sorting.

## Styling: header/footer and row stripes

ckcoreDataTable uses theme tokens for header/footer and striping so colors follow your brand theme:

- Header and footer background: `theme.colors.surfaceVariant` (we set this to neutral100 in the SkyGo light theme).
- Row stripes: `theme.colors.background` (the light theme background is `#FAFAFA`).

If you want different striping or header/footer colors, adjust your `ckcoreThemeData` implementation for `colors.surfaceVariant` and `colors.background`.

---

## Editable Cells with Custom Inputs & Row-Aware Validation

CKDataTable supports editable cells with custom input widgets and validation rules that can depend on other cell values in the same row.

### Quick Example

```dart
CKDataTable(
  columns: [...],
  rows: _rows,
  rowKey: 'id',
  
  // Configure editable cells with custom input widgets
  editableCells: {
    'name': CKEditableCell.textField(
      hint: 'Enter name',
      validator: (value, row) {
        if (value?.isEmpty ?? true) return 'Name is required';
        return null;
      },
    ),
    'status': CKEditableCell.dropdown(
      items: const [
        DropdownMenuItem(value: 'Active', child: Text('Active')),
        DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
      ],
    ),
    'verified': CKEditableCell.checkbox(label: 'Verified'),
  },
  
  // Handle value changes
  onCellValueChanged: (rowKey, columnKey, newValue) {
    setState(() {
      // Update your data
    });
  },
)
```

### Features

1. **Custom Input Widgets**: Support for TextField, Dropdown, Checkbox, Switch, and DatePicker
2. **Row-Aware Validation**: Validators receive the complete row, enabling conditional rules
3. **Active Cell Highlighting**: Visual feedback for focused cells
4. **Validation Error Display**: Inline error messages

### Supported Input Types

- **CKEditableCell.textField()** - Text input with optional validation
- **CKEditableCell.dropdown()** - Single selection with static or dynamic options
- **CKEditableCell.checkbox()** - Boolean toggle with label
- **CKEditableCell.switch_()** - Switch toggle with optional variants
- **CKEditableCell.datePicker()** - Date selection

### Row-Aware Validation Example

```dart
'courier': CKEditableCell.dropdown(
  items: const [
    DropdownMenuItem(value: 'FedEx', child: Text('FedEx')),
    DropdownMenuItem(value: 'UPS', child: Text('UPS')),
  ],
  validator: (value, row) {
    // Validation depends on another field!
    if (row['transfer_type'] == 'External' && value?.isEmpty == true) {
      return 'Required for external transfers';
    }
    return null;
  },
),
```

### For More Information

- [Editable Cells Complete Guide](editable-data-table-custom-inputs.md)
- [Quick Reference](editable-cells-quick-reference.md)
- See the example in [data_table_screen.dart](../../example/lib/screens/data_table_screen.dart) (Section 7)
