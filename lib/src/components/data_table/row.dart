import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  const DataRowWidget({
    required this.row,
    required this.rowKey,
    required this.columns,
    required this.widths,
    required this.hasSelection,
    required this.selectionWidth,
    required this.isSelected,
    required this.isHovered,
    required this.rowHeight,
    required this.onTap,
    required this.onHoverChanged,
    this.editControllers = const {},
    this.onCellChanged,
    super.key,
  });
  final Map<String, dynamic> row;
  final String rowKey;
  final List<CkgocTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final bool isSelected;
  final bool isHovered;
  final double rowHeight;
  final VoidCallback onTap;
  final ValueChanged<bool> onHoverChanged;
  final Map<String, TextEditingController> editControllers;
  final void Function(String colKey, dynamic value)? onCellChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final o = theme.opacity;

    Color rowBg = c.surface;
    if (isSelected) {
      rowBg = c.primary.withValues(alpha: o.subtle);
    } else if (isHovered) {
      rowBg = c.primary.withValues(alpha: o.hover);
    }

    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: theme.motion.fast,
            decoration: BoxDecoration(
              color: rowBg,
              border: Border(
                bottom: BorderSide(color: c.outlineVariant, width: s.xxs / 2),
              ),
            ),
            height: rowHeight,
            child: Row(
              children: [
                if (hasSelection)
                  SizedBox(
                    width: selectionWidth,
                    child: Center(
                      child: CkgocCheckbox(
                        value: isSelected,
                        onChanged: (_) => onTap(),
                      ),
                    ),
                  ),
                for (final col in columns)
                  SizedBox(
                    width: widths[col.key],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: s.md),
                      child: Align(
                        alignment: _alignmentFor(col.textAlign),
                        child: TableCellWidget(
                          column: col,
                          value: row[col.key],
                          row: row,
                          editController: editControllers[col.key],
                          onCellChanged: onCellChanged == null
                              ? null
                              : (v) => onCellChanged!(col.key, v),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AlignmentGeometry _alignmentFor(TextAlign align) => switch (align) {
    TextAlign.center => Alignment.center,
    TextAlign.end || TextAlign.right => Alignment.centerRight,
    _ => Alignment.centerLeft,
  };
}
