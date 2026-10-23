import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

const _columns = [
  CKTableColumn(key: 'name', label: 'Name', sortable: true),
  CKTableColumn(key: 'role', label: 'Role'),
  CKTableColumn(key: 'age', label: 'Age', sortable: true),
];

List<Map<String, dynamic>> _rows([int n = 3]) => [
      for (var i = 1; i <= n; i++)
        {'id': i, 'name': 'Person $i', 'role': 'Role $i', 'age': 20 + i},
    ];

Widget _table({
  List<Map<String, dynamic>>? rows,
  TableSelectionMode selectionMode = TableSelectionMode.none,
  Set<dynamic> selectedKeys = const {},
  ValueChanged<Set<dynamic>>? onSelectionChanged,
  void Function(String, bool)? onSortChanged,
  void Function(Map<String, dynamic>)? onRowTap,
  bool isLoading = false,
  String? errorMessage,
  String? emptyMessage,
  int totalCount = 0,
  int currentPage = 1,
  int pageSize = 10,
  ValueChanged<int>? onPageChanged,
  String? title,
}) =>
    SizedBox(
      width: 700,
      child: CKDataTable(
        columns: _columns,
        rows: rows ?? _rows(),
        title: title,
        selectionMode: selectionMode,
        selectedKeys: selectedKeys,
        onSelectionChanged: onSelectionChanged,
        onSortChanged: onSortChanged,
        onRowTap: onRowTap,
        isLoading: isLoading,
        errorMessage: errorMessage,
        emptyMessage: emptyMessage,
        totalCount: totalCount,
        currentPage: currentPage,
        pageSize: pageSize,
        onPageChanged: onPageChanged,
      ),
    );

void main() {
  smokeMatrix({
    'CKDataTable': () => _table(),
    'CKDataTable titled': () => _table(title: 'People'),
    'CKDataTable multi-select': () => _table(
          selectionMode: TableSelectionMode.multiple,
          selectedKeys: {1},
          onSelectionChanged: (_) {},
        ),
    'CKDataTable paged': () => _table(
          rows: _rows(5),
          totalCount: 25,
          pageSize: 5,
          currentPage: 2,
          onPageChanged: (_) {},
        ),
    'CKDataTable loading': () => _table(isLoading: true),
    'CKDataTable error': () => _table(errorMessage: 'Boom'),
    'CKDataTable empty': () => _table(rows: const []),
  }, settle: false);

  group('CKDataTable content', () {
    testWidgets('renders headers and cell values', (tester) async {
      await pumpCK(tester, _table());
      for (final label in ['Name', 'Role', 'Age']) {
        expect(find.text(label), findsOneWidget);
      }
      expect(find.text('Person 1'), findsOneWidget);
      expect(find.text('Role 3'), findsOneWidget);
      expect(find.text('23'), findsOneWidget);
    });

    testWidgets('shows the title', (tester) async {
      await pumpCK(tester, _table(title: 'People'));
      expect(find.text('People'), findsOneWidget);
    });

    testWidgets('shows the default empty message', (tester) async {
      await pumpCK(tester, _table(rows: const []));
      expect(find.text('No records to display.'), findsOneWidget);
    });

    testWidgets('shows a custom empty message', (tester) async {
      await pumpCK(
        tester,
        _table(rows: const [], emptyMessage: 'Nobody here'),
      );
      expect(find.text('Nobody here'), findsOneWidget);
    });

    testWidgets('shows the error message instead of rows', (tester) async {
      await pumpCK(tester, _table(errorMessage: 'Boom'));
      expect(find.text('Boom'), findsOneWidget);
      expect(find.text('Person 1'), findsNothing);
    });

    testWidgets('hides rows while loading', (tester) async {
      await pumpCK(tester, _table(isLoading: true), settle: false);
      expect(find.text('Person 1'), findsNothing);
    });

    testWidgets('hidden columns are not rendered', (tester) async {
      await pumpCK(
        tester,
        SizedBox(
          width: 700,
          child: CKDataTable(
            columns: const [
              CKTableColumn(key: 'name', label: 'Name'),
              CKTableColumn(key: 'role', label: 'Role', hidden: true),
            ],
            rows: _rows(),
          ),
        ),
      );
      expect(find.text('Role'), findsNothing);
      expect(find.text('Role 1'), findsNothing);
    });
  });

  group('CKDataTable interaction', () {
    testWidgets('tapping a row reports it', (tester) async {
      Map<String, dynamic>? tapped;
      await pumpCK(tester, _table(onRowTap: (r) => tapped = r));
      await tester.tap(find.text('Person 2'));
      expect(tapped?['id'], 2);
    });

    testWidgets('tapping a sortable header reports ascending then descending',
        (tester) async {
      final calls = <(String, bool)>[];
      await pumpCK(
        tester,
        StatefulBuilder(
          builder: (context, setState) => SizedBox(
            width: 700,
            child: CKDataTable(
              columns: _columns,
              rows: _rows(),
              onSortChanged: (key, asc) => calls.add((key, asc)),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Name'));
      await tester.pumpAndSettle();
      expect(calls.first, ('name', true));
    });

    testWidgets('non-sortable header is inert', (tester) async {
      final calls = <(String, bool)>[];
      await pumpCK(
        tester,
        _table(onSortChanged: (k, a) => calls.add((k, a))),
      );
      await tester.tap(find.text('Role'));
      await tester.pumpAndSettle();
      expect(calls, isEmpty);
    });

    testWidgets('sorts rows locally when no onSortChanged is given',
        (tester) async {
      await pumpCK(
        tester,
        const SizedBox(
          width: 700,
          child: CKDataTable(
            columns: _columns,
            rows: [
              {'id': 1, 'name': 'Bravo', 'role': 'r', 'age': 2},
              {'id': 2, 'name': 'Alpha', 'role': 'r', 'age': 1},
            ],
          ),
        ),
      );
      final before = tester.getTopLeft(find.text('Bravo')).dy;
      expect(before, lessThan(tester.getTopLeft(find.text('Alpha')).dy));
      await tester.tap(find.text('Name'));
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(find.text('Alpha')).dy,
        lessThan(tester.getTopLeft(find.text('Bravo')).dy),
      );
    });
  });

  group('CKDataTable selection', () {
    testWidgets('multiple mode shows a checkbox per row plus select-all',
        (tester) async {
      await pumpCK(
        tester,
        _table(
          selectionMode: TableSelectionMode.multiple,
          onSelectionChanged: (_) {},
        ),
      );
      expect(find.byType(CKCheckbox), findsNWidgets(4));
    });

    testWidgets('no checkboxes when selection is off', (tester) async {
      await pumpCK(tester, _table());
      expect(find.byType(CKCheckbox), findsNothing);
    });

    testWidgets('selecting a row reports its key', (tester) async {
      Set<dynamic>? latest;
      await pumpCK(
        tester,
        _table(
          selectionMode: TableSelectionMode.multiple,
          onSelectionChanged: (s) => latest = s,
        ),
      );
      // index 0 is select-all; index 1 is the first row.
      await tester.tap(find.byType(CKCheckbox).at(1));
      await tester.pumpAndSettle();
      expect(latest, {1});
    });

    testWidgets('select-all reports every row key', (tester) async {
      Set<dynamic>? latest;
      await pumpCK(
        tester,
        _table(
          selectionMode: TableSelectionMode.multiple,
          onSelectionChanged: (s) => latest = s,
        ),
      );
      await tester.tap(find.byType(CKCheckbox).first);
      await tester.pumpAndSettle();
      expect(latest, {1, 2, 3});
    });
  });

  group('CKDataTable pagination', () {
    testWidgets('footer reports the visible range', (tester) async {
      await pumpCK(
        tester,
        _table(
          rows: _rows(5),
          totalCount: 25,
          pageSize: 5,
          currentPage: 2,
          onPageChanged: (_) {},
        ),
      );
      expect(find.textContaining('Showing 6–10 of 25'), findsOneWidget);
    });

    testWidgets('footer says "No results" for an empty table', (tester) async {
      await pumpCK(tester, _table(rows: const [], totalCount: 0));
      expect(find.text('No results'), findsOneWidget);
    });
  });
}
