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

import 'docs_navigation.dart';

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

  void _setBrand(ckcoreBrand brand) {
    setState(() {
      _brand = brand;
    });
  }

  void _setBrightness(Brightness? brightness) {
    setState(() {
      _brightness = brightness;
    });
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
              _DocsPage(route: route),
              Positioned(
                top: 12,
                right: 12,
                child: _ThemeSwitcher(
                  brand: _brand,
                  brightness: _brightness,
                  onBrandChanged: _setBrand,
                  onBrightnessChanged: _setBrightness,
                ),
              ),
            ],
          );
        },
      ),
      title: 'ckcoreui Core Docs',
    );
  }
}

class _DocsPage extends StatelessWidget {
  const _DocsPage({
    required this.route,
  });

  final String route;

  Widget _page() {
    switch (route) {
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
        return const ScreenLayoutDemoPage();
      default:
        return const OverviewPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _page();
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
              onTap: () => onBrandChanged(ckcoreBrand.castleKeep),
            ),
            CKMenuItem(
              label: 'SkyGo',
              onTap: () => onBrandChanged(ckcoreBrand.skyGo),
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
              onTap: () => onBrightnessChanged(null),
            ),
            CKMenuItem(
              label: 'Light',
              onTap: () => onBrightnessChanged(Brightness.light),
            ),
            CKMenuItem(
              label: 'Dark',
              onTap: () => onBrightnessChanged(Brightness.dark),
            ),
          ],
        ),
      ],
    );
  }
}
