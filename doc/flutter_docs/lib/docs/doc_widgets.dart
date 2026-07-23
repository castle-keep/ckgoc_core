// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';

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
      backgroundColor: CkgocTheme.of(context).colors.background,
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
                    style: CkgocTheme.of(context).typography.displayLg,
                  ),
                  const VSpace(height: 8),
                  Text(
                    subtitle,
                    style: CkgocTheme.of(context).typography.textLg,
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

class DocsNavigationRail extends StatelessWidget {
  const DocsNavigationRail({super.key});

  static const _items = <({String title, String route, IconData icon})>[
    (title: 'Overview', route: '/', icon: Icons.home_outlined),
    (title: 'Buttons', route: '/buttons', icon: Icons.smart_button_outlined),
    (title: 'Display', route: '/display', icon: Icons.slideshow_outlined),
    (title: 'Inputs', route: '/inputs', icon: Icons.keyboard_outlined),
    (title: 'Feedback', route: '/feedback', icon: Icons.info_outline),
    (title: 'Navigation', route: '/navigation', icon: Icons.route_outlined),
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
      icon: Icons.foundation_outlined
    ),
    (title: 'Themes', route: '/themes', icon: Icons.palette_outlined),
    (title: 'Templates', route: '/templates', icon: Icons.dashboard_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name ?? '/';
    final currentIndex = _items.indexWhere((item) => item.route == current);

    return CkgocSideNav(
      sections: [
        CkgocSideNavSection(
          label: 'Docs',
          items: [
            for (final item in _items)
              CkgocSideNavItem(icon: item.icon, label: item.title),
          ],
        ),
      ],
      selectedIndex: currentIndex < 0 ? 0 : currentIndex,
      onItemSelected: (index) =>
          Navigator.of(context).pushReplacementNamed(_items[index].route),
      brandName: 'Ckgoc Core Docs',
    );
  }
}

class DocSection extends StatelessWidget {
  const DocSection({required this.data, super.key});

  final ComponentDocData data;

  @override
  Widget build(BuildContext context) {
    final theme = CkgocTheme.of(context);
    final coming = data.comingSoon;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CkgocContainer(
        variant: coming ? ContainerVariant.muted : ContainerVariant.outlined,
        elevated: true,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: theme.typography.labelLg),
                  const VSpace(height: 8),
                  Text(data.summary),
                  if (data.notes.isNotEmpty) ...[
                    const VSpace(height: 12),
                    ...data.notes.map(
                      (note) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• $note',
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
                    child: CkgocContainer(
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
                    CkgocAccordion(
                      items: [
                        for (final faq in data.faqs)
                          CkgocAccordionItem(
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
            if (coming)
              const Positioned(
                top: 8,
                right: 8,
                child: CkgocBadge(
                  label: 'Coming soon',
                  variant: BadgeVariant.live,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ParamTable extends StatelessWidget {
  const ParamTable({required this.params, super.key});

  final List<DocParam> params;

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
      border: TableBorder.all(color: CkgocTheme.of(context).colors.outline),
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
        ? CkgocTheme.of(context).typography.labelLg
        : CkgocTheme.of(context).typography.textMd;
    return TableRow(
      decoration: header
          ? BoxDecoration(color: CkgocTheme.of(context).colors.surfaceVariant)
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
    return CkgocContainer(
      variant: ContainerVariant.muted,
      child: SizedBox(
        width: double.infinity,
        child: SelectableText(
          code,
          style: CkgocTheme.of(context).typography.codeMd,
        ),
      ),
    );
  }
}

class EnumCasesCard extends StatelessWidget {
  const EnumCasesCard({required this.title, required this.cases, super.key});

  final String title;
  final List<EnumCaseDoc> cases;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CkgocContainer(
        elevated: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const VSpace(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cases
                  .map((item) => SizedBox(
                        width: 240,
                        child: CkgocContainer(
                          variant: ContainerVariant.outlined,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                const VSpace(height: 6),
                                Text(item.description),
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
