import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  static final List<Map<String, dynamic>> _seed = [
    {
      'id': 1,
      'name': 'Maria Santos',
      'email': 'maria@example.com',
      'role': 'Admin',
      'status': 'Active',
    },
    {
      'id': 2,
      'name': 'John Cruz',
      'email': 'john@example.com',
      'role': 'Editor',
      'status': 'Active',
    },
    {
      'id': 3,
      'name': 'Ana Reyes',
      'email': 'ana@example.com',
      'role': 'Viewer',
      'status': 'Pending',
    },
    {
      'id': 4,
      'name': 'Carlos Lim',
      'email': 'carlos@example.com',
      'role': 'Editor',
      'status': 'Inactive',
    },
    {
      'id': 5,
      'name': 'Sofia Dela Cruz',
      'email': 'sofia@example.com',
      'role': 'Admin',
      'status': 'Active',
    },
    {
      'id': 6,
      'name': 'Marco Villanueva',
      'email': 'marco@example.com',
      'role': 'Viewer',
      'status': 'Pending',
    },
    {
      'id': 7,
      'name': 'Isabella Tan',
      'email': 'isabella@example.com',
      'role': 'Editor',
      'status': 'Active',
    },
    {
      'id': 8,
      'name': 'Rafael Gutierrez',
      'email': 'rafael@example.com',
      'role': 'Viewer',
      'status': 'Inactive',
    },
  ];

  static List<Map<String, dynamic>> _copy() =>
      _seed.map((r) => Map<String, dynamic>.from(r)).toList();

  // Section 1: Editable
  late List<Map<String, dynamic>> _editableRows;
  late List<Map<String, dynamic>> _deletableRows;
  Set<dynamic> _deleteSelected = {};
  String _editableSearch = '';
  String _deleteSearch = '';

  // Section 3: Multiple selection
  Set<dynamic> _multiSelected = {};
  String _multiSearch = '';

  // Section 4: Paginated
  int _pageSize = 3;
  int _page = 1;
  String _pagedSearch = '';

  // Section 6: Sortable and Filterable
  String? _sortableColumnKey;
  bool _sortableAscending = true;
  List<CKTableFilter> _sortableFilters = [];
  String _sortableSearch = '';

  // Section 7: Editable with Custom Inputs & Row-Aware Validation
  late List<Map<String, dynamic>> _itemTransferRows;

  @override
  void initState() {
    super.initState();
    _editableRows = _copy();
    _deletableRows = _copy();
    _itemTransferRows = [
      {
        'id': 1,
        'item': 'Laptop',
        'transfer_type': 'Internal',
        'destination': 'Warehouse B',
        'courier': '',
        'tracking_no': '',
        'verified': true,
      },
      {
        'id': 2,
        'item': 'Monitor',
        'transfer_type': 'External',
        'destination': 'Customer Site A',
        'courier': null, // Will be invalid
        'tracking_no': null, // Will be invalid
        'verified': false,
      },
      {
        'id': 3,
        'item': 'Keyboard',
        'transfer_type': 'External',
        'destination': 'Warehouse C',
        'courier': 'FedEx',
        'tracking_no': null, // Will be invalid
        'verified': true,
      },
      {
        'id': 4,
        'item': 'Mouse',
        'transfer_type': 'External',
        'destination': 'Customer Site B',
        'courier': 'DHL',
        'tracking_no': '123456789',
        'verified': true,
      },
    ];
  }

  //  Shared base columns
  List<CKTableColumn> get _baseColumns => [
    CKTableColumn(
      key: 'name',
      label: 'Name',
      type: CKColumnType.avatarText,
      sortable: true,
      filterable: true,
      width: 300,
      cellBuilder: (value, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value.toString()),
          Expanded(
            child: Text(
              'Subtitle for $value',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    ),
    const CKTableColumn(key: 'email', label: 'Email', flex: 2),
    CKTableColumn(
      key: 'role',
      label: 'Role',
      width: 110,
      type: CKColumnType.badge,
      badgeVariantBuilder: (v) => switch (v.toString()) {
        'Admin' => BadgeVariant.primary,
        'Editor' => BadgeVariant.info,
        _ => BadgeVariant.outline,
      },
    ),
    CKTableColumn(
      key: 'status',
      label: 'Status',
      width: 90,
      cellBuilder: (v, _) => _StatusText(status: v.toString()),
    ),
    CKTableColumn(
      key: 'actions',
      label: 'Actions',
      width: 100,
      textAlign: TextAlign.center,
      cellBuilder: (v, row) => Builder(
        builder: (ctx) {
          final theme = ctx.ckcoreTheme;
          final iconSize = theme.spacing.md;
          final btnSize = theme.spacing.xl; // 32dp
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(LucideIcons.edit2, size: iconSize),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints.tightFor(
                  width: btnSize,
                  height: btnSize,
                ),
                onPressed: () => ScaffoldMessenger.of(
                  ctx,
                ).showSnackBar(SnackBar(content: Text('Edit #${row['id']}'))),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: Icon(LucideIcons.moreVertical, size: iconSize),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints.tightFor(
                  width: btnSize,
                  height: btnSize,
                ),
                onPressed: () => ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(content: Text('More actions for #${row['id']}')),
                ),
                tooltip: 'More',
              ),
            ],
          );
        },
      ),
    ),
  ];

  //  Edit helpers
  void _onCellChanged(dynamic rowId, String colKey, dynamic value) {
    setState(() {
      final idx = _editableRows.indexWhere((r) => r['id'] == rowId);
      if (idx != -1) _editableRows[idx][colKey] = value;
    });
  }

  List<Map<String, dynamic>> _filterRows(
    List<Map<String, dynamic>> rows,
    String q,
  ) {
    if (q.trim().isEmpty) return rows;
    final qq = q.toLowerCase();
    return rows.where((r) {
      return r.values
          .where((v) => v != null)
          .map((v) => v.toString().toLowerCase())
          .any((s) => s.contains(qq));
    }).toList();
  }

  // Delete helpers
  void _doDelete() {
    setState(() {
      _deletableRows.removeWhere((r) => _deleteSelected.contains(r['id']));
      _deleteSelected = {};
    });
  }

  void _doRevert() {
    setState(() {
      _deletableRows = _copy();
      _deleteSelected = {};
    });
  }

  //  Pagination
  List<Map<String, dynamic>> get _pagedRows {
    final start = (_page - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, _seed.length);
    return _seed.sublist(start, end);
  }

  //  Build
  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final t = theme.typography;

    // Editable cell configuration extracted so validators can be checked
    final Map<String, CKEditableCell> itemEditableCells = {
      // Text field for Item (always required)
      'item': CKEditableCell.textField(
        hint: 'Enter item name',
        validator: (value, row) {
          if (value == null || value.toString().trim().isEmpty) {
            return 'Item is required';
          }
          return null;
        },
      ),

      // Dropdown for Transfer Type
      'transfer_type': CKEditableCell.dropdown(
        items: const [
          DropdownMenuItem(value: 'Internal', child: Text('Internal')),
          DropdownMenuItem(value: 'External', child: Text('External')),
        ],
        hint: 'Select type',
      ),

      // Text field for Destination (always required)
      'destination': CKEditableCell.textField(
        hint: 'Enter destination',
        validator: (value, row) {
          if (value == null || value.toString().trim().isEmpty) {
            return 'Destination is required';
          }
          return null;
        },
      ),

      // Dropdown for Courier (required if External)
      'courier': CKEditableCell.dropdown(
        items: const [
          DropdownMenuItem(value: 'FedEx', child: Text('FedEx')),
          DropdownMenuItem(value: 'UPS', child: Text('UPS')),
          DropdownMenuItem(value: 'DHL', child: Text('DHL')),
          DropdownMenuItem(value: 'USPS', child: Text('USPS')),
        ],
        hint: 'Select courier',
        validator: (value, row) {
          // Only required if transfer type is External
          if (row['transfer_type'] == 'External') {
            if (value == null || value.toString().trim().isEmpty) {
              return 'Required for external transfers';
            }
          }
          return null;
        },
      ),

      // Text field for Tracking No. (required if External)
      'tracking_no': CKEditableCell.textField(
        hint: 'Enter tracking number',
        validator: (value, row) {
          // Only required if transfer type is External
          if (row['transfer_type'] == 'External') {
            if (value == null || value.toString().trim().isEmpty) {
              return 'Required for external transfers';
            }
            // Additional validation: must be numeric
            final str = value.toString();
            if (str.isNotEmpty && int.tryParse(str) == null) {
              return 'Must be a number';
            }
          }
          return null;
        },
      ),

      // Checkbox for Verified
      'verified': CKEditableCell.checkbox(label: 'Verified'),
    };

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  1. Editable Table
          _SectionLabel('1 · Editable Table (Inline Cells)', theme),
          SizedBox(height: s.xs),
          Text(
            'Name and Email cells are editable inline. Changes are reflected in the data preview below.',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            columns: _baseColumns,
            rows: _filterRows(_editableRows, _editableSearch),
            rowKey: 'id',
            title: 'Users',
            subtitle: '${_editableRows.length} records',
            searchQuery: _editableSearch,
            searchHint: 'Search users…',
            onSearchChanged: (v) => setState(() => _editableSearch = v),
            editableColumns: const {'name', 'email'},
            onCellChanged: _onCellChanged,
            totalCount: _editableRows.length,
            pageSize: _editableRows.length.clamp(1, 999),
            currentPage: 1,
          ),
          SizedBox(height: s.sm),
          _DataPreview(
            label: 'Table data after edits',
            rows: _editableRows,
            fields: const ['id', 'name', 'email', 'role', 'status'],
          ),

          SizedBox(height: s.x3l),

          //  2. Delete Multiple Rows + Compact Table
          _SectionLabel('2 · Delete Multiple Rows', theme),
          SizedBox(height: s.xs),
          Text(
            'Select rows, then tap Delete. Revert restores the original data.',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            key: ValueKey('deletable_${_deletableRows.length}_$_deleteSearch'),
            widthBehavior: TableWidthBehavior.compact,
            columns: _baseColumns,
            // Pass a fresh copy of the rows to ensure the table sees the
            // updated list identity after mutations (delete/revert). Some
            // internal caches rely on list identity and may not update if
            // the same list instance is reused.
            rows: _filterRows(
              _deletableRows,
              _deleteSearch,
            ).map((r) => Map<String, dynamic>.from(r)).toList(),
            rowKey: 'id',
            title: 'Users',
            subtitle: '${_deletableRows.length} records',
            searchQuery: _deleteSearch,
            searchHint: 'Search users…',
            onSearchChanged: (v) => setState(() => _deleteSearch = v),
            headerActions: [
              if (_deleteSelected.isNotEmpty)
                FilledButton.icon(
                  onPressed: _doDelete,
                  style: FilledButton.styleFrom(
                    backgroundColor: c.error,
                    foregroundColor: c.onError,
                  ),
                  icon: Icon(LucideIcons.trash2, size: s.md),
                  label: Text('Delete (${_deleteSelected.length})'),
                ),
              OutlinedButton.icon(
                onPressed: _doRevert,
                icon: Icon(LucideIcons.rotateCcw, size: s.md),
                label: const Text('Revert'),
              ),
            ],
            selectionMode: TableSelectionMode.multiple,
            selectedKeys: _deleteSelected,
            onSelectionChanged: (sel) => setState(() => _deleteSelected = sel),
            totalCount: _deletableRows.length,
            pageSize: _deletableRows.length.clamp(1, 999),
            currentPage: 1,
            emptyMessage: 'All rows deleted. Tap Revert to restore.',
          ),
          SizedBox(height: s.sm),
          _DataPreview(
            label: 'Remaining rows after deletion',
            rows: _deletableRows,
            fields: const ['id', 'name', 'role', 'status'],
          ),

          SizedBox(height: s.x3l),

          //  3. Multiple Selection
          _SectionLabel('3 · Multiple Selection', theme),
          SizedBox(height: s.xs),
          Text(
            'Selected row IDs and names are printed below the table.',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            columns: _baseColumns,
            rows: _filterRows(_seed, _multiSearch),
            rowKey: 'id',
            title: 'Users',
            subtitle: '${_seed.length} records',
            searchQuery: _multiSearch,
            searchHint: 'Search users…',
            onSearchChanged: (v) => setState(() => _multiSearch = v),
            selectionMode: TableSelectionMode.multiple,
            selectedKeys: _multiSelected,
            onSelectionChanged: (sel) => setState(() => _multiSelected = sel),
            totalCount: _seed.length,
            pageSize: _seed.length.clamp(1, 999),
            currentPage: 1,
          ),
          SizedBox(height: s.sm),
          _SelectionPreview(
            selected: _multiSelected,
            rows: _seed,
            rowKey: 'id',
            labelKey: 'name',
          ),

          SizedBox(height: s.x3l),

          //  4. Pagination (Local) + Action Button
          _SectionLabel('4 · Pagination (Local) + Action Button', theme),
          SizedBox(height: s.xs),
          Text(
            '$_pageSize per page · ${_seed.length} total · page $_page of ${(_seed.length / _pageSize).ceil()}',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            columns: _baseColumns,
            rows: _filterRows(_pagedRows, _pagedSearch),
            rowKey: 'id',
            title: 'Users',
            subtitle: '${_seed.length} records',
            searchQuery: _pagedSearch,
            searchHint: 'Search users…',
            onSearchChanged: (v) => setState(() => _pagedSearch = v),
            headerActions: [
              FilledButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Exporting data…'),
                    duration: Duration(seconds: 2),
                  ),
                ),
                icon: Icon(LucideIcons.download, size: s.md),
                label: const Text('Export'),
              ),
            ],
            totalCount: _seed.length,
            currentPage: _page,
            pageSize: _pageSize,
            onPageChanged: (p) => setState(() => _page = p),
            onPageSizeChanged: (sz) => setState(() {
              _pageSize = sz;
              _page = 1; // ensure page is reset
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Page size changed to $sz')),
              );
            }),
          ),

          SizedBox(height: s.x3l),
          Text(
            ' 6. Sortable & Filterable Columns',
            style: t.labelLg.copyWith(color: c.onSurface),
          ),
          SizedBox(height: s.xs),
          Text(
            'Click the sort and filter icons in the column headers to interact. '
            'The table emits filter and sort changes through callbacks—you decide how to handle them.',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            columns: _baseColumns,
            rows: _filterRows(_seed, _sortableSearch),
            rowKey: 'id',
            title: 'Users',
            subtitle: '${_seed.length} records',
            searchQuery: _sortableSearch,
            searchHint: 'Search users…',

            onSearchChanged: (v) => setState(() => _sortableSearch = v),
            sortColumnKey: _sortableColumnKey,
            sortAscending: _sortableAscending,
            onSortChanged: (key, ascending) {
              setState(() {
                _sortableColumnKey = key;
                _sortableAscending = ascending;
              });
              // In a real app, you'd sort the data based on these values
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Sorting by "$key" ${ascending ? 'ascending' : 'descending'}',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            onFilterChanged: (filters) {
              setState(() => _sortableFilters = filters);
              // Show active filters
              if (filters.isNotEmpty) {
                final filterText = filters
                    .map((f) => '${f.field} ${f.operator.label} "${f.value}"')
                    .join(', ');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Active filters: $filterText'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            totalCount: _seed.length,
            pageSize: _seed.length.clamp(1, 999),
            currentPage: 1,
          ),
          SizedBox(height: s.sm),
          if (_sortableFilters.isNotEmpty)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: c.surfaceVariant,
                borderRadius: BorderRadius.circular(theme.radius.md),
                border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
              ),
              padding: EdgeInsets.all(s.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Filters (${_sortableFilters.length})',
                    style: t.labelSm.copyWith(color: c.onSurfaceVariant),
                  ),
                  SizedBox(height: s.sm),
                  for (final filter in _sortableFilters)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: s.xs),
                      child: Text(
                        '${filter.field}: ${filter.operator.label} "${filter.value}"',
                        style: t.textSm.copyWith(color: c.onSurface),
                      ),
                    ),
                  SizedBox(height: s.sm),
                  Text(
                    'Note: Filtering is not applied by the table. '
                    'The parent component receives filter data and decides how to use it '
                    '(e.g., local filtering, API query parameters, custom logic).',
                    style: t.textXs.copyWith(
                      color: c.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: s.x3l),

          //  7. Editable with Custom Inputs & Row-Aware Validation
          _SectionLabel(
            '7 · Editable Cells with Custom Inputs & Row-Aware Validation',
            theme,
          ),
          SizedBox(height: s.xs),
          Text(
            'Demonstrates custom input types (dropdown, checkbox) and validation rules that depend on other cell values.',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          Text(
            'Validation rules:',
            style: t.labelSm.copyWith(color: c.onSurface),
          ),
          SizedBox(height: s.xs),
          Text(
            '• Item and Destination are always required\n'
            '• If Transfer Type = Internal: Courier and Tracking No. are optional\n'
            '• If Transfer Type = External: Courier and Tracking No. are required',
            style: t.textSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.md),
          CKDataTable(
            columns: [
              CKTableColumn(
                key: 'x',
                label: '',
                width: 60,
                cellBuilder: (v, row) {
                  // Consider all configured editable validators for this row.
                  final allValid = itemEditableCells.entries.every((entry) {
                    final validator = entry.value.validator;
                    if (validator == null) return true;
                    final colKey = entry.key;
                    final val = row[colKey];
                    return validator(val, row) == null;
                  });
                  final icon = allValid ? Icons.check_circle : Icons.cancel;
                  final color = allValid ? c.success : c.error;
                  return Center(child: Icon(icon, size: 18, color: color));
                },
              ),
              CKTableColumn(key: 'item', label: 'Item', sortable: true),
              CKTableColumn(
                key: 'transfer_type',
                label: 'Transfer Type',
                sortable: true,
              ),
              CKTableColumn(
                key: 'destination',
                label: 'Destination',
                sortable: true,
              ),
              CKTableColumn(key: 'courier', label: 'Courier'),
              CKTableColumn(key: 'tracking_no', label: 'Tracking No.'),
              CKTableColumn(
                key: 'verified',
                label: '',
                textAlign: TextAlign.center,
                cellBuilder: (v, row) => Builder(
                  builder: (ctx) {
                    final theme = ctx.ckcoreTheme;
                    final color = v == true
                        ? theme.colors.success
                        : theme.colors.error;
                    return Center(
                      child: Icon(
                        v == true ? Icons.check_circle : Icons.cancel,
                        color: color,
                        size: 18,
                      ),
                    );
                  },
                ),
              ),
            ],
            rows: _itemTransferRows,
            rowKey: 'id',
            title: 'Item Transfers',
            subtitle: 'Manage item transfers with validation',

            // Configure editable cells with custom inputs and row-aware validation
            editableCells: itemEditableCells,

            // Handle cell value changes
            onCellValueChanged: (rowKey, columnKey, newValue) {
              setState(() {
                final rowIndex = _itemTransferRows.indexWhere(
                  (row) => row['id'] == rowKey,
                );
                if (rowIndex != -1) {
                  _itemTransferRows[rowIndex][columnKey] = newValue;

                  // If transfer type changes, clear courier and tracking fields
                  if (columnKey == 'transfer_type' && newValue == 'Internal') {
                    _itemTransferRows[rowIndex]['courier'] = '';
                    _itemTransferRows[rowIndex]['tracking_no'] = '';
                  }
                }
              });
            },

            // Table settings
            selectionMode: TableSelectionMode.none,
            totalCount: _itemTransferRows.length,
            pageSize: 10,
            striped: true,
          ),
          SizedBox(height: s.sm),
          _DataPreview(
            label: 'Item Transfer Data',
            rows: _itemTransferRows,
            fields: const [
              'id',
              'item',
              'transfer_type',
              'courier',
              'tracking_no',
              'verified',
            ],
          ),
        ],
      ),
    );
  }

  void addRow() {
    setState(() {
      final newId =
          _seed
              .map((r) => r['id'] as int)
              .fold(0, (prev, curr) => curr > prev ? curr : prev) +
          1;
      _seed.add({
        'id': newId,
        'name': 'New User $newId',
        'email': 'newuser$newId@example.com',
      });
    });
  }
}

//  Status text cell
class _StatusText extends StatelessWidget {
  final String status;
  const _StatusText({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final color = switch (status) {
      'Active' => theme.colors.success,
      'Pending' => theme.colors.warning,
      _ => theme.colors.onSurfaceVariant,
    };
    return Text(
      status,
      style: theme.typography.labelSm.copyWith(color: color),
      overflow: TextOverflow.ellipsis,
    );
  }
}

//  Data preview
class _DataPreview extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> rows;
  final List<String> fields;

  const _DataPreview({
    required this.label,
    required this.rows,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surfaceVariant,
        borderRadius: BorderRadius.circular(theme.radius.md),
        border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
      ),
      padding: EdgeInsets.all(s.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: t.labelSm.copyWith(color: c.onSurfaceVariant)),
          SizedBox(height: s.sm),
          if (rows.isEmpty)
            Text('(empty)', style: t.textSm.copyWith(color: c.onSurfaceVariant))
          else
            Table(
              border: TableBorder.all(
                color: c.outlineVariant,
                width: s.xxs / 2,
              ),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: c.surface),
                  children: fields
                      .map(
                        (f) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: s.sm,
                            vertical: s.xs,
                          ),
                          child: Text(
                            f,
                            style: t.labelSm.copyWith(
                              color: c.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                for (final row in rows)
                  TableRow(
                    children: fields
                        .map(
                          (f) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: s.sm,
                              vertical: s.xs,
                            ),
                            child: Text(
                              row[f]?.toString() ?? '',
                              style: t.textSm.copyWith(color: c.onSurface),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

//  Selection preview
class _SelectionPreview extends StatelessWidget {
  final Set<dynamic> selected;
  final List<Map<String, dynamic>> rows;
  final String rowKey;
  final String labelKey;

  const _SelectionPreview({
    required this.selected,
    required this.rows,
    required this.rowKey,
    required this.labelKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;
    final o = theme.opacity;

    final selectedRows = rows
        .where((r) => selected.contains(r[rowKey]))
        .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surfaceVariant,
        borderRadius: BorderRadius.circular(theme.radius.md),
        border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
      ),
      padding: EdgeInsets.all(s.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected rows (${selectedRows.length})',
            style: t.labelSm.copyWith(color: c.onSurfaceVariant),
          ),
          SizedBox(height: s.sm),
          if (selectedRows.isEmpty)
            Text(
              'No rows selected.',
              style: t.textSm.copyWith(color: c.onSurfaceVariant),
            )
          else
            Wrap(
              spacing: s.sm,
              runSpacing: s.xs,
              children: selectedRows
                  .map(
                    (r) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: s.sm,
                        vertical: s.xs,
                      ),
                      decoration: BoxDecoration(
                        color: c.primary.withValues(alpha: o.subtle),
                        borderRadius: BorderRadius.circular(theme.radius.full),
                        border: Border.all(
                          color: c.primary.withValues(alpha: o.muted),
                          width: s.xxs / 2,
                        ),
                      ),
                      child: Text(
                        '#${r[rowKey]} · ${r[labelKey]}',
                        style: t.labelSm.copyWith(color: c.primary),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

//  Section label
class _SectionLabel extends StatelessWidget {
  final String text;
  final ckcoreThemeData theme;
  const _SectionLabel(this.text, this.theme);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: theme.typography.labelLg.copyWith(color: theme.colors.onSurface),
  );
}
