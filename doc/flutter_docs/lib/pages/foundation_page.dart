import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocsScaffold(
      title: 'Foundation Tokens',
      subtitle:
          'Coverage for lib/src/foundation/* token families exported by foundation.dart.',
      children: [
        DocSection(
          data: ComponentDocData(
            title: 'foundation.dart exports',
            summary:
                'The foundation barrel exports colors, typography, spacing, radius, elevation, shadows, motion, opacity, and breakpoints. These are read from context.ckcoreTheme and used by every component in the package.',
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
final theme = context.ckcoreTheme;
final colors = theme.colors;
final spacing = theme.spacing;
final radius = theme.radius;
''',
            params: const [
              DocParam(
                name: 'colors',
                type: 'ckcoreColors',
                description:
                    'Semantic color tokens for surfaces, text, states, and accents.',
              ),
              DocParam(
                name: 'typography',
                type: 'ckcoreTypography',
                description: 'Text styles for display, labels, and body copy.',
              ),
              DocParam(
                name: 'spacing',
                type: 'ckcoreSpacing',
                description:
                    'Spacing scale used throughout layout and controls.',
              ),
              DocParam(
                name: 'radius',
                type: 'ckcoreRadius',
                description: 'Corner radii tokens.',
              ),
              DocParam(
                name: 'elevation',
                type: 'ckcoreElevation',
                description: 'Elevation depth tokens.',
              ),
              DocParam(
                name: 'shadows',
                type: 'ckcoreShadows',
                description: 'Box-shadow presets.',
              ),
              DocParam(
                name: 'motion',
                type: 'ckcoreMotion',
                description: 'Durations and curves.',
              ),
              DocParam(
                name: 'opacity',
                type: 'ckcoreOpacity',
                description: 'Opacity scale for interaction states.',
              ),
              DocParam(
                name: 'breakpoints',
                type: 'ckcoreBreakpoints',
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
                    'They are assembled into ckcoreThemeData by the brand theme resolver.',
              ),
            ],
          ),
        ),
        const DocSection(
          data: ComponentDocData(
            title: 'All theme colors',
            summary:
                'Visual reference of every semantic color token exposed by ckcoreColors.',
            demo: _ColorSwatchGrid(),
            code: '''
final colors = context.ckcoreTheme.colors;
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
                'Shows every text style from ckcoreTypography with a sample line and metadata.',
            demo: _TypographySamples(),
            code: '''
final t = context.ckcoreTheme.typography;
// Use t.displayLg, t.textMd, t.labelSm etc.
''',
            params: [],
            faqs: [],
          ),
        ),
        const DocSection(
          data: ComponentDocData(
            title: 'Semantic heading shortcuts',
            summary:
                'Use .h1 through .h6 extensions for semantic HTML-style headings with automatic typography scaling.',
            demo: _HeadingShortcuts(),
            code: '''
// Semantic heading shortcuts (h1-h6) map to typography scale
Text('Page Title').h1        // display2xl (32px, Bold)
Text('Section').h2           // displayXl (28px, Bold)
Text('Subsection').h3        // displayLg (24px, Bold)
Text('Card Title').h4        // displayMd (20px, Bold)
Text('Label').h5             // displaySm (18px, Medium)
Text('Secondary').h6         // textXl (20px, Regular)
''',
            params: [],
            faqs: [],
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Text extension examples',
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: 8),
                Builder(
                  builder: (ctx) {
                    final t = ctx.ckcoreTheme;
                    return Text(
                      'Bold primary',
                      style: t.typography.textMd.copyWith(
                        fontWeight: FontWeight.bold,
                        color: t.colors.primary,
                      ),
                    );
                  },
                ),
                SizedBox(height: 6),
                Builder(
                  builder: (ctx) {
                    final t = ctx.ckcoreTheme;
                    return Text(
                      'Italic error',
                      style: t.typography.textMd.copyWith(
                        fontStyle: FontStyle.italic,
                        color: t.colors.error,
                      ),
                    );
                  },
                ),
                SizedBox(height: 6),
                Builder(
                  builder: (ctx) {
                    final t = ctx.ckcoreTheme;
                    return Text(
                      'Code monospace on primary',
                      style:
                          t.typography.codeMd.copyWith(color: t.colors.primary),
                    );
                  },
                ),
                SizedBox(height: 6),
                Text('Blockquote example: Use .blockQuote for semantic quoting.')
                    .blockQuote,
              ],
            ),
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

// Displays a grid of all semantic color tokens from ckcoreColors.
class _ColorSwatchGrid extends StatelessWidget {
  const _ColorSwatchGrid();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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

    return CKContainer(
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

// Shows sample lines for every typography style in ckcoreTypography.
class _TypographySamples extends StatelessWidget {
  const _TypographySamples();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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

    return CKContainer(
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

// Demonstrates semantic heading shortcuts (.h1 through .h6)
class _HeadingShortcuts extends StatelessWidget {
  const _HeadingShortcuts();

  @override
  Widget build(BuildContext context) {
    return CKContainer(
      elevated: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Semantic Heading Shortcuts',
                style: context.ckcoreTheme.typography.labelXl),
            const VSpace(height: 12),
            Text('Page Title').h1,
            const VSpace(height: 8),
            Text('Heading h1').primary,
            const VSpace(height: 16),
            Text('Section').h2,
            const VSpace(height: 8),
            Text('Heading h2').primary,
            const VSpace(height: 16),
            Text('Subsection').h3,
            const VSpace(height: 8),
            Text('Heading h3').primary,
            const VSpace(height: 16),
            Text('Card Title').h4,
            const VSpace(height: 8),
            Text('Heading h4').primary,
            const VSpace(height: 16),
            Text('Label').h5,
            const VSpace(height: 8),
            Text('Heading h5').primary,
            const VSpace(height: 16),
            Text('Secondary').h6,
            const VSpace(height: 8),
            Text('Heading h6').primary,
          ],
        ),
      ),
    );
  }
}
