import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';

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
        DocSection(data: _dataTableColumn()),
        DocSection(data: _editableCellDoc()),
      ],
    );
  }
}

ComponentDocData _dataTableColumn() => const ComponentDocData(
    title: 'CKTableColumn',
    summary:
        'Column definition for CKDataTable. Includes key, label, type, and optional cell builder.',
    code: '''
CKTableColumn(
  key: 'name',
  label: 'Name',
  type: CKColumnType.text,
  sortable: true,
)
''',
    demo: SizedBox.shrink(),
    params: [
      DocParam(
        name: 'key',
        type: 'String',
        description: 'Unique column key.',
        requiredParam: true,
      ),
      DocParam(
        name: 'label',
        type: 'String',
        description: 'Column header label.',
      ),
      DocParam(
        name: 'type',
        type: 'CKColumnType',
        description:
            'Built-in cell renderer type. Use CKColumnType.custom for a custom cellBuilder.',
        defaultValue: 'CKColumnType.text',
      ),
      DocParam(
        name: 'width',
        type: 'double?',
        description: 'Fixed pixel width. Overrides flex.',
      ),
      DocParam(
        name: 'flex',
        type: 'int',
        description:
            'Proportional share of remaining space when width is null. Ignored when width is set.',
        defaultValue: '1',
      ),
      DocParam(
        name: 'minWidth',
        type: 'double',
        description:
            'Minimum pixel width used for this column when the table is in compact mode. Ignored in stretch mode. Has no effect on columns with a fixed width.',
        defaultValue: '120',
      ),
      DocParam(
        name: 'sortable',
        type: 'bool',
        description:
            'Whether the header renders a sort affordance and fires onSortChanged when tapped.',
        defaultValue: 'false',
      ),
      DocParam(
        name: 'filterable',
        type: 'bool',
        description:
            'Whether the header renders a filter affordance and fires onFilterChanged when a filter is applied.',
        defaultValue: 'false',
      ),
      DocParam(
        name: 'hidden',
        type: 'bool',
        description:
            'Hidden columns are excluded from both the header and every row.',
        defaultValue: 'false',
      ),
      DocParam(
        name: 'textAlign',
        type: 'TextAlign',
        description: 'Horizontal alignment of cell content.',
        defaultValue: 'TextAlign.start',
      ),
      DocParam(
        name: 'badgeVariantBuilder',
        type: 'BadgeVariant Function(dynamic value)?',
        description:
            'Required when type is CKColumnType.badge. Maps a cell value to the appropriate BadgeVariant.',
      ),
      DocParam(
        name: 'cellBuilder',
        type: 'Widget Function(dynamic value, Map<String, dynamic> row)?',
        description:
            'Required when type is CKColumnType.custom. Also accepted by any other type as an override.',
      ),
    ],
    faqs: [
      DocFaq(
        question:
            'What is the difference between CKTableColumn and CKDataTable?',
        answer:
            'CKTableColumn defines a single column, while CKDataTable is the overall table widget that uses a list of CKTableColumn objects.',
      ),
      DocFaq(
        question: 'How do I create a custom cell renderer?',
        answer:
            'Set the type to CKColumnType.custom and provide a cellBuilder function that returns a Widget for the cell content.',
      ),
    ]);

ComponentDocData _dataTableDoc() => const ComponentDocData(
      title: 'CKDataTable',
      summary:
          'Feature-rich data table with search, sorting, selection modes, pagination, empty and loading states, footer rows, inline editing hooks, and row tap handlers.',
      demo: _DataTableDemo(),
      code: '''
CKDataTable(
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
          type: 'List<CKTableColumn>',
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
          name: 'editableCells',
          type: 'Map<String, CKEditableCell>?',
          description:
              'Map of columnKey -> CKEditableCell configuration. Use this to provide custom input widgets and row-aware validators for editable cells.',
        ),
        DocParam(
          name: 'onCellChanged',
          type:
              'void Function(dynamic rowKey, String columnKey, dynamic newValue)?',
          description:
              'Inline edit commit callback. Signature: `(rowKey, columnKey, newValue)`.',
        ),
        DocParam(
          name: 'onCellValueChanged',
          type:
              'void Function(dynamic rowKey, String columnKey, dynamic newValue)?',
          description:
              'New preferred callback for editable cells. Receives `(rowKey, columnKey, newValue)`. Use when `editableCells` is provided.',
        ),
        DocParam(
          name: 'onFilterChanged',
          type: 'void Function(List<CKTableFilter>)?',
          description: 'Column filter change callback. Signature: `(filters)`.',
        ),
        DocParam(
          name: 'onPageSizeChanged',
          type: 'ValueChanged<int>?',
          description: 'Page size change callback.',
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
        'onCellChanged: When provided, receives `(rowKey, columnKey, newValue)` for the edited cell — useful for committing inline edits to external state.',
        'New editable cells API: prefer `editableCells` + `onCellValueChanged` for per-column custom inputs and row-aware validation. See `CKEditableCell` documentation below for factory helpers and examples.',
      ],
    );

ComponentDocData _editableCellDoc() => const ComponentDocData(
      title: 'CKEditableCell',
      summary:
          'Configuration object for editable table cells. Provides builders for custom input widgets and row-aware validators.',
      demo: SizedBox.shrink(),
      code: '''
// Example: per-column editable configuration
editableCells: {
  'courier': CKEditableCell.dropdown(
    items: const [
      DropdownMenuItem(value: 'FedEx', child: Text('FedEx')),
      DropdownMenuItem(value: 'UPS', child: Text('UPS')),
    ],
    validator: (value, row) {
      if (row['transfer_type'] == 'External' && (value == null || value.toString().isEmpty)) {
        return 'Required for external transfers';
      }
      return null;
    },
  ),
  'tracking_no': CKEditableCell.textField(
    hint: 'Enter tracking number',
    validator: (value, row) {
      if (row['transfer_type'] == 'External' && (value == null || value.toString().isEmpty)) {
        return 'Required for external transfers';
      }
      return null;
    },
  ),
}
''',
      params: [
        DocParam(
          name: 'builder',
          type:
              'Widget Function(BuildContext, dynamic value, ValueChanged<dynamic> onChanged, Map<String,dynamic> row, bool isActive, String? validationError)',
          description: 'Builds the custom input widget for the cell.',
        ),
        DocParam(
          name: 'validator',
          type: 'String? Function(dynamic value, Map<String,dynamic> row)?',
          description:
              'Row-aware validator that receives the current row map along with the value. Return null for valid, or an error string for invalid.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use CKEditableCell?',
          answer:
              'Use CKEditableCell when you need per-column custom inputs or validation logic that depends on other values in the same row. For simple text-only inline edits you can continue using the legacy editableColumns + onCellChanged API.',
        ),
      ],
      notes: [
        'Factory helpers exist for common input types: textField, dropdown, checkbox, switch_, datePicker.',
        'Validators receive the full row map so rules can depend on sibling cell values.',
      ],
    );

class _DataTableDemo extends StatefulWidget {
  const _DataTableDemo({Key? key}) : super(key: key);

  @override
  State<_DataTableDemo> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<_DataTableDemo> {
  TableSelectionMode selectionMode = TableSelectionMode.multiple;
  TableWidthBehavior widthBehavior = TableWidthBehavior.stretch;
  Set<dynamic> selected = <dynamic>{};
  String query = '';

  List<CKTableColumn> get columns => [
        const CKTableColumn(
          key: 'name',
          label: 'Name',
          type: CKColumnType.text,
          sortable: true,
        ),
        CKTableColumn(
          key: 'status',
          label: 'Status',
          type: CKColumnType.badge,
          badgeVariantBuilder: (value) => switch (value) {
            'active' => BadgeVariant.success,
            'pending' => BadgeVariant.warning,
            'offline' => BadgeVariant.offline,
            _ => BadgeVariant.defaultFill,
          },
        ),
        const CKTableColumn(
          key: 'completion',
          label: 'Completion',
          type: CKColumnType.progress,
        ),
        const CKTableColumn(
          key: 'owner',
          label: 'Owner',
          type: CKColumnType.avatarText,
        ),
        CKTableColumn(
          key: 'custom',
          label: 'Custom',
          type: CKColumnType.custom,
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
        CKDataTable(
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
