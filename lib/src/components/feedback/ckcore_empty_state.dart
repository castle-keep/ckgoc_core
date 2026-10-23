import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Centered message for a list, table or page that has nothing to show.
///
/// Pass an [illustration] to replace the default inbox icon, and an [action]
/// (typically a `CKButton`) to suggest the next step.
class CKEmptyState extends StatelessWidget {
  const CKEmptyState({
    required this.title,
    this.description,
    this.illustration,
    this.action,
    super.key,
  });
  final String title;
  final String? description;
  final Widget? illustration;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: theme.breakpoints.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              illustration ??
                  Container(
                    width: spacing.x3l,
                    height: spacing.x3l,
                    decoration: BoxDecoration(
                      color: colors.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.inbox,
                      size: spacing.xl,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
              SizedBox(height: spacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: typography.textXl.copyWith(color: colors.onSurface),
              ),
              if (description != null) ...[
                SizedBox(height: spacing.xs),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: typography.textMd.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
              if (action != null) ...[
                SizedBox(height: spacing.lg),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKEmptyState] instead.
@Deprecated('Use CKEmptyState instead')
typedef ckcoreemptyState = CKEmptyState;
