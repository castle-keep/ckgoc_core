import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Card component with optional media, action and variant styling.
class CKCard extends StatelessWidget {
  const CKCard({
    required this.title,
    this.subtitle,
    this.description,
    this.media,
    this.action,
    this.trailing,
    this.mediaAlignment = ContentAlignment.center,
    this.trailingAlignment = ContentAlignment.center,
    this.elevated = false,
    this.layout = CardLayout.vertical,
    this.variant = CardVariant.defaultCard,
    this.onTap,
    super.key,
  });
  final String title;
  final String? subtitle;
  final String? description;

  final Widget? media;

  final Widget? action;

  final Widget? trailing;

  final ContentAlignment mediaAlignment;
  final ContentAlignment trailingAlignment;
  final bool elevated;
  final CardLayout layout;
  final CardVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final shadows = theme.shadows;
    final opacity = theme.opacity;

    final isTinted = variant != CardVariant.defaultCard;

    final (bgColor, fgColor, accentColor, variantIcon) = switch (variant) {
      CardVariant.success => (
        colors.successContainer,
        colors.onSuccessContainer,
        colors.success,
        LucideIcons.checkCircle,
      ),
      CardVariant.warning => (
        colors.warningContainer,
        colors.onWarningContainer,
        colors.warning,
        LucideIcons.alertTriangle,
      ),
      CardVariant.error => (
        colors.errorContainer,
        colors.onErrorContainer,
        colors.error,
        LucideIcons.xCircle,
      ),
      CardVariant.info => (
        colors.infoContainer,
        colors.onInfoContainer,
        colors.info,
        LucideIcons.info,
      ),
      CardVariant.defaultCard => (
        colors.surface,
        colors.onSurface,
        colors.primary,
        null,
      ),
    };

    final cardDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius.lg),
      border: Border.all(color: colors.outlineVariant),
      // Apply small shadow when explicitly elevated or when not using a
      // tinted variant (matches CKContainer's `elevated` behavior).
      boxShadow: (elevated || !isTinted) ? shadows.sm : null,
    );

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (variantIcon != null) ...[
              Icon(variantIcon, size: spacing.md, color: accentColor),
              SizedBox(width: spacing.xs),
            ],
            Expanded(
              child: Text(
                title,
                style: typography.labelLg.copyWith(color: fgColor),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: spacing.xs),
              Align(
                alignment: switch (trailingAlignment) {
                  ContentAlignment.top => Alignment.topCenter,
                  ContentAlignment.center => Alignment.center,
                  ContentAlignment.bottom => Alignment.bottomCenter,
                  ContentAlignment.stretch => Alignment.center,
                },
                child: trailing!,
              ),
            ],
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: spacing.xxs),
          Text(
            subtitle!,
            style: typography.textSm.copyWith(
              color: fgColor.withValues(alpha: opacity.muted),
            ),
          ),
        ],
        if (description != null) ...[
          SizedBox(height: spacing.xs),
          Text(
            description!,
            style: typography.textSm.copyWith(
              color: fgColor.withValues(alpha: 0.85),
            ),
          ),
        ],
        if (action != null) ...[SizedBox(height: spacing.sm), action!],
      ],
    );

    Widget body;

    if (layout == CardLayout.horizontal && media != null) {
      // Map ContentAlignment to Row crossAxisAlignment and Align alignment
      final cross = switch (mediaAlignment) {
        ContentAlignment.top => CrossAxisAlignment.start,
        ContentAlignment.center => CrossAxisAlignment.center,
        ContentAlignment.bottom => CrossAxisAlignment.end,
        ContentAlignment.stretch => CrossAxisAlignment.stretch,
      };

      final align = switch (mediaAlignment) {
        ContentAlignment.top => Alignment.topCenter,
        ContentAlignment.center => Alignment.center,
        ContentAlignment.bottom => Alignment.bottomCenter,
        ContentAlignment.stretch => Alignment.center,
      };

      body = Row(
        crossAxisAlignment: cross,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius.lg),
              bottomLeft: Radius.circular(radius.lg),
            ),
            child: Align(alignment: align, child: media!),
          ),
          Expanded(
            child: Padding(padding: EdgeInsets.all(spacing.md), child: content),
          ),
        ],
      );
    } else if (layout == CardLayout.vertical && media != null) {
      // For vertical layout interpret top/center/bottom as start/center/end
      final align = switch (mediaAlignment) {
        ContentAlignment.top => Alignment.centerLeft,
        ContentAlignment.center => Alignment.center,
        ContentAlignment.bottom => Alignment.centerRight,
        ContentAlignment.stretch => Alignment.center,
      };

      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius.lg),
              topRight: Radius.circular(radius.lg),
            ),
            child: Align(alignment: align, child: media!),
          ),
          Padding(padding: EdgeInsets.all(spacing.md), child: content),
        ],
      );
    } else {
      body = Padding(padding: EdgeInsets.all(spacing.md), child: content);
    }

    final card = DecoratedBox(decoration: cardDecoration, child: body);

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius.lg),
      child: card,
    );
  }
}

/// Deprecated: Use [CKCard] instead.
@Deprecated('Use CKCard instead')
typedef ckcorecard = CKCard;
