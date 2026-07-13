import 'package:ckgoc_core/src/components/data_table/ckgoc_table_column.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';
import 'package:ckgoc_core/src/components/data_table/header.dart';
import 'package:ckgoc_core/src/components/data_table/column_header.dart';
import 'package:ckgoc_core/src/components/data_table/utils.dart';
import 'package:ckgoc_core/src/components/data_table/row.dart';
import 'package:ckgoc_core/src/components/data_table/misc.dart';
import 'package:ckgoc_core/src/components/data_table/footer.dart';

class CkgocDataTable extends StatefulWidget {
  const CkgocDataTable({
    required this.columns,
    required this.rows,
    this.rowKey = 'id',
    this.title,
    this.subtitle,
    this.headerActions,
    this.searchQuery,
    this.searchHint,
    this.onSearchChanged,
    this.sortColumnKey,
    this.sortAscending = true,
    this.onSortChanged,
    this.selectionMode = TableSelectionMode.none,
    this.selectedKeys = const {},
    this.onSelectionChanged,
    this.totalCount = 0,
    this.currentPage = 1,
    this.pageSize = 10,
    this.onPageChanged,
    this.isLoading = false,
    this.errorMessage,
    this.emptyMessage,
    this.emptyWidget,
    this.footerRow,
    this.widthBehavior = TableWidthBehavior.stretch,
    this.maxHeight,
    this.onRowTap,
    this.editableColumns,
    this.onCellChanged,
    super.key,
  });
  final List<CkgocTableColumn> columns;
  final List<Map<String, dynamic>> rows;
  final String rowKey;
  final String? title;
  final String? subtitle;
  final List<Widget>? headerActions;
  final String? searchQuery;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final String? sortColumnKey;
  final bool sortAscending;
  final void Function(String columnKey, bool ascending)? onSortChanged;
  final TableSelectionMode selectionMode;
  final Set<dynamic> selectedKeys;
  final ValueChanged<Set<dynamic>>? onSelectionChanged;
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final ValueChanged<int>? onPageChanged;
  final bool isLoading;
  final String? errorMessage;
  final String? emptyMessage;
  final Widget? emptyWidget;
  final Map<String, dynamic>? footerRow;
  final TableWidthBehavior widthBehavior;
  final double? maxHeight;
  final void Function(Map<String, dynamic> row)? onRowTap;
  final Set<String>? editableColumns;
  final void Function(dynamic rowKey, String columnKey, dynamic newValue)?
  onCellChanged;

  @override
  State<CkgocDataTable> createState() => _CompanyDataTableState();
}

class _CompanyDataTableState extends State<CkgocDataTable> {
  dynamic _hoveredKey;
  late final TextEditingController _searchController;
  final Map<String, TextEditingController> _editControllers = {};
  final ScrollController _hScrollController = ScrollController();
  final ScrollController _vScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery ?? '');
    _syncEditControllers();
  }

  @override
  void didUpdateWidget(CkgocDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != _searchController.text) {
      _searchController.text = widget.searchQuery ?? '';
    }
    if (widget.rows != oldWidget.rows ||
        widget.editableColumns != oldWidget.editableColumns) {
      _syncEditControllers();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _hScrollController.dispose();
    _vScrollController.dispose();
    for (final ctrl in _editControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _syncEditControllers() {
    final cols = widget.editableColumns;
    if (cols == null || cols.isEmpty) {
      for (final ctrl in _editControllers.values) {
        ctrl.dispose();
      }
      _editControllers.clear();
      return;
    }
    final activeKeys = <String>{};
    for (final row in widget.rows) {
      final rk = row[widget.rowKey];
      for (final col in cols) {
        final k = '${rk}_$col';
        activeKeys.add(k);
        _editControllers.putIfAbsent(
          k,
          () => TextEditingController(text: row[col]?.toString() ?? ''),
        );
      }
    }
    final stale = _editControllers.keys
        .where((k) => !activeKeys.contains(k))
        .toList();
    for (final k in stale) {
      _editControllers[k]!.dispose();
      _editControllers.remove(k);
    }
  }

  List<CkgocTableColumn> get _visibleColumns =>
      widget.columns.where((c) => !c.hidden).toList();

  bool get _hasSelection => widget.selectionMode != TableSelectionMode.none;

  bool get _allSelected =>
      widget.rows.isNotEmpty &&
      widget.rows.every((r) => widget.selectedKeys.contains(r[widget.rowKey]));

  bool get _someSelected =>
      widget.rows.any((r) => widget.selectedKeys.contains(r[widget.rowKey]));

  void _toggleAll() {
    if (widget.onSelectionChanged == null) return;
    if (_allSelected) {
      final next = Set<dynamic>.from(widget.selectedKeys)
        ..removeAll(widget.rows.map((r) => r[widget.rowKey]));
      widget.onSelectionChanged!(next);
    } else {
      final next = Set<dynamic>.from(widget.selectedKeys)
        ..addAll(widget.rows.map((r) => r[widget.rowKey]));
      widget.onSelectionChanged!(next);
    }
  }

  void _toggleRow(dynamic key) {
    if (widget.onSelectionChanged == null) return;
    if (widget.selectionMode == TableSelectionMode.single) {
      widget.onSelectionChanged!(
        widget.selectedKeys.contains(key) ? {} : {key},
      );
      return;
    }
    final next = Set<dynamic>.from(widget.selectedKeys);
    if (next.contains(key)) {
      next.remove(key);
    } else {
      next.add(key);
    }
    widget.onSelectionChanged!(next);
  }

  void _handleSort(String key) {
    if (widget.onSortChanged == null) return;
    if (widget.sortColumnKey == key) {
      widget.onSortChanged!(key, !widget.sortAscending);
    } else {
      widget.onSortChanged!(key, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final r = theme.radius;

    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(r.lg),
        border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
        boxShadow: theme.shadows.sm,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null ||
              widget.onSearchChanged != null ||
              (widget.headerActions?.isNotEmpty ?? false))
            TableHeader(
              title: widget.title,
              subtitle: widget.subtitle,
              searchController: _searchController,
              searchHint: widget.searchHint,
              onSearchChanged: widget.onSearchChanged,
              actions: widget.headerActions,
            ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact =
                  widget.widthBehavior == TableWidthBehavior.compact;
              final widths = resolveTableWidths(
                context: context,
                columns: widget.columns,
                available: constraints.maxWidth,
                hasSelection: _hasSelection,
                widthBehavior: widget.widthBehavior,
              );
              final tableWidth =
                  widths.values.fold(0.0, (s, w) => s + w) +
                  (_hasSelection ? s.x2l : 0);

              final needsHScroll =
                  isCompact || tableWidth > constraints.maxWidth;

              Widget rowsBody = widget.isLoading
                  ? SkeletonRows(
                      columns: _visibleColumns,
                      widths: widths,
                      hasSelection: _hasSelection,
                      selectionWidth: s.x2l,
                      rowCount: widget.pageSize.clamp(3, 8),
                      rowHeight: s.x2l,
                    )
                  : widget.errorMessage != null
                  ? ErrorState(message: widget.errorMessage!)
                  : widget.rows.isEmpty
                  ? (widget.emptyWidget ??
                        EmptyState(
                          message:
                              widget.emptyMessage ?? 'No records to display.',
                        ))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final row in widget.rows)
                          DataRowWidget(
                            row: row,
                            rowKey: widget.rowKey,
                            columns: _visibleColumns,
                            widths: widths,
                            hasSelection: _hasSelection,
                            selectionWidth: s.x2l,
                            isSelected: widget.selectedKeys.contains(
                              row[widget.rowKey],
                            ),
                            isHovered: _hoveredKey == row[widget.rowKey],
                            rowHeight: s.x2l,
                            onTap: () {
                              _toggleRow(row[widget.rowKey]);
                              widget.onRowTap?.call(row);
                            },
                            onHoverChanged: (v) => setState(
                              () => _hoveredKey = v ? row[widget.rowKey] : null,
                            ),
                            editControllers: widget.editableColumns == null
                                ? const {}
                                : {
                                    for (final col in widget.editableColumns!)
                                      if (_editControllers.containsKey(
                                        '${row[widget.rowKey]}_$col',
                                      ))
                                        col:
                                            _editControllers['${row[widget.rowKey]}_$col']!,
                                  },
                            onCellChanged: widget.onCellChanged == null
                                ? null
                                : (colKey, value) => widget.onCellChanged!(
                                    row[widget.rowKey],
                                    colKey,
                                    value,
                                  ),
                          ),
                        if (widget.footerRow != null) ...[
                          Divider(
                            height: s.xxs / 2,
                            thickness: s.xxs / 2,
                            color: c.outlineVariant,
                          ),
                          FooterTotalsRow(
                            row: widget.footerRow!,
                            columns: _visibleColumns,
                            widths: widths,
                            hasSelection: _hasSelection,
                            selectionWidth: s.x2l,
                            rowHeight: s.x2l,
                          ),
                        ],
                      ],
                    );

              if (widget.maxHeight != null) {
                rowsBody = SizedBox(
                  height: widget.maxHeight,
                  child: Scrollbar(
                    controller: _vScrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _vScrollController,
                      scrollDirection: Axis.vertical,
                      child: rowsBody,
                    ),
                  ),
                );
              }

              Widget tableContent = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColumnHeaderRow(
                    columns: _visibleColumns,
                    widths: widths,
                    hasSelection: _hasSelection,
                    selectionWidth: s.x2l,
                    allSelected: _allSelected,
                    someSelected: _someSelected,
                    onToggleAll: _toggleAll,
                    sortColumnKey: widget.sortColumnKey,
                    sortAscending: widget.sortAscending,
                    onSort: _handleSort,
                    rowHeight: s.s40,
                  ),
                  Divider(
                    height: s.xxs / 2,
                    thickness: s.xxs / 2,
                    color: c.outlineVariant,
                  ),
                  rowsBody,
                ],
              );

              if (needsHScroll) {
                tableContent = Scrollbar(
                  controller: _hScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _hScrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: isCompact
                          ? tableWidth
                          : tableWidth.clamp(
                              constraints.maxWidth,
                              double.infinity,
                            ),
                      child: tableContent,
                    ),
                  ),
                );
              }

              return tableContent;
            },
          ),
          Divider(
            height: theme.spacing.xxs / 2,
            thickness: theme.spacing.xxs / 2,
            color: c.outlineVariant,
          ),
          TableFooter(
            totalCount: widget.totalCount,
            currentPage: widget.currentPage,
            pageSize: widget.pageSize,
            onPageChanged: widget.onPageChanged,
          ),
        ],
      ),
    );
  }
}

// top-level wrapper keeps state; UI pieces live in separate files.
