import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

// Defines a single column in a [CkgocDataTable].
//
// Columns are strongly typed and support built-in cell renderers
// ([CkgocColumnType]) as well as a fully custom [cellBuilder].
class CkgocTableColumn {
  const CkgocTableColumn({
    required this.key,
    required this.label,
    this.type = CkgocColumnType.text,
    this.width,
    this.flex = 1,
    this.minWidth = 120,
    this.sortable = false,
    this.hidden = false,
    this.textAlign = TextAlign.start,
    this.badgeVariantBuilder,
    this.cellBuilder,
  });
  // Field key used to look up the value inside each row map.
  final String key;

  // Display label shown in the column header.
  final String label;

  // Built-in cell renderer. Use [CkgocColumnType.custom] and supply
  // [cellBuilder] for anything not covered by the built-in types.
  final CkgocColumnType type;

  // Fixed pixel width. When null the column uses [flex] to share
  // remaining space with other flex columns.
  final double? width;

  // Proportional share of remaining space when [width] is null.
  final int flex;

  // Minimum pixel width used for this column when the table is in
  // [TableWidthBehavior.compact] mode. Ignored in [TableWidthBehavior.stretch]
  // mode. Has no effect on columns with a fixed [width].
  final double minWidth;

  // Whether the header renders a sort affordance and fires
  // [CkgocDataTable.onSortChanged] when tapped.
  final bool sortable;

  // Hidden columns are excluded from both the header and every row.
  final bool hidden;

  // Horizontal alignment of cell content.
  final TextAlign textAlign;

  // Required when [type] is [CkgocColumnType.badge].
  // Maps a cell value to the appropriate [BadgeVariant].
  final BadgeVariant Function(dynamic value)? badgeVariantBuilder;

  // Required when [type] is [CkgocColumnType.custom].
  // Also accepted by any other type as an override.
  final Widget Function(dynamic value, Map<String, dynamic> row)? cellBuilder;

  // Migration adapter — converts a flat [List<String>] of column labels into
  // [CkgocTableColumn] instances. Keys are derived by lower-casing the
  // label and replacing non-alphanumeric characters with underscores.
  static List<CkgocTableColumn> fromStrings(List<String> labels) => labels
      .map(
        (l) => CkgocTableColumn(
          key: l.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_'),
          label: l,
        ),
      )
      .toList();
}
