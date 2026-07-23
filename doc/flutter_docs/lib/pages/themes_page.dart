import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

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
                'Theme files expose CkgocBrand, CkgocTheme, CkgocThemeData, and CkgocThemeResolver. In app code, the main public entry point is usually context.ckgocTheme via CkgocApp.',
            demo: _ThemesDemo(),
            code: '''
final activeTheme = context.ckgocTheme;
final resolved = CkgocThemeResolver.resolve(CkgocBrand.skyGo, Brightness.dark);
''',
            params: [
              DocParam(
                name: 'CkgocBrand',
                type: 'enum',
                description: 'Brand selector used for theme resolution.',
              ),
              DocParam(
                name: 'CkgocTheme',
                type: 'InheritedWidget surface',
                description: 'Makes CkgocThemeData available in the tree.',
              ),
              DocParam(
                name: 'CkgocThemeData',
                type: 'theme bundle',
                description:
                    'Holds foundation token families for the active brand.',
              ),
              DocParam(
                name: 'CkgocThemeResolver',
                type: 'resolver',
                description:
                    'Maps brand + brightness to a concrete theme bundle.',
              ),
            ],
            faqs: [
              DocFaq(
                question: 'When do I call CkgocThemeResolver directly?',
                answer:
                    'Mostly in tests, previews, or internal infrastructure. Typical app code just uses CkgocApp and context.ckgocTheme.',
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
    final theme = context.ckgocTheme;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        Chip(label: Text('brand: ${theme.brand.displayName}')),
        Chip(label: Text('primary: ${theme.colors.primary}')),
        Chip(label: Text('surface: ${theme.colors.surface}')),
      ],
    );
  }
}
