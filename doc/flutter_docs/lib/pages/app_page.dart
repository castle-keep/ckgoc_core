import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'App Wrapper',
      subtitle: 'Coverage for lib/src/app/ckgoc_app.dart.',
      children: [
        DocSection(
          data: ComponentDocData(
            title: 'CkgocApp',
            summary:
                'Root wrapper that injects a resolved CkgocThemeData into the subtree for the selected brand and brightness.',
            demo: _AppDemo(),
            code: '''
CkgocApp(
  brand: CkgocBrand.castleKeep,
  brightness: Brightness.light,
  child: MaterialApp(home: HomePage()),
)
''',
            params: [
              DocParam(
                name: 'brand',
                type: 'CkgocBrand',
                description: 'Brand whose theme should be resolved.',
                requiredParam: true,
              ),
              DocParam(
                name: 'child',
                type: 'Widget',
                description: 'Wrapped application subtree.',
                requiredParam: true,
              ),
              DocParam(
                name: 'brightness',
                type: 'Brightness?',
                description:
                    'Optional explicit brightness override. If null, device brightness is used.',
              ),
            ],
            faqs: [
              DocFaq(
                question:
                    'Why use CkgocApp instead of accessing theme data manually?',
                answer:
                    'It centralizes brand + brightness resolution and provides a consistent way for all child widgets to read context.ckgocTheme.',
              ),
              DocFaq(
                question: 'Can I nest CkgocApp?',
                answer:
                    'Usually no. Treat it as the root injector for your app shell.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppDemo extends StatelessWidget {
  const _AppDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final brand in CkgocBrand.values)
          Chip(label: Text('brand: ${brand.displayName}')),
      ],
    );
  }
}
