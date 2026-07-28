import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_column.dart';
import 'package:ckcoreui/src/components/data_table/badge_filters.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    this.title,
    this.subtitle,
    this.searchController,
    this.searchHint,
    this.onSearchChanged,
    this.actions,
    this.backgroundColor,
    this.badgeColumns = const {},
    this.badgeFilters = const {},
    this.onBadgeFilterChanged,
    super.key,
  });
  final String? title;
  final String? subtitle;
  final TextEditingController? searchController;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Map<String, Set<dynamic>> badgeColumns;
  final Map<String, Set<dynamic>> badgeFilters;
  final void Function(String colKey, Set<dynamic> selectedVariants)?
  onBadgeFilterChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;
    final bp = theme.breakpoints;

    final child = LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < bp.md;

        Widget? titleBlock;
        if (title != null) {
          titleBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title!, style: t.labelLg.copyWith(color: c.onSurface)),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: t.textSm.copyWith(color: c.onSurfaceVariant),
                ),
            ],
          );
        }

        Widget? searchField;
        if (onSearchChanged != null) {
          searchField = SizedBox(
            width: isNarrow ? double.infinity : s.x5l + s.xl,
            child: CKTextField(
              hint: searchHint ?? 'Search…',
              controller: searchController,
              onChanged: onSearchChanged,
              leading: Icon(
                LucideIcons.search,
                size: s.md,
                color: c.onSurfaceVariant,
              ),
            ),
          );
        }

        Widget? actionsRow;
        if (actions != null && actions!.isNotEmpty) {
          actionsRow = Wrap(
            spacing: s.xs,
            runSpacing: s.xs,
            children: actions!,
          );
        }

        List<Widget> filterWidgets = [];
        if (badgeColumns.isNotEmpty && onBadgeFilterChanged != null) {
          for (final entry in badgeColumns.entries) {
            final colKey = entry.key;
            final variants = entry.value;
            filterWidgets.add(
              BadgeColumnFilter(
                column: CKTableColumn(key: colKey, label: colKey),
                availableVariants: variants,
                selectedVariants: badgeFilters[colKey] ?? {},
                onChanged: (selected) =>
                    onBadgeFilterChanged!(colKey, selected),
              ),
            );
          }
        }

        if (isNarrow) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (titleBlock != null) ...[titleBlock, SizedBox(height: s.sm)],
                if (searchField != null) ...[
                  searchField,
                  SizedBox(height: s.sm),
                ],
                if (filterWidgets.isNotEmpty) ...[
                  ...filterWidgets.map(
                    (w) => Padding(
                      padding: EdgeInsets.only(bottom: s.sm),
                      child: w,
                    ),
                  ),
                ],
                if (actionsRow != null) actionsRow,
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
          child: Row(
            children: [
              if (titleBlock != null) ...[
                titleBlock,
                const Spacer(),
              ] else
                const Spacer(),
              if (searchField != null) searchField,
              if (filterWidgets.isNotEmpty) ...[
                SizedBox(width: s.sm),
                ...filterWidgets.map(
                  (w) => Padding(
                    padding: EdgeInsets.only(left: s.xs),
                    child: w,
                  ),
                ),
              ],
              if (actionsRow != null) ...[SizedBox(width: s.sm), actionsRow],
            ],
          ),
        );
      },
    );

    return Container(color: backgroundColor, child: child);
  }
}
