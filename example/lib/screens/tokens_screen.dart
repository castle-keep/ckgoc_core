import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

// Displays the active theme's design tokens — colors, spacing, typography.
// Useful for verifying brand theme correctness at a glance.
class TokensScreen extends StatelessWidget {
  const TokensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${theme.brand.displayName} — ${theme.isDark ? "Dark" : "Light"}',
            style: theme.typography.displayMd,
          ),
          SizedBox(height: theme.spacing.lg),
          Text('Colors', style: theme.typography.displaySm),
          SizedBox(height: theme.spacing.md),
          _ColorGrid(theme: theme),
          SizedBox(height: theme.spacing.xl),
          Text('Typography', style: theme.typography.displaySm),
          SizedBox(height: theme.spacing.md),
          _TypographyList(theme: theme),
          SizedBox(height: theme.spacing.xl),
          Text('Spacing', style: theme.typography.displaySm),
          SizedBox(height: theme.spacing.md),
          _SpacingList(theme: theme),
        ],
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  final CkgocThemeData theme;
  const _ColorGrid({required this.theme});

  @override
  Widget build(BuildContext context) {
    final pairs = <(String, Color)>[
      ('primary', theme.colors.primary),
      ('onPrimary', theme.colors.onPrimary),
      ('secondary', theme.colors.secondary),
      ('accent', theme.colors.accent),
      ('background', theme.colors.background),
      ('surface', theme.colors.surface),
      ('surfaceVariant', theme.colors.surfaceVariant),
      ('onSurface', theme.colors.onSurface),
      ('outline', theme.colors.outline),
      ('error', theme.colors.error),
      ('success', theme.colors.success),
      ('warning', theme.colors.warning),
      ('info', theme.colors.info),
    ];
    return Wrap(
      spacing: theme.spacing.sm,
      runSpacing: theme.spacing.sm,
      children: pairs
          .map((p) => _ColorSwatch(label: p.$1, color: p.$2))
          .toList(),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String label;
  final Color color;
  const _ColorSwatch({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class _TypographyList extends StatelessWidget {
  final CkgocThemeData theme;
  const _TypographyList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('display-2xl  32sp Bold', style: theme.typography.display2xl),
        Text('display-xl   28sp Bold', style: theme.typography.displayXl),
        Text('display-lg   24sp Bold', style: theme.typography.displayLg),
        Text('display-md   20sp Bold', style: theme.typography.displayMd),
        Text('display-sm   18sp Medium', style: theme.typography.displaySm),
        Text(
          'text-xl      20sp Regular — The quick brown fox jumps over the lazy dog.',
          style: theme.typography.textXl,
        ),
        Text(
          'text-lg      18sp Regular — The quick brown fox jumps over the lazy dog.',
          style: theme.typography.textLg,
        ),
        Text(
          'text-md      16sp Regular — The quick brown fox jumps over the lazy dog.',
          style: theme.typography.textMd,
        ),
        Text(
          'text-sm      14sp Regular — The quick brown fox jumps over the lazy dog.',
          style: theme.typography.textSm,
        ),
        Text(
          'text-xs      12sp Regular — The quick brown fox',
          style: theme.typography.textXs,
        ),
        Text('label-xl     18sp Medium', style: theme.typography.labelXl),
        Text('label-lg     16sp Medium', style: theme.typography.labelLg),
        Text('label-md     14sp Medium', style: theme.typography.labelMd),
        Text('label-sm     12sp Medium', style: theme.typography.labelSm),
        Text('code-md      14sp  monospace', style: theme.typography.codeMd),
      ],
    );
  }
}

class _SpacingList extends StatelessWidget {
  final CkgocThemeData theme;
  const _SpacingList({required this.theme});

  @override
  Widget build(BuildContext context) {
    final pairs = <(String, double)>[
      ('none (0)', theme.spacing.none),
      ('xs (4)', theme.spacing.xs),
      ('sm (8)', theme.spacing.sm),
      ('s12 (12)', theme.spacing.s12),
      ('md (16)', theme.spacing.md),
      ('s20 (20)', theme.spacing.s20),
      ('lg (24)', theme.spacing.lg),
      ('xl (32)', theme.spacing.xl),
      ('s40 (40)', theme.spacing.s40),
      ('x2l (48)', theme.spacing.x2l),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pairs
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: p.$2,
                    height: 16,
                    color: theme.colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(p.$1, style: theme.typography.textXs),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
