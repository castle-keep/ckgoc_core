import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/data_table/ckgoc_table_column.dart';
import 'package:ckgoc_core/src/components/inputs/ckgoc_checkbox.dart';

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
    required this.rowHeight,
    super.key,
  });
  final List<CkgocTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final bool allSelected;
  final bool someSelected;
  final VoidCallback onToggleAll;
  final String? sortColumnKey;
  final bool sortAscending;
  final ValueChanged<String> onSort;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;

    return Container(
      color: c.surface,
      height: rowHeight,
      child: Row(
        children: [
          if (hasSelection)
            SizedBox(
              width: selectionWidth,
              child: Center(
                child: CkgocCheckbox(
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
                      Text(
                        col.label,
                        style: t.labelSm.copyWith(color: c.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
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
