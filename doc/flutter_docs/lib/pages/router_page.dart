import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class RouterDocsPage extends StatelessWidget {
  const RouterDocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocsScaffold(
        title: 'Router',
        subtitle: 'Coverage for lib/src/app/ckcore_app.dart.',
        children: [
          Text('Overview', style: theme.typography.labelXl),
          SizedBox(height: theme.spacing.md),
          Text(
            'The docs app uses the Navigator 2.0 Router API via CKApp.router. '
            'This page explains how to migrate and shows a small live demo.',
            style: theme.typography.textMd,
          ),
          SizedBox(height: theme.spacing.lg),
          Text('Live Demo', style: theme.typography.labelXl),
          SizedBox(height: theme.spacing.md),
          _RouterLiveDemo(),
          SizedBox(height: theme.spacing.lg),
          Text('Usage', style: theme.typography.labelXl),
          SizedBox(height: theme.spacing.md),
          SelectableText(
            '''
// Use CKApp.router with a RouterConfig
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  brightness: Brightness.light,
  routerConfig: RouterConfig<Object>(
    routerDelegate: myDelegate,
    routeInformationParser: myParser,
  ),
  title: 'My App',
)
''',
            style: theme.typography.codeMd,
          ),
          SizedBox(height: theme.spacing.lg),
          Text('FAQs', style: theme.typography.labelXl),
          SizedBox(height: theme.spacing.md),
          _FaqItem(
            question: 'Why use CKApp.router?',
            answer:
                'CKApp.router keeps automatic theme resolution while enabling '
                'Navigator 2.0 features such as deep links and declarative routing.',
          ),
          _FaqItem(
            question: 'Can I mix Navigator 1.0 pushes?',
            answer:
                'You can use nested Navigators for local flows. The global Router controls top-level routing.',
          ),
          _FaqItem(
            question: 'How do I migrate from onGenerateRoute?',
            answer:
                'Move route-to-page mapping into a RouterDelegate and a RouteInformationParser, then provide them via RouterConfig.',
          ),
        ]);
  }
}

class _RouterLiveDemo extends StatefulWidget {
  @override
  State<_RouterLiveDemo> createState() => _RouterLiveDemoState();
}

class _RouterLiveDemoState extends State<_RouterLiveDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final pages = [
      _DemoPage(title: 'Demo: Home', color: theme.colors.primary),
      _DemoPage(title: 'Demo: Details', color: theme.colors.accent),
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 200, child: pages[_index]),
            SizedBox(height: theme.spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _index = 0),
                  child: const Text('Home'),
                ),
                SizedBox(width: theme.spacing.sm),
                ElevatedButton(
                  onPressed: () => setState(() => _index = 1),
                  child: const Text('Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Container(
      color: color.withValues(alpha: 0.08),
      alignment: Alignment.center,
      child: Text(title,
          style:
              theme.typography.labelLg.copyWith(color: theme.colors.onSurface)),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: theme.typography.labelLg
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: theme.spacing.xs),
          Text(answer, style: theme.typography.textMd),
        ],
      ),
    );
  }
}
