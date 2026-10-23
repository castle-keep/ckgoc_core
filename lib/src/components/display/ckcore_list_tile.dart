import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// List tile used by list views and selection lists.
///
/// Shows an optional [leading] widget, a [title] with optional [subtitle], and
/// an optional [trailing] widget. Tappable when [onTap] is provided.
class CKListTile extends StatelessWidget {
  const CKListTile({
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final content = ConstrainedBox(
      constraints: BoxConstraints(minHeight: spacing.x2l),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.sm,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              IconTheme(
                data: IconThemeData(color: colors.onSurfaceVariant),
                child: leading!,
              ),
              SizedBox(width: spacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: typography.labelLg.copyWith(color: colors.onSurface),
                    child: title,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: spacing.xxs),
                    DefaultTextStyle(
                      style: typography.textSm.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: spacing.md),
              IconTheme(
                data: IconThemeData(color: colors.onSurfaceVariant),
                child: trailing!,
              ),
            ],
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: onTap == null
          ? content
          : InkWell(
              onTap: onTap,
              hoverColor: colors.surfaceVariant,
              child: content,
            ),
    );
  }
}

/// Deprecated: Use [CKListTile] instead.
@Deprecated('Use CKListTile instead')
typedef ckcorelistTile = CKListTile;
