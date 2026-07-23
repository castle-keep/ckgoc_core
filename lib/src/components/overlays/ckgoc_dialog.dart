import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckgoc_core/src/foundation/foundation.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/buttons/ckgoc_button.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

/// Dialog widget with convenience `show` and `showDestructive` helpers.
class CkgocDialog extends StatelessWidget {
  const CkgocDialog.destructive({
    required this.content,
    this.title,
    this.confirmLabel = 'Yes, Delete Permanently',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.showClose = false,
    IconData? icon,
    super.key,
  }) : _destructive = true,
       _icon = icon;

  const CkgocDialog({
    required this.content,
    this.title,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.showClose = true,
    super.key,
  }) : _destructive = false,
       _icon = null;
  final String? title;
  final Widget content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showClose;
  final bool _destructive;
  final IconData? _icon;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CkgocDialog(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  static Future<T?> showDestructive<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    String confirmLabel = 'Yes, Delete Permanently',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CkgocDialog.destructive(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;
    final shadows = theme.shadows;
    final breakpoints = theme.breakpoints;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: breakpoints.sm),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(radius.xl),
            boxShadow: shadows.xl,
          ),
          child: _destructive
              ? _buildDestructive(context, colors, spacing, typography, radius)
              : _buildDefault(context, colors, spacing, typography, radius),
        ),
      ),
    );
  }

  Widget _buildDefault(
    BuildContext context,
    CkgocColors colors,
    CkgocSpacing spacing,
    CkgocTypography typography,
    CkgocRadius radius,
  ) {
    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: typography.labelLg.copyWith(color: colors.onSurface),
                  ),
                ),
              if (showClose)
                InkWell(
                  onTap: onCancel ?? () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(radius.base),
                  child: Padding(
                    padding: EdgeInsets.all(spacing.xs),

                    child: Icon(
                      LucideIcons.x,
                      size: spacing.md + spacing.xxs,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          if (title != null) SizedBox(height: spacing.sm),
          DefaultTextStyle(
            style: typography.textSm.copyWith(color: colors.onSurfaceVariant),
            child: content,
          ),
          SizedBox(height: spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CkgocButton(
                variant: ButtonVariant.outline,
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                child: Text(cancelLabel),
              ),
              SizedBox(width: spacing.sm),
              CkgocButton(
                variant: ButtonVariant.primary,
                onPressed: onConfirm,
                child: Text(confirmLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDestructive(
    BuildContext context,
    CkgocColors colors,
    CkgocSpacing spacing,
    CkgocTypography typography,
    CkgocRadius radius,
  ) {
    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: spacing.x2l + spacing.sm,
            height: spacing.x2l + spacing.sm,
            decoration: BoxDecoration(
              color: colors.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _icon ?? LucideIcons.trash2,
              size: spacing.lg,
              color: colors.error,
            ),
          ),
          SizedBox(height: spacing.md),
          if (title != null) ...[
            Text(
              title!,
              style: typography.labelLg.copyWith(color: colors.onSurface),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing.xs),
          ],
          DefaultTextStyle(
            style: typography.textSm.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
            child: content,
          ),
          SizedBox(height: spacing.lg),
          SizedBox(
            width: double.infinity,
            child: CkgocButton(
              variant: ButtonVariant.destructive,
              isFullWidth: true,
              onPressed: onConfirm,
              child: Text(confirmLabel),
            ),
          ),
          SizedBox(height: spacing.sm),
          CkgocButton(
            variant: ButtonVariant.ghost,
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(cancelLabel),
          ),
        ],
      ),
    );
  }
}
