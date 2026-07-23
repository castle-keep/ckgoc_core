import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    return DocsScaffold(
      title: 'Foundation Tokens',
      subtitle:
          'Coverage for lib/src/foundation/* token families exported by foundation.dart.',
      children: [
        DocSection(
          data: ComponentDocData(
            title: 'foundation.dart exports',
            summary:
                'The foundation barrel exports colors, typography, spacing, radius, elevation, shadows, motion, opacity, and breakpoints. These are read from context.ckgocTheme and used by every component in the package.',
            demo: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _TokenCard(
                  title: 'Colors',
                  body:
                      'primary: ${theme.colors.primary}\nsurface: ${theme.colors.surface}\nerror: ${theme.colors.error}',
                ),
                _TokenCard(
                  title: 'Spacing',
                  body:
                      'xs: ${theme.spacing.xs}\nmd: ${theme.spacing.md}\nxl: ${theme.spacing.xl}',
                ),
                _TokenCard(
                  title: 'Radius',
                  body:
                      'sm: ${theme.radius.sm}\nbase: ${theme.radius.base}\nfull: ${theme.radius.full}',
                ),
                _TokenCard(
                  title: 'Opacity',
                  body:
                      'disabled: ${theme.opacity.disabled}\nhover: ${theme.opacity.hover}\nfull: ${theme.opacity.full}',
                ),
                _TokenCard(
                  title: 'Breakpoints',
                  body:
                      'sm: ${theme.breakpoints.sm}\nmd: ${theme.breakpoints.md}\nlg: ${theme.breakpoints.lg}',
                ),
              ],
            ),
            code: '''
final theme = context.ckgocTheme;
final colors = theme.colors;
final spacing = theme.spacing;
final radius = theme.radius;
''',
            params: const [
              DocParam(
                name: 'colors',
                type: 'CkgocColors',
                description:
                    'Semantic color tokens for surfaces, text, states, and accents.',
              ),
              DocParam(
                name: 'typography',
                type: 'CkgocTypography',
                description: 'Text styles for display, labels, and body copy.',
              ),
              DocParam(
                name: 'spacing',
                type: 'CkgocSpacing',
                description:
                    'Spacing scale used throughout layout and controls.',
              ),
              DocParam(
                name: 'radius',
                type: 'CkgocRadius',
                description: 'Corner radii tokens.',
              ),
              DocParam(
                name: 'elevation',
                type: 'CkgocElevation',
                description: 'Elevation depth tokens.',
              ),
              DocParam(
                name: 'shadows',
                type: 'CkgocShadows',
                description: 'Box-shadow presets.',
              ),
              DocParam(
                name: 'motion',
                type: 'CkgocMotion',
                description: 'Durations and curves.',
              ),
              DocParam(
                name: 'opacity',
                type: 'CkgocOpacity',
                description: 'Opacity scale for interaction states.',
              ),
              DocParam(
                name: 'breakpoints',
                type: 'CkgocBreakpoints',
                description: 'Responsive width thresholds.',
              ),
            ],
            faqs: const [
              DocFaq(
                question: 'Should app code use raw colors and numbers?',
                answer:
                    'Prefer theme tokens so app surfaces stay aligned with the selected brand and can evolve without rewriting every component.',
              ),
              DocFaq(
                question: 'Where do these tokens come from?',
                answer:
                    'They are assembled into CkgocThemeData by the brand theme resolver.',
              ),
            ],
          ),
        ),
        const DocSection(
          data: ComponentDocData(
            title: 'All theme colors',
            summary:
                'Visual reference of every semantic color token exposed by CkgocColors.',
            demo: _ColorSwatchGrid(),
            code: '''
final colors = context.ckgocTheme.colors;
// Inspect colors.primary, colors.surface, etc.
''',
            params: [],
            faqs: [],
          ),
        ),
        const DocSection(
          data: ComponentDocData(
            title: 'Typography samples',
            summary:
                'Shows every text style from CkgocTypography with a sample line and metadata.',
            demo: _TypographySamples(),
            code: '''
final t = context.ckgocTheme.typography;
// Use t.displayLg, t.textMd, t.labelSm etc.
''',
            params: [],
            faqs: [],
          ),
        ),
      ],
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const VSpace(height: 8),
              SelectableText(body),
            ],
          ),
        ),
      ),
    );
  }
}

// Displays a grid of all semantic color tokens from CkgocColors.
class _ColorSwatchGrid extends StatelessWidget {
  const _ColorSwatchGrid();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;

    final items = <MapEntry<String, Color>>[
      MapEntry('primary', colors.primary),
      MapEntry('primaryHover', colors.primaryHover),
      MapEntry('primaryActive', colors.primaryActive),
      MapEntry('primaryDisabled', colors.primaryDisabled),
      MapEntry('onPrimary', colors.onPrimary),
      MapEntry('secondary', colors.secondary),
      MapEntry('secondaryHover', colors.secondaryHover),
      MapEntry('secondaryActive', colors.secondaryActive),
      MapEntry('onSecondary', colors.onSecondary),
      MapEntry('accent', colors.accent),
      MapEntry('onAccent', colors.onAccent),
      MapEntry('background', colors.background),
      MapEntry('surface', colors.surface),
      MapEntry('surfaceVariant', colors.surfaceVariant),
      MapEntry('surfaceElevated', colors.surfaceElevated),
      MapEntry('inverseSurface', colors.inverseSurface),
      MapEntry('onBackground', colors.onBackground),
      MapEntry('onSurface', colors.onSurface),
      MapEntry('onSurfaceVariant', colors.onSurfaceVariant),
      MapEntry('onInverseSurface', colors.onInverseSurface),
      MapEntry('outline', colors.outline),
      MapEntry('outlineVariant', colors.outlineVariant),
      MapEntry('error', colors.error),
      MapEntry('errorContainer', colors.errorContainer),
      MapEntry('onError', colors.onError),
      MapEntry('onErrorContainer', colors.onErrorContainer),
      MapEntry('success', colors.success),
      MapEntry('successContainer', colors.successContainer),
      MapEntry('onSuccess', colors.onSuccess),
      MapEntry('onSuccessContainer', colors.onSuccessContainer),
      MapEntry('warning', colors.warning),
      MapEntry('warningContainer', colors.warningContainer),
      MapEntry('onWarning', colors.onWarning),
      MapEntry('onWarningContainer', colors.onWarningContainer),
      MapEntry('info', colors.info),
      MapEntry('infoContainer', colors.infoContainer),
      MapEntry('onInfo', colors.onInfo),
      MapEntry('onInfoContainer', colors.onInfoContainer),
      MapEntry('neutral', colors.neutral),
      MapEntry('neutralVariant', colors.neutralVariant),
      MapEntry('shadow', colors.shadow),
      MapEntry('scrim', colors.scrim),
      MapEntry('ring', colors.ring),
      MapEntry('muted', colors.muted),
      MapEntry('onMuted', colors.onMuted),
      MapEntry('tagLive', colors.tagLive),
      MapEntry('onTagLive', colors.onTagLive),
      MapEntry('tagNew', colors.tagNew),
      MapEntry('onTagNew', colors.onTagNew),
      MapEntry('tagBeta', colors.tagBeta),
      MapEntry('onTagBeta', colors.onTagBeta),
      MapEntry('tagProStart', colors.tagProStart),
      MapEntry('tagProEnd', colors.tagProEnd),
      MapEntry('onTagPro', colors.onTagPro),
    ];

    return CkgocContainer(
      elevated: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('All Colors', style: theme.typography.labelXl),
            const VSpace(height: 12),
            GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: items.map((entry) {
                final name = entry.key;
                final color = entry.value;
                final hex = color
                    .toString()
                    .replaceAll('Color(0x', '#')
                    .replaceAll(')', '')
                    .toUpperCase();
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: theme.colors.outline),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(name, style: theme.typography.labelSm),
                            const VSpace(height: 6),
                            Text(hex, style: theme.typography.codeMd),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Shows sample lines for every typography style in CkgocTypography.
class _TypographySamples extends StatelessWidget {
  const _TypographySamples();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final t = theme.typography;

    final samples = <MapEntry<String, TextStyle>>[
      MapEntry('display2xl', t.display2xl),
      MapEntry('displayXl', t.displayXl),
      MapEntry('displayLg', t.displayLg),
      MapEntry('displayMd', t.displayMd),
      MapEntry('displaySm', t.displaySm),
      MapEntry('textXl', t.textXl),
      MapEntry('textLg', t.textLg),
      MapEntry('textMd', t.textMd),
      MapEntry('textSm', t.textSm),
      MapEntry('textXs', t.textXs),
      MapEntry('labelXl', t.labelXl),
      MapEntry('labelLg', t.labelLg),
      MapEntry('labelMd', t.labelMd),
      MapEntry('labelSm', t.labelSm),
      MapEntry('codeMd', t.codeMd),
    ];

    return CkgocContainer(
      elevated: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Typography', style: theme.typography.labelXl),
            const VSpace(height: 12),
            for (final s in samples) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.key, style: theme.typography.labelSm),
                    const VSpace(height: 6),
                    Text(
                      'The quick brown fox jumps over the lazy dog',
                      style: s.value,
                    ),
                    const VSpace(height: 6),
                    Text(
                      'fontSize: ${s.value.fontSize ?? '-'} • weight: ${s.value.fontWeight ?? '-'} • style: ${s.value.fontStyle ?? '-'}',
                      style: theme.typography.textSm,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
