import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

Map<String, double> resolveTableWidths({
  required BuildContext context,
  required List<CkgocTableColumn> columns,
  required double available,
  required bool hasSelection,
  required TableWidthBehavior widthBehavior,
}) {
  final cols = columns.where((c) => !c.hidden).toList();
  final fixed = cols.where((c) => c.width != null);
  final flex = cols.where((c) => c.width == null);
  final selectionWidth = hasSelection ? context.ckgocTheme.spacing.x2l : 0.0;
  final fixedTotal = fixed.fold(0.0, (s, c) => s + c.width!);
  final result = <String, double>{};

  if (widthBehavior == TableWidthBehavior.compact) {
    for (final col in cols) {
      result[col.key] = col.width ?? col.minWidth;
    }
  } else {
    final remaining = (available - fixedTotal - selectionWidth).clamp(
      0.0,
      double.infinity,
    );
    final totalFlex = flex.fold(0, (s, c) => s + c.flex);
    for (final col in cols) {
      if (col.width != null) {
        result[col.key] = col.width!;
      } else {
        final proportional = totalFlex > 0
            ? remaining * col.flex / totalFlex
            : 0.0;
        result[col.key] = proportional.clamp(col.minWidth, double.infinity);
      }
    }
  }

  return result;
}
