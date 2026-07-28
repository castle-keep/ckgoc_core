import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/foundation/foundation.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/buttons/ckcore_button.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Dialog widget with convenience `show` and `showDestructive` helpers.
class CKDialog extends StatelessWidget {
  const CKDialog.destructive({
    required this.content,
    this.title,
    this.confirmLabel = 'Yes, Delete Permanently',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.showClose = false,
    IconData? icon,
    this.maxWidth,
    this.maxHeight,
    this.confirmWidget,
    this.cancelWidget,
    super.key,
  }) : _destructive = true,
       _info = false,
       _icon = icon;

  CKDialog.info({
    required String text,
    this.title,
    this.confirmLabel = 'OK',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.showClose = true,
    this.maxWidth,
    this.maxHeight,
    this.confirmWidget,
    this.cancelWidget,
    super.key,
  }) : content = Text(text),
       _destructive = false,
       _info = true,
       _icon = LucideIcons.info;

  const CKDialog({
    required this.content,
    this.title,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.showClose = true,
    this.maxWidth,
    this.maxHeight,
    this.confirmWidget,
    this.cancelWidget,
    super.key,
  }) : _destructive = false,
       _info = false,
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
  final double? maxWidth;
  final double? maxHeight;
  final Widget? confirmWidget;
  final Widget? cancelWidget;
  final bool _info;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    double? maxWidth,
    double? maxHeight,
    Widget? confirmWidget,
    Widget? cancelWidget,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CKDialog(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        confirmWidget: confirmWidget,
        cancelWidget: cancelWidget,
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
    double? maxWidth,
    double? maxHeight,
    Widget? confirmWidget,
    Widget? cancelWidget,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CKDialog.destructive(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        icon: icon,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        confirmWidget: confirmWidget,
        cancelWidget: cancelWidget,
      ),
    );
  }

  static Future<T?> showInfoDialog<T>({
    required BuildContext context,
    required String text,
    String? title,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    double? maxWidth,
    double? maxHeight,
    Widget? confirmWidget,
    Widget? cancelWidget,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CKDialog.info(
        text: text,
        title: title,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        confirmWidget: confirmWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? breakpoints.sm,
          maxHeight: maxHeight ?? breakpoints.sm,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(radius.xl),
            boxShadow: shadows.xl,
          ),
          child: _info
              ? _buildInfo(context, colors, spacing, typography, radius)
              : _destructive
              ? _buildDestructive(context, colors, spacing, typography, radius)
              : _buildDefault(context, colors, spacing, typography, radius),
        ),
      ),
    );
  }

  Widget _buildInfo(
    BuildContext context,
    ckcoreColors colors,
    ckcoreSpacing spacing,
    ckcoreTypography typography,
    ckcoreRadius radius,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: spacing.x2l + spacing.sm,
                height: spacing.x2l + spacing.sm,
                decoration: BoxDecoration(
                  color: colors.infoContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icon ?? LucideIcons.info,
                  size: spacing.md,
                  color: colors.info,
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
            ],
          ),
        ),
        if (title != null)
          Divider(color: colors.outline, height: 0, thickness: 1),
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: typography.textSm.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                child: content,
              ),
              SizedBox(height: spacing.md),
              SizedBox(
                width: double.infinity,
                child: CKButton(
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                  child: confirmWidget ?? Text(confirmLabel),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefault(
    BuildContext context,
    ckcoreColors colors,
    ckcoreSpacing spacing,
    ckcoreTypography typography,
    ckcoreRadius radius,
  ) {
    final hasActions =
        onConfirm != null || cancelWidget != null || confirmWidget != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Row(
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
        ),

        if (title != null)
          Divider(color: colors.outline, height: 0, thickness: 1),

        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: DefaultTextStyle(
            style: typography.textSm.copyWith(color: colors.onSurfaceVariant),
            child: content,
          ),
        ),

        if (hasActions) ...[
          Divider(color: colors.outline, height: 0, thickness: 1),
          Padding(
            padding: EdgeInsets.all(spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CKButton(
                  variant: ButtonVariant.outline,
                  onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  child: cancelWidget ?? Text(cancelLabel),
                ),
                SizedBox(width: spacing.sm),
                CKButton(
                  variant: ButtonVariant.primary,
                  onPressed: onConfirm,
                  child: confirmWidget ?? Text(confirmLabel),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDestructive(
    BuildContext context,
    ckcoreColors colors,
    ckcoreSpacing spacing,
    ckcoreTypography typography,
    ckcoreRadius radius,
  ) {
    return Padding(
      padding: EdgeInsets.all(spacing.md),
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
              size: spacing.md,
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
          SizedBox(height: spacing.md),
          SizedBox(
            width: double.infinity,
            child: CKButton(
              variant: ButtonVariant.destructive,
              isFullWidth: true,
              onPressed: onConfirm,
              child: Text(confirmLabel),
            ),
          ),
          SizedBox(height: spacing.sm),
          CKButton(
            variant: ButtonVariant.ghost,
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(cancelLabel),
          ),
        ],
      ),
    );
  }
}
