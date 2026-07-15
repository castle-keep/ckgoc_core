import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

class TableFooter extends StatelessWidget {
  const TableFooter({
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    this.onPageChanged,
    super.key,
  });
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final ValueChanged<int>? onPageChanged;

  int get _totalPages => pageSize > 0 ? (totalCount / pageSize).ceil() : 1;

  int get _firstItem => totalCount == 0 ? 0 : (currentPage - 1) * pageSize + 1;

  int get _lastItem => (currentPage * pageSize).clamp(0, totalCount);

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;
    final bp = theme.breakpoints;

    final countText = Text(
      totalCount == 0
          ? 'No results'
          : 'Showing $_firstItem–$_lastItem of $totalCount results',
      style: t.textSm.copyWith(color: c.onSurfaceVariant),
    );

    final pagination = _totalPages > 1
        ? PaginationWidget(
            currentPage: currentPage,
            totalPages: _totalPages,
            onPageChanged: onPageChanged,
          )
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < bp.md;
        if (isNarrow) {
          return Container(
            color: c.surfaceVariant,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  countText,
                  if (pagination != null) ...[
                    SizedBox(height: s.sm),
                    Center(child: pagination),
                  ],
                ],
              ),
            ),
          );
        }

        return Container(
          color: c.surfaceVariant,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: s.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [countText, if (pagination != null) pagination],
            ),
          ),
        );
      },
    );
  }
}

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    required this.currentPage,
    required this.totalPages,
    this.onPageChanged,
    super.key,
  });
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;

  List<Object> get _pageItems {
    if (totalPages <= 7) return List.generate(totalPages, (i) => i + 1);
    final pages = <Object>[];
    pages.add(1);
    if (currentPage > 3) pages.add('…');
    for (
      int p = (currentPage - 1).clamp(2, totalPages - 1);
      p <= (currentPage + 1).clamp(2, totalPages - 1);
      p++
    ) {
      pages.add(p);
    }
    if (currentPage < totalPages - 2) pages.add('…');
    pages.add(totalPages);
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PageButton(
          icon: Icons.chevron_left,
          onTap: currentPage > 1
              ? () => onPageChanged?.call(currentPage - 1)
              : null,
        ),
        SizedBox(width: s.xxs),
        for (final item in _pageItems)
          item is int
              ? PageNumberButton(
                  page: item,
                  isActive: item == currentPage,
                  onTap: () => onPageChanged?.call(item),
                )
              : const EllipsisWidget(),
        SizedBox(width: s.xxs),
        PageButton(
          icon: Icons.chevron_right,
          onTap: currentPage < totalPages
              ? () => onPageChanged?.call(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}

class PageNumberButton extends StatelessWidget {
  const PageNumberButton({
    required this.page,
    required this.isActive,
    required this.onTap,
    super.key,
  });
  final int page;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final r = theme.radius;

    return GestureDetector(
      onTap: isActive ? null : onTap,
      child: AnimatedContainer(
        duration: theme.motion.fast,
        width: s.xl,
        height: s.xl,
        margin: EdgeInsets.symmetric(horizontal: s.xxs),
        decoration: BoxDecoration(
          color: isActive ? c.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(r.base),
          border: isActive
              ? null
              : Border.all(color: c.outlineVariant, width: s.xxs / 2),
        ),
        alignment: Alignment.center,
        child: Text(
          '$page',
          style: theme.typography.labelSm.copyWith(
            color: isActive ? c.onPrimary : c.onSurface,
          ),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({required this.icon, this.onTap, super.key});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final r = theme.radius;
    final o = theme.opacity;
    final isDisabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: theme.motion.fast,
        opacity: isDisabled ? o.disabled : o.full,
        child: Container(
          width: s.xl,
          height: s.xl,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(r.base),
            border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: s.md, color: c.onSurface),
        ),
      ),
    );
  }
}

class EllipsisWidget extends StatelessWidget {
  const EllipsisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;

    return SizedBox(
      width: s.xl,
      height: s.xl,
      child: Center(
        child: Text(
          '…',
          style: theme.typography.labelSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
