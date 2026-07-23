import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'Templates',
      subtitle: 'Coverage for lib/src/templates/* exported by templates.dart.',
      children: [
        DocSection(
          data: ComponentDocData(
            comingSoon: true,
            title: 'templates.dart exports',
            summary:
                'The templates barrel exports auth, CRUD, dashboard, and state templates. This docs app records the exported file coverage so users can discover packaged application scaffolds from one place.',
            demo: _TemplatesDemo(),
            code: '''
// Exported by templates.dart
// auth: login_template, register_template, forgot_password_template
// crud: list_template, create_template, edit_template, detail_template
// dashboard: dashboard_template
// states: loading_template, error_template, empty_template, offline_template
''',
            params: [
              DocParam(
                name: 'auth',
                type: 'template group',
                description: 'Authentication-oriented screens and flows.',
              ),
              DocParam(
                name: 'crud',
                type: 'template group',
                description: 'Create, read, update, and detail app scaffolds.',
              ),
              DocParam(
                name: 'dashboard',
                type: 'template group',
                description: 'Dashboard starter surface.',
              ),
              DocParam(
                name: 'states',
                type: 'template group',
                description:
                    'Loading, error, empty, and offline state layouts.',
              ),
            ],
            faqs: [
              DocFaq(
                question: 'Why are templates documented as groups here?',
                answer:
                    'Their public discovery point is templates.dart. This app highlights exported coverage while keeping focus on the component system that those templates compose.',
              ),
              DocFaq(
                question: 'How should I use a template?',
                answer:
                    'Treat it as an application starting point, then replace copy, data wiring, and feature-specific layouts with your product requirements.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TemplatesDemo extends StatelessWidget {
  const _TemplatesDemo();

  @override
  Widget build(BuildContext context) {
    const groups = {
      'Auth': [
        'login_template.dart',
        'register_template.dart',
        'forgot_password_template.dart',
      ],
      'CRUD': [
        'list_template.dart',
        'create_template.dart',
        'edit_template.dart',
        'detail_template.dart',
      ],
      'Dashboard': ['dashboard_template.dart'],
      'States': [
        'loading_template.dart',
        'error_template.dart',
        'empty_template.dart',
        'offline_template.dart',
      ],
    };

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final entry in groups.entries)
          Container(
            width: 280,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const VSpace(height: 8),
                    for (final file in entry.value) Text('• $file'),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
