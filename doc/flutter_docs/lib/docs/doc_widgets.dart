import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/pages/brand_icons_page.dart';
import 'package:ckcore_docs_app/pages/buttons_page.dart';
import 'package:ckcore_docs_app/pages/data_table_page.dart';
import 'package:ckcore_docs_app/pages/display_page.dart';
import 'package:ckcore_docs_app/pages/enums_page.dart';
import 'package:ckcore_docs_app/pages/feedback_page.dart';
import 'package:ckcore_docs_app/pages/inputs_page.dart';
import 'package:ckcore_docs_app/pages/navigation_page.dart';
import 'package:ckcore_docs_app/pages/overlays_page.dart';
import 'package:ckcore_docs_app/pages/overview_page.dart';
import 'package:ckcore_docs_app/pages/foundation_page.dart';
import 'package:ckcore_docs_app/pages/app_page.dart';
import 'package:ckcore_docs_app/pages/screen_layout_page.dart';
import 'package:ckcore_docs_app/pages/templates_page.dart';
import 'package:ckcore_docs_app/pages/themes_page.dart';
import 'package:ckcore_docs_app/pages/router_page.dart';
import '../docs_navigation.dart';

void main() {
  runApp(const DocsApp());
}

class DocsApp extends StatefulWidget {
  const DocsApp({super.key});

  @override
  State<DocsApp> createState() => _DocsAppState();
}

class _DocsAppState extends State<DocsApp> {
  ckcoreBrand _brand = ckcoreBrand.castleKeep;
  Brightness? _brightness = Brightness.light;

  Widget _pageForRoute(String route) {
    switch (route) {
      case '/':
        return const OverviewPage();

      case '/buttons':
        return const ButtonsPage();

      case '/display':
        return const DisplayPage();

      case '/inputs':
        return const InputsPage();

      case '/feedback':
        return const FeedbackPage();

      case '/navigation':
        return const NavigationPage();

      case '/router':
        return const RouterDocsPage();

      case '/overlays':
        return const OverlaysPage();

      case '/data-table':
        return const DataTablePage();

      case '/enums':
        return const EnumsPage();

      case '/brand-icons':
        return const BrandIconsPage();

      case '/app':
        return const AppPage();

      case '/foundation':
        return const FoundationPage();

      case '/themes':
        return const ThemesPage();

      case '/templates':
        return const TemplatesPage();

      case '/screen-layout':
        return const ScreenLayoutPage();

      default:
        return const OverviewPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: _brand,
      brightness: _brightness,
      home: ValueListenableBuilder<String>(
        valueListenable: currentRoute,
        builder: (context, route, _) {
          return Stack(
            children: [
              _pageForRoute(route),
              Positioned(
                top: 12,
                right: 12,
                child: _ThemeSwitcher(
                  brand: _brand,
                  brightness: _brightness,
                  onBrandChanged: (b) {
                    setState(() {
                      _brand = b;
                    });
                  },
                  onBrightnessChanged: (b) {
                    setState(() {
                      _brightness = b;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({
    required this.brand,
    required this.brightness,
    required this.onBrandChanged,
    required this.onBrightnessChanged,
  });

  final ckcoreBrand brand;
  final Brightness? brightness;
  final ValueChanged<ckcoreBrand> onBrandChanged;
  final ValueChanged<Brightness?> onBrightnessChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CKMenu(
          trigger: CKContainer(
            elevated: true,
            variant: ContainerVariant.outlined,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            child: Text(
              brand == ckcoreBrand.castleKeep ? 'CastleKeep' : 'SkyGo',
            ),
          ),
          items: [
            CKMenuItem(
              label: 'CastleKeep',
              onTap: () {
                onBrandChanged(ckcoreBrand.castleKeep);
              },
            ),
            CKMenuItem(
              label: 'SkyGo',
              onTap: () {
                onBrandChanged(ckcoreBrand.skyGo);
              },
            ),
          ],
        ),
        const SizedBox(width: 8),
        CKMenu(
          trigger: CKContainer(
            elevated: true,
            variant: ContainerVariant.outlined,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            child: Text(
              brightness == null
                  ? 'System'
                  : brightness == Brightness.dark
                      ? 'Dark'
                      : 'Light',
            ),
          ),
          items: [
            CKMenuItem(
              label: 'System',
              onTap: () {
                onBrightnessChanged(null);
              },
            ),
            CKMenuItem(
              label: 'Light',
              onTap: () {
                onBrightnessChanged(Brightness.light);
              },
            ),
            CKMenuItem(
              label: 'Dark',
              onTap: () {
                onBrightnessChanged(Brightness.dark);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class DocsScaffold extends StatelessWidget {
  const DocsScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ckcoreTheme.of(context).colors.background,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 260,
              child: const DocsNavigationRail(),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    title,
                    style: ckcoreTheme.of(context).typography.displayLg,
                  ),
                  const VSpace(height: 8),
                  Text(
                    subtitle,
                    style: ckcoreTheme.of(context).typography.textLg,
                  ),
                  const VSpace(height: 24),
                  ...children,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small spacing helpers to avoid scattering `SizedBox` throughout views.
class VSpace extends StatelessWidget {
  const VSpace({this.height = 8, super.key});
  final double height;
  @override
  Widget build(BuildContext context) => Container(height: height);
}

class HSpace extends StatelessWidget {
  const HSpace({this.width = 8, super.key});
  final double width;
  @override
  Widget build(BuildContext context) => Container(width: width);
}

class DocsNavigationRail extends StatelessWidget {
  const DocsNavigationRail({super.key});

  static const _items = <({String title, String route, IconData icon})>[
    (title: 'Overview', route: '/', icon: Icons.home_outlined),
    (title: 'Buttons', route: '/buttons', icon: Icons.smart_button_outlined),
    (title: 'Display', route: '/display', icon: Icons.slideshow_outlined),
    (title: 'Inputs', route: '/inputs', icon: Icons.keyboard_outlined),
    (title: 'Feedback', route: '/feedback', icon: Icons.info_outline),
    (title: 'Navigation', route: '/navigation', icon: Icons.route_outlined),
    (title: 'Router', route: '/router', icon: Icons.router_outlined),
    (title: 'Overlays', route: '/overlays', icon: Icons.layers_outlined),
    (
      title: 'Data Table',
      route: '/data-table',
      icon: Icons.table_chart_outlined,
    ),
    (title: 'Enums', route: '/enums', icon: Icons.list_alt_outlined),
    (title: 'Brand Icons', route: '/brand-icons', icon: Icons.image_outlined),
    (title: 'App', route: '/app', icon: Icons.web_asset_outlined),
    (
      title: 'Foundation',
      route: '/foundation',
      icon: Icons.foundation_outlined,
    ),
    (title: 'Themes', route: '/themes', icon: Icons.palette_outlined),
    (title: 'Templates', route: '/templates', icon: Icons.dashboard_outlined),
    (
      title: 'Screen Layout',
      route: '/screen-layout',
      icon: Icons.view_sidebar_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final current = currentRoute.value;
    final currentIndex = _items.indexWhere((item) => item.route == current);

    final theme = ckcoreTheme.of(context);

    return Container(
      color: theme.colors.surface,
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
            child: Text('Docs', style: theme.typography.labelMd),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final selected = index == currentIndex;
                return Material(
                  color: selected
                      ? theme.colors.surfaceElevated
                      : Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      currentRoute.value = item.route;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: theme.spacing.sm,
                        horizontal: theme.spacing.md,
                      ),
                      child: Row(
                        children: [
                          Icon(item.icon,
                              size: 20,
                              color: selected
                                  ? theme.colors.primary
                                  : theme.colors.onSurface),
                          SizedBox(width: theme.spacing.md),
                          Expanded(
                            child: Text(
                              item.title,
                              style: selected
                                  ? theme.typography.labelMd
                                      .copyWith(color: theme.colors.primary)
                                  : theme.typography.textMd,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md, vertical: theme.spacing.sm),
            child: Text('ckcoreui Core Docs', style: theme.typography.textXs),
          ),
        ],
      ),
    );
  }
}

class DocSection extends StatelessWidget {
  const DocSection({required this.data, super.key});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final theme = ckcoreTheme.of(context);
    final coming = data.comingSoon;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CKContainer(
        variant: coming ? ContainerVariant.surface : ContainerVariant.outlined,
        elevated: coming ? false : true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (coming)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CKBadge(
                      label: 'Coming soon',
                      variant: BadgeVariant.live,
                    ),
                  ),
                Text(data.title, style: theme.typography.labelLg),
              ],
            ),
            const VSpace(height: 8),
            Text(data.summary, style: theme.typography.textSm),
            if (data.notes.isNotEmpty) ...[
              const VSpace(height: 12),
              ...data.notes.map(
                (note) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '• $note',
                    style: theme.typography.textXs,
                  ),
                ),
              ),
            ],
            const VSpace(height: 16),
            Text('Live demo', style: theme.typography.labelMd),
            const VSpace(height: 8),
            // Demo area is disabled and dimmed when comingSoon is true.
            IgnorePointer(
              ignoring: coming,
              child: CKContainer(
                variant: ContainerVariant.outlined,
                child: HeroMode(enabled: false, child: data.demo),
              ),
            ),
            const VSpace(height: 16),
            Text('Usage code', style: theme.typography.labelMd),
            const VSpace(height: 8),
            CodeBlock(code: data.code),
            const VSpace(height: 16),
            Text('Parameters', style: theme.typography.labelMd),
            const VSpace(height: 8),
            ParamTable(params: data.params),
            if (data.faqs.isNotEmpty) ...[
              const VSpace(height: 16),
              Text('FAQs', style: theme.typography.labelMd),
              const VSpace(height: 8),
              CKAccordion(
                items: [
                  for (final faq in data.faqs)
                    CKAccordionItem(
                      title: faq.question,
                      content: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(faq.answer)),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ParamTable extends StatelessWidget {
  const ParamTable({required this.params, super.key});

  final List<dynamic> params;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.4),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(0.9),
        3: FlexColumnWidth(1.2),
        4: FlexColumnWidth(3.3),
      },
      border: TableBorder.all(color: ckcoreTheme.of(context).colors.outline),
      children: [
        _row(context,
            const ['Name', 'Type', 'Required', 'Default', 'Description'],
            header: true),
        for (final param in params)
          _row(context, [
            param.name,
            param.type,
            param.requiredParam ? 'Yes' : 'No',
            param.defaultValue ?? '—',
            param.description
          ]),
      ],
    );
  }

  TableRow _row(BuildContext context, List<String> values,
      {bool header = false}) {
    final style = header
        ? ckcoreTheme.of(context).typography.labelLg
        : ckcoreTheme.of(context).typography.textMd;
    return TableRow(
      decoration: header
          ? BoxDecoration(color: ckcoreTheme.of(context).colors.surfaceVariant)
          : null,
      children: values
          .map((value) => Padding(
              padding: const EdgeInsets.all(10),
              child: Text(value, style: style)))
          .toList(),
    );
  }
}

class CodeBlock extends StatelessWidget {
  const CodeBlock({required this.code, super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return CKContainer(
      variant: ContainerVariant.muted,
      elevated: true,
      child: SizedBox(
        width: double.infinity,
        child: SelectableText(
          code,
          style: ckcoreTheme.of(context).typography.codeMd,
        ),
      ),
    );
  }
}

class EnumCasesCard extends StatelessWidget {
  const EnumCasesCard({required this.title, required this.cases, super.key});

  final String title;
  final List<dynamic> cases;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CKContainer(
        elevated: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: ckcoreTheme.of(context).typography.labelLg),
            const VSpace(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cases
                  .map((item) => SizedBox(
                        width: 240,
                        child: CKContainer(
                          variant: ContainerVariant.outlined,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item?.name ?? '',
                                    style: ckcoreTheme
                                        .of(context)
                                        .typography
                                        .labelMd),
                                const VSpace(height: 6),
                                Text(item?.description ?? ''),
                              ]),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
