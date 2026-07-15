# CkgocDataTable — Component Guide & Migration Plan

## Overview

`CkgocDataTable` is a fully-themed, stateless data table for the Company design system. It renders UI and emits callbacks only — it never owns repositories, makes network calls, or mutates data.

---

## Quick Start

```dart
CkgocDataTable(
  columns: [
    const CkgocTableColumn(key: 'name', label: 'Name',
        type: CkgocColumnType.avatarText, flex: 2, sortable: true),
    const CkgocTableColumn(key: 'email', label: 'Email', flex: 2),
    CkgocTableColumn(
      key: 'role', label: 'Role', width: 120,
      type: CkgocColumnType.badge,
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

- Add the package and import the component where you need it. If you're working in this repo, the component lives under `lib/src/components/data_table` and is exported from `lib/ckgoc_core.dart`.
- Ensure your app provides a `CkgocThemeData` (example themes are in `lib/src/themes/brands`). The table uses `colors.surfaceVariant` for header/footer and `colors.background` for stripe backgrounds.

Example import:

```dart
import 'package:ckgoc_core/ckgoc_core.dart';
```

Run the example app to see the table in action:

```bash
flutter run -d chrome -t example/lib/main.dart
```

---

## Getting started

1. Define your `columns` using `CkgocTableColumn`. Mark sortable columns with `sortable: true`.
2. Provide `rows` as a `List<Map<String, dynamic>>` and a `rowKey` that uniquely identifies each row.
3. For server-driven paging/sorting, use the controlled pattern: pass `sortColumnKey`, `sortAscending`, and implement `onSortChanged`/`onPageChanged` to fetch sorted pages.
4. For small client-side datasets, omit `onSortChanged` to use the internal sorting fallback.
5. Use `editableColumns` + `onCellChanged` for inline editing, and `selectionMode`/`onSelectionChanged` for row selection.


---

## Sorting

CkgocDataTable renders a sort affordance in the header when a column is declared with `sortable: true` on `CkgocTableColumn`.

- Controlled sorting (recommended for server-side paging): provide `sortColumnKey`, `sortAscending`, and `onSortChanged`. The table will call `onSortChanged(columnKey, ascending)` when the user taps a sortable header; your parent widget is responsible for sorting the `rows` and passing the new values back into the table props.

Example (controlled):

```dart
// parent state: _sortKey, _sortAsc
CkgocDataTable(
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
CkgocDataTable(
  columns: [
    CkgocTableColumn(key: 'name', label: 'Name', sortable: true),
    CkgocTableColumn(key: 'age', label: 'Age', sortable: true),
  ],
  rows: _localRows, // small in-memory dataset
  // omit onSortChanged -> table sorts internally when headers are tapped
)
```

Comparators: the internal comparator supports numbers and `DateTime`, and falls back to string comparison; nulls sort last. If you need special ordering for enums or custom types, sort in the parent and use controlled sorting.

## Styling: header/footer and row stripes

CkgocDataTable uses theme tokens for header/footer and striping so colors follow your brand theme:

- Header and footer background: `theme.colors.surfaceVariant` (we set this to neutral100 in the SkyGo light theme).
- Row stripes: `theme.colors.background` (the light theme background is `#FAFAFA`).

If you want different striping or header/footer colors, adjust your `CkgocThemeData` implementation for `colors.surfaceVariant` and `colors.background`.
