import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

class FooterTotalsRow extends StatelessWidget {
  const FooterTotalsRow({
    required this.row,
    required this.columns,
    required this.widths,
    required this.hasSelection,
    required this.selectionWidth,
    required this.rowHeight,
    super.key,
  });
  final Map<String, dynamic> row;
  final List<CkgocTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;

    return Container(
      color: c.surfaceVariant,
      height: rowHeight,
      child: Row(
        children: [
          if (hasSelection) SizedBox(width: selectionWidth),
          for (final col in columns)
            SizedBox(
              width: widths[col.key],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: s.md),
                child: Text(
                  row[col.key]?.toString() ?? '',
                  style: t.labelSm.copyWith(color: c.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SkeletonRows extends StatelessWidget {
  const SkeletonRows({
    required this.columns,
    required this.widths,
    required this.hasSelection,
    required this.selectionWidth,
    required this.rowCount,
    required this.rowHeight,
    super.key,
  });
  final List<CkgocTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final int rowCount;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        rowCount,
        (i) => SkeletonRow(
          columns: columns,
          widths: widths,
          hasSelection: hasSelection,
          selectionWidth: selectionWidth,
          rowHeight: rowHeight,
          opacity: 1.0 - i * 0.12,
        ),
      ),
    );
  }
}

class SkeletonRow extends StatelessWidget {
  const SkeletonRow({
    required this.columns,
    required this.widths,
    required this.hasSelection,
    required this.selectionWidth,
    required this.rowHeight,
    required this.opacity,
    super.key,
  });
  final List<CkgocTableColumn> columns;
  final Map<String, double> widths;
  final bool hasSelection;
  final double selectionWidth;
  final double rowHeight;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;

    Widget shimmer(double width) => AnimatedOpacity(
      opacity: opacity.clamp(0.2, 1.0),
      duration: theme.motion.normal,
      child: Container(
        width: width,
        height: s.sm,
        decoration: BoxDecoration(
          color: c.outlineVariant,
          borderRadius: BorderRadius.circular(theme.radius.sm),
        ),
      ),
    );

    return Container(
      height: rowHeight,
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(
          bottom: BorderSide(color: c.outlineVariant, width: s.xxs / 2),
        ),
      ),
      child: Row(
        children: [
          if (hasSelection)
            SizedBox(
              width: selectionWidth,
              child: Center(child: shimmer(s.md)),
            ),
          for (final col in columns)
            SizedBox(
              width: widths[col.key],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: s.md),
                child: shimmer((widths[col.key]! - s.md * 2) * 0.65),
              ),
            ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: s.x3l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox, size: s.x2l, color: c.onSurfaceVariant),
          SizedBox(height: s.sm),
          Text(
            message,
            style: theme.typography.textSm.copyWith(color: c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: s.x3l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: s.x2l, color: c.error),
          SizedBox(height: s.sm),
          Text(
            message,
            style: theme.typography.textSm.copyWith(color: c.error),
          ),
        ],
      ),
    );
  }
}
