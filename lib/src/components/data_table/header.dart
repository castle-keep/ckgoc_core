import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/inputs/ckgoc_text_field.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    this.title,
    this.subtitle,
    this.searchController,
    this.searchHint,
    this.onSearchChanged,
    this.actions,
    super.key,
  });
  final String? title;
  final String? subtitle;
  final TextEditingController? searchController;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;
    final bp = theme.breakpoints;

    return LayoutBuilder(
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
            child: CkgocTextField(
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
              if (actionsRow != null) ...[SizedBox(width: s.sm), actionsRow],
            ],
          ),
        );
      },
    );
  }
}
