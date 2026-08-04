import 'package:ckcoreui/src/components/display/ckcore_container.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

class CKAccordion extends StatefulWidget {
  const CKAccordion({
    required this.items,
    this.initiallyExpanded,
    this.allowMultiple = false,
    super.key,
  });
  final List<CKAccordionItem> items;
  final int? initiallyExpanded;
  final bool allowMultiple;

  @override
  State<CKAccordion> createState() => _CompanyAccordionState();
}

class _CompanyAccordionState extends State<CKAccordion> {
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
    final theme = context.ckcoreTheme;
    final radius = theme.radius;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.lg),
      child: Column(
        children: [
          for (int i = 0; i < widget.items.length; i++) ...[
            if (i > 0) SizedBox(height: context.ckcoreTheme.spacing.xs),
            _AccordionTile(
              item: widget.items[i],
              isExpanded: _expanded.contains(i),
              onTap: () => _toggle(i),
            ),
          ],
        ],
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
  final CKAccordionItem item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final motion = theme.motion;

    return CKContainer.outlined(
      padding: EdgeInsets.zero,
      child: Column(
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
                    child: Icon(
                      isExpanded
                          ? LucideIcons.chevronDown
                          : LucideIcons.chevronRight,
                      size: spacing.md,
                      color: isExpanded
                          ? colors.primary
                          : colors.onSurfaceVariant,
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
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 1, color: colors.outlineVariant),
                      SizedBox(height: spacing.xs),
                      Padding(
                        padding: EdgeInsets.all(spacing.md),
                        child: DefaultTextStyle(
                          style: typography.textSm.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          child: item.content,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

/// Deprecated: Use [CKAccordion] instead.
@Deprecated('Use CKAccordion instead')
typedef ckcoreaccordion = CKAccordion;
