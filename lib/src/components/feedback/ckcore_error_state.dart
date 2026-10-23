import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/buttons/ckcore_button.dart';

/// Centered message for when something failed to load.
///
/// Shows a "Try again" button when [onRetry] is provided. Pass [icon] to
/// change the default alert icon (for example for an offline state).
class CKErrorState extends StatelessWidget {
  const CKErrorState({
    required this.title,
    this.description,
    this.onRetry,
    this.icon,
    this.retryLabel,
    super.key,
  });
  final String title;
  final String? description;
  final VoidCallback? onRetry;
  final IconData? icon;
  final String? retryLabel;

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
              Container(
                width: spacing.x3l,
                height: spacing.x3l,
                decoration: BoxDecoration(
                  color: colors.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? LucideIcons.circleAlert,
                  size: spacing.xl,
                  color: colors.error,
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
              if (onRetry != null) ...[
                SizedBox(height: spacing.lg),
                CKButton.outline(
                  onPressed: onRetry,
                  child: Text(retryLabel ?? 'Try again'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKErrorState] instead.
@Deprecated('Use CKErrorState instead')
typedef ckcoreerrorState = CKErrorState;
