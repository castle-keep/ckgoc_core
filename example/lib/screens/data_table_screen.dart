import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

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
  static const int _pageSize = 3;
  int _page = 1;
  String _pagedSearch = '';

  @override
  void initState() {
    super.initState();
    _editableRows = _copy();
    _deletableRows = _copy();
  }

  //  Shared base columns
  List<CkgocTableColumn> get _baseColumns => [
    const CkgocTableColumn(
      key: 'name',
      label: 'Name',
      type: CkgocColumnType.avatarText,
      sortable: true,
      flex: 2,
    ),
    const CkgocTableColumn(key: 'email', label: 'Email', flex: 2),
    CkgocTableColumn(
      key: 'role',
      label: 'Role',
      width: 110,
      type: CkgocColumnType.badge,
      badgeVariantBuilder: (v) => switch (v.toString()) {
        'Admin' => BadgeVariant.primary,
        'Editor' => BadgeVariant.info,
        _ => BadgeVariant.outline,
      },
    ),
    CkgocTableColumn(
      key: 'status',
      label: 'Status',
      width: 90,
      cellBuilder: (v, _) => _StatusText(status: v.toString()),
    ),
    CkgocTableColumn(
      key: 'actions',
      label: 'Actions',
      width: 100,
      textAlign: TextAlign.center,
      cellBuilder: (v, row) => Builder(
        builder: (ctx) {
          final theme = ctx.ckgocTheme;
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
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final t = theme.typography;

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
          CkgocDataTable(
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
          CkgocDataTable(
            widthBehavior: TableWidthBehavior.compact,
            columns: _baseColumns,
            rows: _filterRows(_deletableRows, _deleteSearch),
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
          CkgocDataTable(
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
          CkgocDataTable(
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
          ),

          SizedBox(height: s.x3l),
        ],
      ),
    );
  }
}

//  Status text cell
class _StatusText extends StatelessWidget {
  final String status;
  const _StatusText({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
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
    final theme = context.ckgocTheme;
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
    final theme = context.ckgocTheme;
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
  final CkgocThemeData theme;
  const _SectionLabel(this.text, this.theme);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: theme.typography.labelLg.copyWith(color: theme.colors.onSurface),
  );
}
