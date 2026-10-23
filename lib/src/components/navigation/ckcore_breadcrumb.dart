import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Hierarchical breadcrumb navigation trail.
///
/// Every item except the last is a link (tappable when it has an `onTap`);
/// the last item is the current page and is shown emphasised. Wraps onto
/// multiple lines when it does not fit.
class CKBreadcrumb extends StatelessWidget {
  const CKBreadcrumb({required this.items, super.key});
  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    return Semantics(
      container: true,
      label: 'Breadcrumb',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: spacing.xs,
        runSpacing: spacing.xxs,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i == items.length - 1)
              Text(
                items[i].label,
                style: typography.labelMd.copyWith(color: colors.onSurface),
              )
            else ...[
              InkWell(
                onTap: items[i].onTap,
                borderRadius: BorderRadius.circular(theme.radius.sm),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing.xxs),
                  child: Text(
                    items[i].label,
                    style: typography.textMd.copyWith(
                      color: items[i].onTap != null
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              Icon(
                LucideIcons.chevronRight,
                size: spacing.md,
                color: colors.onSurfaceVariant,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
