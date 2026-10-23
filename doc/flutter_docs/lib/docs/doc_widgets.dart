import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ckcore_docs_app/pages/ai_tools_page.dart';
import 'package:ckcore_docs_app/pages/animate_page.dart';
import 'package:ckcore_docs_app/pages/brand_icons_page.dart';
import 'package:ckcore_docs_app/pages/buttons_page.dart';
import 'package:ckcore_docs_app/pages/data_table_page.dart';
import 'package:ckcore_docs_app/pages/display_page.dart';
import 'package:ckcore_docs_app/pages/enums_page.dart';
import 'package:ckcore_docs_app/pages/feedback_page.dart';
import 'package:ckcore_docs_app/pages/inputs_page.dart';
import 'package:ckcore_docs_app/pages/navigation_page.dart';
import 'package:ckcore_docs_app/pages/overlays_page.dart';
import 'package:ckcore_docs_app/pages/getting_started_page.dart';
import 'package:ckcore_docs_app/pages/overview_page.dart';
import 'package:ckcore_docs_app/pages/foundation_page.dart';
import 'package:ckcore_docs_app/pages/app_page.dart';
import 'package:ckcore_docs_app/pages/screen_layout_page.dart';
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
        return const GettingStartedPage();

      case '/overview':
        return const OverviewPage();

      case '/ai-tools':
        return const AiToolsPage();

      case '/animate':
        return const AnimatePage();

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

      case '/screen-layout':
        return const ScreenLayoutPage();

      default:
        return const GettingStartedPage();
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
          trigger: CKContainer.outlined(
            elevated: true,
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
          trigger: CKContainer.outlined(
            elevated: true,
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
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Keep long lines readable on very wide screens.
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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

class DocSection extends StatelessWidget {
  const DocSection({required this.data, super.key});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final theme = ckcoreTheme.of(context);
    final coming = data.comingSoon;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: coming
          ? CKContainer(
              elevated: false,
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
                    ...data.notes.map((note) {
                      final isMigration =
                          note.toLowerCase().contains('migration note');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• $note',
                          style: isMigration
                              ? theme.typography.textXs
                                  .copyWith(color: theme.colors.error)
                              : theme.typography.textXs,
                        ),
                      );
                    }),
                  ],
                  const VSpace(height: 16),
                  Text('Live demo', style: theme.typography.labelMd),
                  const VSpace(height: 8),
                  // Demo area is disabled and dimmed when comingSoon is true.
                  IgnorePointer(
                    ignoring: coming,
                    child: CKContainer.outlined(
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
              ))
          : CKContainer.outlined(
              elevated: true,
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
                    ...data.notes.map((note) {
                      final isRoadmap = note.toLowerCase().contains('roadmap');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '• $note',
                          style: isRoadmap
                              ? theme.typography.textXs.copyWith(
                                  color: theme.colors.warning,
                                  fontWeight: FontWeight.w600)
                              : theme.typography.textXs,
                        ),
                      );
                    }),
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
        0: FlexColumnWidth(1.4), // Name
        1: FlexColumnWidth(0.8), // Required
        2: FlexColumnWidth(1.0), // Default
        3: FlexColumnWidth(1.2), // Type/Signature
        4: FlexColumnWidth(3.3), // Description
      },
      border: TableBorder.all(color: ckcoreTheme.of(context).colors.outline),
      children: [
        _row(context,
            const ['Name', 'Required', 'Default', 'Type', 'Description'],
            header: true),
        for (final param in params)
          _row(context, [
            param.name,
            param.requiredParam ? 'Yes' : 'No',
            param.defaultValue ?? '—',
            param.type,
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

/// Titled outlined container used by the guide-style docs pages.
class DocPanel extends StatelessWidget {
  const DocPanel({
    super.key,
    required this.title,
    required this.blurb,
    required this.child,
    this.badge,
  });

  final String title;
  final String blurb;
  final Widget child;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return CKContainer.outlined(
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (badge != null) ...[
                CKBadge(label: badge!),
                const HSpace(width: 8),
              ],
              Expanded(child: Text(title, style: theme.typography.textXl)),
            ],
          ),
          const VSpace(height: 4),
          Text(
            blurb,
            style: theme.typography.textSm.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const VSpace(height: 16),
          child,
        ],
      ),
    );
  }
}

/// Selectable code with a one-click copy button.
class CodeBlock extends StatefulWidget {
  const CodeBlock({required this.code, this.title, super.key});

  final String code;

  /// Optional caption shown above the code, e.g. a file name.
  final String? title;

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code.trim()));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ckcoreTheme.of(context);
    return CKContainer(
      // use named constructor for muted surface
      variant: ContainerVariant.muted,
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null)
                Expanded(
                  child: Text(widget.title!, style: theme.typography.labelSm),
                )
              else
                const Spacer(),
              TextButton.icon(
                onPressed: _copy,
                icon: Icon(
                  _copied ? Icons.check : Icons.copy_outlined,
                  size: 16,
                  color: _copied ? theme.colors.success : null,
                ),
                label: Text(_copied ? 'Copied!' : 'Copy'),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: SelectableText(
              widget.code,
              style: theme.typography.codeMd,
            ),
          ),
        ],
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
