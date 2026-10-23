import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Width below which the header drops text labels and secondary links.
const _compactWidth = 760.0;

/// Width below which the wordmark is hidden as well.
const _tinyWidth = 520.0;

/// Top bar of the docs app: identity on the left, theme controls and links on
/// the right. Brand and light/dark/system are one-click segmented controls.
class DocsHeader extends StatelessWidget {
  const DocsHeader({
    required this.brand,
    required this.brightness,
    required this.onBrandChanged,
    required this.onBrightnessChanged,
    super.key,
  });

  final ckcoreBrand brand;

  /// `null` follows the system setting.
  final Brightness? brightness;
  final ValueChanged<ckcoreBrand> onBrandChanged;
  final ValueChanged<Brightness?> onBrightnessChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < _compactWidth;
        final tiny = constraints.maxWidth < _tinyWidth;

        return Material(
          color: colors.surface,
          child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: spacing.md),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.outline)),
            ),
            child: Row(
              children: [
                BrandIcon.brandLogoWidget(
                  context,
                  brand,
                  size: 28,
                  variant: BrandIconVariant.logo,
                ),
                if (!tiny) SizedBox(width: spacing.sm),
                if (!tiny) Text('ckcoreui', style: theme.typography.labelLg),
                if (!compact) ...[
                  SizedBox(width: spacing.xs),
                  Text(
                    'docs',
                    style: theme.typography.textMd.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
                const Spacer(),
                SegmentedToggle<ckcoreBrand>(
                  semanticLabel: 'Brand',
                  value: brand,
                  onChanged: onBrandChanged,
                  compact: compact,
                  iconsOnly: tiny,
                  segments: [
                    for (final b in ckcoreBrand.values)
                      ToggleSegment(
                        value: b,
                        label: b.displayName,
                        tooltip: 'Use the ${b.displayName} brand',
                        leading: _BrandDot(brand: b),
                      ),
                  ],
                ),
                SizedBox(width: spacing.sm),
                SegmentedToggle<Brightness?>(
                  semanticLabel: 'Color mode',
                  value: brightness,
                  onChanged: onBrightnessChanged,
                  compact: compact,
                  segments: const [
                    ToggleSegment(
                      value: null,
                      label: 'System',
                      icon: Icons.brightness_auto_outlined,
                      tooltip: 'Follow the system light/dark setting',
                    ),
                    ToggleSegment(
                      value: Brightness.light,
                      label: 'Light',
                      icon: Icons.light_mode_outlined,
                      tooltip: 'Light mode',
                    ),
                    ToggleSegment(
                      value: Brightness.dark,
                      label: 'Dark',
                      icon: Icons.dark_mode_outlined,
                      tooltip: 'Dark mode',
                    ),
                  ],
                ),
                if (!compact) ...[
                  SizedBox(width: spacing.sm),
                  CKIconButton(
                    icon: Icons.inventory_2_outlined,
                    tooltip: 'ckcoreui on pub.dev',
                    onPressed: () =>
                        launchUrl(Uri.parse('https://pub.dev/packages/ckcoreui')),
                  ),
                  CKIconButton(
                    icon: Icons.code,
                    tooltip: 'GitHub repository',
                    onPressed: () => launchUrl(
                      Uri.parse('https://github.com/castle-keep/ckgoc_core'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Small swatch showing a brand's primary colour.
class _BrandDot extends StatelessWidget {
  const _BrandDot({required this.brand});
  final ckcoreBrand brand;

  @override
  Widget build(BuildContext context) {
    final color = ckcoreThemeResolver.resolve(brand, Brightness.light).colors.primary;
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.ckColors.outline.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

/// One option of a [SegmentedToggle].
class ToggleSegment<T> {
  const ToggleSegment({
    required this.value,
    required this.label,
    this.icon,
    this.leading,
    this.tooltip,
  });
  final T value;
  final String label;
  final IconData? icon;

  /// Custom leading widget (shown instead of [icon]).
  final Widget? leading;
  final String? tooltip;
}

/// Pill-shaped single-choice control. The selected segment is raised and
/// every segment is reachable by keyboard.
///
/// In [compact] mode segments with an icon drop their text label, and
/// segments with only a leading widget keep the label just for the selected one.
class SegmentedToggle<T> extends StatelessWidget {
  const SegmentedToggle({
    required this.segments,
    required this.value,
    required this.onChanged,
    this.compact = false,
    this.iconsOnly = false,
    this.semanticLabel,
    super.key,
  });

  final List<ToggleSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;
  final bool compact;

  /// Hide every text label (segments need an icon or leading widget).
  final bool iconsOnly;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        padding: EdgeInsets.all(spacing.xxs + 1),
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(theme.radius.md + 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final segment in segments)
              _SegmentButton<T>(
                segment: segment,
                selected: segment.value == value,
                compact: compact,
                iconsOnly: iconsOnly,
                onTap: () => onChanged(segment.value),
              ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton<T> extends StatelessWidget {
  const _SegmentButton({
    required this.segment,
    required this.selected,
    required this.compact,
    required this.iconsOnly,
    required this.onTap,
  });

  final ToggleSegment<T> segment;
  final bool selected;
  final bool compact;
  final bool iconsOnly;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final color = selected ? colors.onSurface : colors.onSurfaceVariant;

    final hasVisual = segment.icon != null || segment.leading != null;
    final hideLabel = hasVisual &&
        (iconsOnly ||
            (compact && (segment.icon != null || !selected)));
    final leading = segment.leading ??
        (segment.icon != null
            ? Icon(segment.icon, size: 16, color: color)
            : null);

    final radius = BorderRadius.circular(theme.radius.md);

    return Semantics(
      button: true,
      selected: selected,
      label: segment.label,
      excludeSemantics: true,
      onTap: onTap,
      child: Tooltip(
        message: segment.tooltip ?? segment.label,
        waitDuration: const Duration(milliseconds: 500),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: AnimatedContainer(
            duration: theme.motion.normal,
            curve: Curves.easeOutCubic,
            height: 32,
            padding: EdgeInsets.symmetric(
              horizontal: hideLabel ? spacing.s12 - 2 : spacing.s12,
            ),
            decoration: BoxDecoration(
              color: selected ? colors.surface : Colors.transparent,
              borderRadius: radius,
              boxShadow: selected ? theme.shadows.sm : const [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) leading,
                if (!hideLabel) ...[
                  if (leading != null) SizedBox(width: spacing.xs + 2),
                  Text(
                    segment.label,
                    style: theme.typography.labelMd.copyWith(color: color),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
