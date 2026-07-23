import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class DataTablePage extends StatelessWidget {
  const DataTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Data Table',
      subtitle:
          'Documentation for the data table files under lib/src/components/data_table.',
      children: [
        DocSection(data: _dataTableDoc()),
      ],
    );
  }
}

ComponentDocData _dataTableDoc() => const ComponentDocData(
      title: 'CkgocDataTable',
      summary:
          'Feature-rich data table with search, sorting, selection modes, pagination, empty and loading states, footer rows, inline editing hooks, and row tap handlers.',
      demo: _DataTableDemo(),
      code: '''
CkgocDataTable(
  title: 'Users',
  subtitle: 'System access list',
  columns: columns,
  rows: rows,
  selectionMode: TableSelectionMode.multiple,
  widthBehavior: TableWidthBehavior.stretch,
  onSelectionChanged: (keys) {},
  onSortChanged: (columnKey, ascending) {},
)
''',
      params: [
        DocParam(
          name: 'columns',
          type: 'List<CkgocTableColumn>',
          description: 'Column definitions.',
          requiredParam: true,
        ),
        DocParam(
          name: 'rows',
          type: 'List<Map<String, dynamic>>',
          description: 'Row data.',
          requiredParam: true,
        ),
        DocParam(
          name: 'rowKey',
          type: 'String',
          description: 'Primary key field used for selection and edits.',
          defaultValue: 'id',
        ),
        DocParam(
          name: 'title',
          type: 'String?',
          description: 'Optional table title.',
        ),
        DocParam(
          name: 'subtitle',
          type: 'String?',
          description: 'Optional table subtitle.',
        ),
        DocParam(
          name: 'headerActions',
          type: 'List<Widget>?',
          description: 'Header action widgets.',
        ),
        DocParam(
          name: 'searchQuery',
          type: 'String?',
          description: 'Controlled search text.',
        ),
        DocParam(
          name: 'searchHint',
          type: 'String?',
          description: 'Search field placeholder.',
        ),
        DocParam(
          name: 'onSearchChanged',
          type: 'ValueChanged<String>?',
          description: 'Search callback.',
        ),
        DocParam(
          name: 'sortColumnKey',
          type: 'String?',
          description: 'Controlled sort column.',
        ),
        DocParam(
          name: 'sortAscending',
          type: 'bool',
          description: 'Controlled sort direction.',
          defaultValue: 'true',
        ),
        DocParam(
          name: 'onSortChanged',
          type: 'void Function(String, bool)?',
          description: 'Sort callback.',
        ),
        DocParam(
          name: 'selectionMode',
          type: 'TableSelectionMode',
          description: 'Selection behavior.',
          defaultValue: 'TableSelectionMode.none',
        ),
        DocParam(
          name: 'selectedKeys',
          type: 'Set<dynamic>',
          description: 'Controlled selected row keys.',
          defaultValue: 'const {}',
        ),
        DocParam(
          name: 'onSelectionChanged',
          type: 'ValueChanged<Set<dynamic>>?',
          description: 'Selection callback.',
        ),
        DocParam(
          name: 'totalCount',
          type: 'int',
          description: 'Full dataset size for pagination.',
          defaultValue: '0',
        ),
        DocParam(
          name: 'currentPage',
          type: 'int',
          description: 'Current page number.',
          defaultValue: '1',
        ),
        DocParam(
          name: 'pageSize',
          type: 'int',
          description: 'Page size.',
          defaultValue: '10',
        ),
        DocParam(
          name: 'onPageChanged',
          type: 'ValueChanged<int>?',
          description: 'Pagination callback.',
        ),
        DocParam(
          name: 'isLoading',
          type: 'bool',
          description: 'Shows skeleton rows.',
          defaultValue: 'false',
        ),
        DocParam(
          name: 'errorMessage',
          type: 'String?',
          description: 'Optional error state text.',
        ),
        DocParam(
          name: 'emptyMessage',
          type: 'String?',
          description: 'Optional empty state text.',
        ),
        DocParam(
          name: 'emptyWidget',
          type: 'Widget?',
          description: 'Optional empty-state override.',
        ),
        DocParam(
          name: 'footerRow',
          type: 'Map<String, dynamic>?',
          description: 'Optional summary/footer row.',
        ),
        DocParam(
          name: 'widthBehavior',
          type: 'TableWidthBehavior',
          description: 'Stretch or compact width logic.',
          defaultValue: 'TableWidthBehavior.stretch',
        ),
        DocParam(
          name: 'maxHeight',
          type: 'double?',
          description: 'Maximum table body height before scroll.',
        ),
        DocParam(
          name: 'onRowTap',
          type: 'void Function(Map<String, dynamic>)?',
          description: 'Row tap callback.',
        ),
        DocParam(
          name: 'editableColumns',
          type: 'Set<String>?',
          description: 'Columns that allow inline editing.',
        ),
        DocParam(
          name: 'onCellChanged',
          type: 'void Function(dynamic, String, dynamic)?',
          description: 'Inline edit commit callback.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When is sorting uncontrolled versus controlled?',
          answer:
              'If onSortChanged is null, the table sorts internally. If you provide it, the parent owns sorting state.',
        ),
        DocFaq(
          question: 'What is the row shape?',
          answer:
              'Each row is a plain Map<String, dynamic>, keyed by your column keys and rowKey field.',
        ),
      ],
      notes: [
        'Enum demo coverage: TableSelectionMode and TableWidthBehavior are both exercised in the live demo selector.',
      ],
    );

class _DataTableDemo extends StatefulWidget {
  const _DataTableDemo();

  @override
  State<_DataTableDemo> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<_DataTableDemo> {
  TableSelectionMode selectionMode = TableSelectionMode.multiple;
  TableWidthBehavior widthBehavior = TableWidthBehavior.stretch;
  Set<dynamic> selected = <dynamic>{};
  String query = '';

  List<CkgocTableColumn> get columns => [
        const CkgocTableColumn(
          key: 'name',
          label: 'Name',
          type: CkgocColumnType.text,
          sortable: true,
        ),
        CkgocTableColumn(
          key: 'status',
          label: 'Status',
          type: CkgocColumnType.badge,
          badgeVariantBuilder: (value) => switch (value) {
            'active' => BadgeVariant.success,
            'pending' => BadgeVariant.warning,
            'offline' => BadgeVariant.offline,
            _ => BadgeVariant.defaultFill,
          },
        ),
        const CkgocTableColumn(
          key: 'completion',
          label: 'Completion',
          type: CkgocColumnType.progress,
        ),
        const CkgocTableColumn(
          key: 'owner',
          label: 'Owner',
          type: CkgocColumnType.avatarText,
        ),
        CkgocTableColumn(
          key: 'custom',
          label: 'Custom',
          type: CkgocColumnType.custom,
          cellBuilder: (value, row) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.more_horiz, size: 16),
              const HSpace(width: 6),
              Text('$value'),
            ],
          ),
        ),
      ];

  List<Map<String, dynamic>> get rows => [
        {
          'id': 1,
          'name': 'Alice',
          'status': 'active',
          'completion': 0.85,
          'owner': 'Alice',
          'custom': 'Manage',
        },
        {
          'id': 2,
          'name': 'Bruno',
          'status': 'pending',
          'completion': 0.42,
          'owner': 'Bruno',
          'custom': 'Review',
        },
        {
          'id': 3,
          'name': 'Celine',
          'status': 'offline',
          'completion': 0.12,
          'owner': 'Celine',
          'custom': 'Invite',
        },
      ]
          .where(
            (row) => row['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DropdownButton<TableSelectionMode>(
              value: selectionMode,
              items: TableSelectionMode.values
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text('selection: ${item.name}'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectionMode = value!),
            ),
            DropdownButton<TableWidthBehavior>(
              value: widthBehavior,
              items: TableWidthBehavior.values
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text('width: ${item.name}'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => widthBehavior = value!),
            ),
          ],
        ),
        const VSpace(height: 16),
        CkgocDataTable(
          title: 'Users',
          subtitle: 'System access list',
          columns: columns,
          rows: rows,
          searchQuery: query,
          searchHint: 'Search users',
          onSearchChanged: (value) => setState(() => query = value),
          selectionMode: selectionMode,
          selectedKeys: selected,
          onSelectionChanged: (keys) => setState(() => selected = keys),
          totalCount: rows.length,
          pageSize: 10,
          currentPage: 1,
          widthBehavior: widthBehavior,
        ),
      ],
    );
  }
}
