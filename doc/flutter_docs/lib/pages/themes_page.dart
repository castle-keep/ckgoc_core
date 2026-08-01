import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'Themes',
      subtitle:
          'Coverage for lib/src/themes/* including brand resolution, theme access, and token lookup.',
      children: [
        DocSection(
          data: ComponentDocData(
            title: 'Theme access and resolution',
            summary:
                'Access design tokens via context extensions (context.ckColors, context.ckSpacing) or static accessors (CKColors.of(context)). Theme resolution is handled automatically by ckcoreTheme, ckcoreThemeData, and ckcoreThemeResolver.',
            demo: _ThemesDemo(),
            code: '''
// New ergonomic patterns (recommended):
Container(color: context.ckColors.primary)
SizedBox(width: context.ckSpacing.md)
Text('Hello', style: context.ckTypography.textMd)

// Or explicit static accessors:
CKColors.of(context).primary
CKSpacing.of(context).md

// Legacy pattern still works:
final activeTheme = context.ckcoreTheme;
final resolved = ckcoreThemeResolver.resolve(ckcoreBrand.skyGo, Brightness.dark);
''',
            params: [
              DocParam(
                name: 'ckcoreBrand',
                type: 'enum',
                description: 'Brand selector used for theme resolution.',
              ),
              DocParam(
                name: 'ckcoreTheme',
                type: 'InheritedWidget surface',
                description: 'Makes ckcoreThemeData available in the tree.',
              ),
              DocParam(
                name: 'ckcoreThemeData',
                type: 'theme bundle',
                description:
                    'Holds foundation token families for the active brand.',
              ),
              DocParam(
                name: 'ckcoreThemeResolver',
                type: 'resolver',
                description:
                    'Maps brand + brightness to a concrete theme bundle.',
              ),
            ],
            faqs: [
              DocFaq(
                question: 'When do I call ckcoreThemeResolver directly?',
                answer:
                    'Mostly in tests, previews, or internal infrastructure. Typical app code just uses ckcoreApp and context.ckcoreTheme.',
              ),
              DocFaq(
                question: 'Where do the brand-specific theme files live?',
                answer:
                    'Under lib/src/themes/brands for CastleKeep and SkyGo light/dark token implementations.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemesDemo extends StatelessWidget {
  const _ThemesDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: context.ckSpacing.md,
          runSpacing: context.ckSpacing.md,
          children: [
            Chip(
                label: Text('brand: ${context.ckcoreTheme.brand.displayName}')),
            Chip(label: Text('primary: ${context.ckColors.primary}')),
            Chip(label: Text('surface: ${context.ckColors.surface}')),
            Chip(label: Text('spacing.md: ${context.ckSpacing.md}px')),
          ],
        ),
        SizedBox(height: context.ckSpacing.lg),
        Container(
          padding: EdgeInsets.all(context.ckSpacing.md),
          decoration: BoxDecoration(
            color: context.ckColors.surfaceVariant,
            borderRadius: BorderRadius.circular(context.ckRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Using new ergonomic patterns:',
                style: context.ckTypography.labelMd,
              ),
              SizedBox(height: context.ckSpacing.sm),
              Text(
                'context.ckColors.primary',
                style: context.ckTypography.textSm,
              ),
              Text(
                'context.ckSpacing.md',
                style: context.ckTypography.textSm,
              ),
              Text(
                'context.ckTypography.labelMd',
                style: context.ckTypography.textSm,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
