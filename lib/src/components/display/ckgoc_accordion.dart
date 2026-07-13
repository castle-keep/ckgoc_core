import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocAccordion extends StatefulWidget {
  const CkgocAccordion({
    required this.items,
    this.initiallyExpanded,
    this.allowMultiple = false,
    super.key,
  });
  final List<CkgocAccordionItem> items;
  final int? initiallyExpanded;
  final bool allowMultiple;

  @override
  State<CkgocAccordion> createState() => _CompanyAccordionState();
}

class _CompanyAccordionState extends State<CkgocAccordion> {
  late final Set<int> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded != null
        ? {widget.initiallyExpanded!}
        : {};
  }

  void _toggle(int index) {
    setState(() {
      if (_expanded.contains(index)) {
        _expanded.remove(index);
      } else {
        if (!widget.allowMultiple) _expanded.clear();
        _expanded.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(radius.lg),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius.lg),
        child: Column(
          children: [
            for (int i = 0; i < widget.items.length; i++) ...[
              if (i > 0)
                Divider(height: 1, thickness: 1, color: colors.outlineVariant),
              _AccordionTile(
                item: widget.items[i],
                isExpanded: _expanded.contains(i),
                onTap: () => _toggle(i),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AccordionTile extends StatelessWidget {
  const _AccordionTile({
    required this.item,
    required this.isExpanded,
    required this.onTap,
  });
  final CkgocAccordionItem item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final motion = theme.motion;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.s12,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: spacing.md,
                  child: Text(
                    isExpanded ? '\u2022' : '\u2013',
                    style: TextStyle(
                      fontSize: spacing.md,
                      fontWeight: FontWeight.bold,
                      color: isExpanded
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(width: spacing.xs),
                Expanded(
                  child: Text(
                    item.title,
                    style: typography.labelMd.copyWith(
                      color: isExpanded ? colors.primary : colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: motion.fast,
          curve: motion.decelerate,
          child: isExpanded
              ? Padding(
                  padding: EdgeInsets.only(
                    left: spacing.xl + spacing.xs,
                    right: spacing.md,
                    bottom: spacing.md,
                  ),
                  child: DefaultTextStyle(
                    style: typography.textSm.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    child: item.content,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
