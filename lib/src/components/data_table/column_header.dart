import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_column.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_filter.dart';
import 'package:ckcoreui/src/components/data_table/column_filter_overlay.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_checkbox.dart';

class ColumnHeaderRow extends StatelessWidget {
  const ColumnHeaderRow({
    required this.columns,
    required this.widths,
    required this.hasSelection,
    required this.selectionWidth,
    required this.allSelected,
    required this.someSelected,
    required this.onToggleAll,
    required this.sortColumnKey,
    required this.sortAscending,
    required this.onSort,
    required this.onFilterApply,
    required this.onFilterClear,
    required this.activeFilters,
    required this.rowHeight,
    super.key,
  });
  final List<CKTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final bool allSelected;
  final bool someSelected;
  final VoidCallback onToggleAll;
  final String? sortColumnKey;
  final bool sortAscending;
  final ValueChanged<String> onSort;
  final ValueChanged<CKTableFilter> onFilterApply;
  final ValueChanged<String> onFilterClear;
  final List<CKTableFilter> activeFilters;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;

    return Container(
      color: c.surfaceVariant,
      height: rowHeight,
      child: Row(
        children: [
          if (hasSelection)
            SizedBox(
              width: selectionWidth,
              child: Center(
                child: CKCheckbox(
                  value: allSelected ? true : (someSelected ? null : false),
                  onChanged: (_) => onToggleAll(),
                ),
              ),
            ),
          for (final col in columns)
            SizedBox(
              width: widths[col.key],
              child: GestureDetector(
                onTap: col.sortable ? () => onSort(col.key) : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.md),
                  child: Row(
                    mainAxisAlignment: _mainAxisFor(col.textAlign),
                    children: [
                      Expanded(
                        child: Text(
                          col.label,
                          style: t.labelSm.copyWith(color: c.onSurfaceVariant),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (col.sortable) ...[
                        SizedBox(width: s.xs),
                        SortIcon(
                          isActive: sortColumnKey == col.key,
                          ascending: sortAscending,
                          color: c.onSurfaceVariant,
                          activeColor: c.primary,
                          size: s.s12,
                        ),
                      ],
                      if (col.filterable) ...[
                        SizedBox(width: s.xs),
                        _FilterIconButton(
                          column: col,
                          columnWidth: widths[col.key] ?? 120,
                          onFilterApply: onFilterApply,
                          onFilterClear: onFilterClear,
                          activeFilter: activeFilters
                              .cast<CKTableFilter?>()
                              .firstWhere(
                                (f) => f?.field == col.key,
                                orElse: () => null,
                              ),
                          filterIconSize: s.s12,
                          filterIconColor: c.onSurfaceVariant,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  MainAxisAlignment _mainAxisFor(TextAlign align) => switch (align) {
    TextAlign.center => MainAxisAlignment.center,
    TextAlign.end || TextAlign.right => MainAxisAlignment.end,
    _ => MainAxisAlignment.start,
  };
}

class SortIcon extends StatelessWidget {
  const SortIcon({
    required this.isActive,
    required this.ascending,
    required this.color,
    required this.activeColor,
    required this.size,
    super.key,
  });
  final bool isActive;
  final bool ascending;
  final Color color;
  final Color activeColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return Icon(LucideIcons.chevronsUpDown, size: size, color: color);
    }
    return Icon(
      ascending ? LucideIcons.chevronUp : LucideIcons.chevronDown,
      size: size,
      color: activeColor,
    );
  }
}

/// Filter icon button for column headers.
/// Displays a popover when tapped to allow filtering.
class _FilterIconButton extends StatefulWidget {
  const _FilterIconButton({
    required this.column,
    required this.columnWidth,
    required this.onFilterApply,
    required this.onFilterClear,
    required this.activeFilter,
    required this.filterIconSize,
    required this.filterIconColor,
  });

  final CKTableColumn column;
  final double columnWidth;
  final ValueChanged<CKTableFilter> onFilterApply;
  final ValueChanged<String> onFilterClear;
  final CKTableFilter? activeFilter;
  final double filterIconSize;
  final Color filterIconColor;

  @override
  State<_FilterIconButton> createState() => _FilterIconButtonState();
}

class _FilterIconButtonState extends State<_FilterIconButton> {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showAbove = false;

  void _openOverlay() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final theme = context.ckcoreTheme;
    final mediaQuery = MediaQuery.of(context);
    final spacing = theme.spacing;
    final fieldOffset = renderBox.localToGlobal(Offset.zero);
    final fieldSize = renderBox.size;
    final availableAbove =
        (fieldOffset.dy - mediaQuery.padding.top - spacing.xs).clamp(
          0.0,
          double.infinity,
        );
    final availableBelow =
        (mediaQuery.size.height -
                mediaQuery.viewInsets.bottom -
                mediaQuery.padding.bottom -
                fieldOffset.dy -
                fieldSize.height -
                spacing.xs)
            .clamp(0.0, double.infinity);

    var showAbove = availableBelow < 160 && availableAbove > 0;
    var availableHeight = showAbove ? availableAbove : availableBelow;
    if (availableHeight <= 0) {
      showAbove = availableAbove > availableBelow;
      availableHeight = showAbove ? availableAbove : availableBelow;
    }

    final menuHeight = availableHeight.clamp(120.0, 400.0);
    final overlayWidth = widget.columnWidth.clamp(0.0, 300.0);
    final fieldHeight = fieldSize.height;

    setState(() => _showAbove = showAbove);

    _overlayEntry = OverlayEntry(
      builder: (_) {
        // Try to find the header cell's RenderBox so we can align the overlay
        RenderBox? headerBox;
        context.visitAncestorElements((el) {
          final ro = el.renderObject;
          if (ro is RenderBox) {
            if ((ro.size.width - widget.columnWidth).abs() < 1.0) {
              headerBox = ro;
              return false;
            }
          }
          return true;
        });

        double offsetX = 0;
        if (headerBox != null) {
          final headerGlobal = headerBox!.localToGlobal(Offset.zero);
          final fieldGlobal = renderBox.localToGlobal(Offset.zero);
          offsetX = headerGlobal.dx - fieldGlobal.dx;
        }

        final offset = Offset(
          offsetX,
          _showAbove ? -(menuHeight + spacing.xs) : fieldHeight + spacing.xs,
        );
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeOverlay,
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: offset,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: overlayWidth,
                  constraints: BoxConstraints(
                    minWidth: overlayWidth,
                    maxWidth: overlayWidth,
                    maxHeight: menuHeight,
                  ),
                  child: ColumnFilterOverlay(
                    column: widget.column,
                    columnWidth: overlayWidth,
                    existingFilter: widget.activeFilter,
                    onFilterApply: (f) {
                      widget.onFilterApply(f);
                      _closeOverlay();
                    },
                    onFilterClear: () {
                      widget.onFilterClear(widget.column.key);
                      _closeOverlay();
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _fieldKey,
        onTap: _openOverlay,
        child: Icon(
          LucideIcons.filter,
          size: widget.filterIconSize,
          color: widget.activeFilter != null
              ? context.ckcoreTheme.colors.primary
              : widget.filterIconColor,
        ),
      ),
    );
  }
}
