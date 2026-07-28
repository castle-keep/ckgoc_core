import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class RouterDocsPage extends StatelessWidget {
  const RouterDocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Router',
      subtitle:
          'Coverage for lib/src/app/ckcore_app.dart and Navigator 2.0 routing.',
      children: [
        DocSection(data: _cKAppRouterDoc()),
      ],
    );
  }
}

ComponentDocData _cKAppRouterDoc() => ComponentDocData(
      title: 'CKApp.router',
      summary:
          'Navigator 2.0 Router configuration with automatic theme resolution. Enables deep linking, declarative routing, and programmatic navigation while maintaining brand and theme consistency.',
      demo: _RouterLiveDemo(),
      code: '''
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  brightness: Brightness.light,
  routerConfig: RouterConfig<Object>(
    routerDelegate: myDelegate,
    routeInformationParser: myParser,
    routeInformationProvider: routeInformationProvider,
  ),
  title: 'My App',
)
''',
      params: [
        DocParam(
          name: 'brand',
          type: 'ckcoreBrand',
          description: 'Brand theme (castleKeep or skygo).',
          requiredParam: true,
        ),
        DocParam(
          name: 'routerConfig',
          type: 'RouterConfig<Object>',
          description: 'Navigator 2.0 routing configuration.',
          requiredParam: true,
        ),
        DocParam(
          name: 'brightness',
          type: 'Brightness?',
          description: 'Light or dark theme brightness.',
          defaultValue: 'null (auto-detect from system)',
        ),
        DocParam(
          name: 'title',
          type: 'String?',
          description: 'App title shown in system UI.',
        ),
        DocParam(
          name: 'debugShowCheckedModeBanner',
          type: 'bool',
          description: 'Show debug banner in development.',
          defaultValue: 'true',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why use CKApp.router instead of CKApp?',
          answer:
              'CKApp.router enables Navigator 2.0 features (deep links, declarative routing) while automatically providing theme context. Use CKApp for simple Navigator 1.0 flows.',
        ),
        DocFaq(
          question: 'Can I mix Navigator 1.0 pushes with Router?',
          answer:
              'Yes. Use nested Navigators for local flows (bottom sheet navigation, page stacks). The global Router controls top-level routing.',
        ),
        DocFaq(
          question: 'How do I migrate from onGenerateRoute?',
          answer:
              'Move route-to-page mapping into a RouterDelegate subclass and a RouteInformationParser, then provide them via RouterConfig to CKApp.router.',
        ),
        DocFaq(
          question: 'How is theme injected?',
          answer:
              'CKApp.router wraps your router with a ckcoreTheme provider. Any descendant can access theme via context.ckcoreTheme.',
        ),
      ],
      notes: [
        'Router maintains theme context across all routes.',
        'Deep linking requires configuring RouteInformationParser.',
        'See example/ app for a complete routing setup.',
      ],
    );

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
