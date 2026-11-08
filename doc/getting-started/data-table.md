# CKDataTable: sorting, paging, selection and inline editing

`CKDataTable` is a fully-themed data table. Your data stays outside it: it renders the rows you pass in and emits callbacks, and it never owns repositories, makes network calls, or mutates your data. It does keep internal sort state when you omit `onSortChanged` (see [Sorting](#sorting)).

## Quick start

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

1. Define `columns` with `CKTableColumn` (`key` is the field looked up in each row map, `label` is the header). Mark sortable columns with `sortable: true`.
2. Pass `rows` as a `List<Map<String, dynamic>>` and a `rowKey` that uniquely identifies each row (default `'id'`).
3. For server-driven paging and sorting, use the controlled pattern: pass `sortColumnKey`, `sortAscending`, `currentPage`, `totalCount` and implement `onSortChanged` / `onPageChanged` to fetch the page.
4. For a small client-side dataset, omit `onSortChanged` and the table sorts in memory.

`import 'package:ckcoreui/ckcoreui.dart';` is all you need. A working example is in [data_table_screen.dart](../../example/lib/screens/data_table_screen.dart) (run it with `flutter run -d chrome -t example/lib/main.dart`).

## Main parameters

| Parameter | Default | Purpose |
| --- | --- | --- |
| `columns`, `rows` | required | Column definitions and row maps |
| `rowKey` | `'id'` | Field that identifies a row |
| `title`, `subtitle`, `headerActions` | none | Header area |
| `searchQuery`, `searchHint`, `onSearchChanged` | none | Search box |
| `sortColumnKey`, `sortAscending`, `onSortChanged` | none, `true`, none | Sorting |
| `selectionMode`, `selectedKeys`, `onSelectionChanged` | `none`, `{}`, none | Row selection (`none`, `single`, `multiple`) |
| `totalCount`, `currentPage`, `pageSize`, `onPageChanged`, `onPageSizeChanged` | `0`, `1`, `10`, none | Paging |
| `isLoading`, `errorMessage`, `emptyMessage`, `emptyWidget` | `false`, none | Loading, error and empty states |
| `striped`, `headerFooterColor`, `widthBehavior`, `maxHeight` | `true`, none, `stretch`, none | Appearance |
| `onRowTap`, `onFilterChanged`, `footerRow` | none | Extras |
| `editableCells`, `onCellValueChanged` | none | Inline editing (below) |

`CKTableColumn` also accepts `type` (`CKColumnType`: `text`, `badge`, `avatarText`, `progress`, `custom`), `width` or `flex` (default 1), `minWidth` (120), `filterable`, `hidden`, `textAlign`, `badgeVariantBuilder` and `cellBuilder`.

## Sorting

A sort affordance appears in the header of every `sortable: true` column.

- **Controlled** (recommended for server-side paging): provide `sortColumnKey`, `sortAscending` and `onSortChanged`. The table calls `onSortChanged(columnKey, ascending)` when a header is tapped; your widget re-sorts or refetches `rows` and passes the new values back.
- **Uncontrolled** (client-side): omit `onSortChanged`. The table initialises from `sortColumnKey` / `sortAscending` and sorts the in-memory `rows` itself. The comparator handles numbers and `DateTime`, falls back to string comparison, and sorts nulls last. For special orderings (enums, custom types) sort in the parent and use the controlled pattern.

## Styling

Header and footer use `colors.surfaceVariant` and row stripes use `colors.background`, so they follow the brand theme (`surfaceVariant` is neutral200 in the light themes). To change them, pass `headerFooterColor` or adjust your theme.

---

## Inline editing with `CKEditableCell`

Give `editableCells` a map from column key to a `CKEditableCell` and listen with `onCellValueChanged`. Validators receive the current value **and the whole row**, so a rule can depend on other cells.

```dart
CKDataTable(
  columns: [...],
  rows: _rows,
  rowKey: 'id',
  editableCells: {
    'name': CKEditableCell.textField(
      hint: 'Enter name',
      validator: (value, row) =>
          (value?.toString().trim().isEmpty ?? true) ? 'Name is required' : null,
    ),
    'transfer_type': CKEditableCell.dropdown(
      items: const [
        DropdownMenuItem(value: 'Internal', child: Text('Internal')),
        DropdownMenuItem(value: 'External', child: Text('External')),
      ],
      hint: 'Select type',
    ),
    'courier': CKEditableCell.dropdown(
      items: const [
        DropdownMenuItem(value: 'FedEx', child: Text('FedEx')),
        DropdownMenuItem(value: 'UPS', child: Text('UPS')),
      ],
      // Required only for external transfers: depends on another cell in the row.
      validator: (value, row) =>
          row['transfer_type'] == 'External' && (value == null || value.toString().isEmpty)
              ? 'Required for external transfers'
              : null,
    ),
    'verified': CKEditableCell.checkbox(label: 'Verified'),
    'active': CKEditableCell.switch_(label: 'Active', variant: SwitchVariant.success),
    'delivery_date': CKEditableCell.datePicker(label: 'Delivery date', firstDate: DateTime.now()),
  },
  onCellValueChanged: (rowKey, columnKey, newValue) {
    setState(() {
      final i = _rows.indexWhere((r) => r['id'] == rowKey);
      if (i != -1) _rows[i][columnKey] = newValue;
    });
  },
)
```

**Dynamic dropdown options.** Pass `itemsBuilder: (row) => [...]` instead of `items` to vary the options by row (for example a subcategory that depends on a category column).

**Custom input.** For full control use the builder constructor:

```dart
'custom_field': CKEditableCell(
  builder: (context, value, onChanged, row, isActive, validationError) {
    return YourCustomWidget(value: value, onChanged: onChanged);
  },
  validator: (value, row) => null,
),
```

**Signatures.** All validators have the type `String? Function(dynamic value, Map<String, dynamic> row)` and return `null` when the value is valid.

| Factory | Parameters |
| --- | --- |
| `CKEditableCell.textField` | `hint`, `label`, `maxLines = 1`, `keyboardType`, `validator` |
| `CKEditableCell.dropdown` | `items` or `itemsBuilder` (one required), `hint`, `label`, `validator` |
| `CKEditableCell.checkbox` | `label`, `validator` |
| `CKEditableCell.switch_` | `label`, `variant` (`SwitchVariant.success` / `error`), `validator` |
| `CKEditableCell.datePicker` | `label`, `firstDate`, `lastDate`, `validator` |
| `CKEditableCell(builder:, validator:)` | `builder(context, currentValue, onChanged, row, isActive, validationError)` |

Good practice: keep validators pure (do side effects in `onCellValueChanged`), give clear messages, and use dropdowns for constrained choices.

**Migrating from the old API.** `editableColumns: {'name', 'email'}` with `onCellChanged` is deprecated but still works. Replace it with `editableCells` (one `CKEditableCell.textField` per column) and `onCellValueChanged`.
