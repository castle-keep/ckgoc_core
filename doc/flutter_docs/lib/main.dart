import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/pages/brand_icons_page.dart';
import 'package:ckgoc_docs_app/pages/buttons_page.dart';
import 'package:ckgoc_docs_app/pages/data_table_page.dart';
import 'package:ckgoc_docs_app/pages/display_page.dart';
import 'package:ckgoc_docs_app/pages/enums_page.dart';
import 'package:ckgoc_docs_app/pages/feedback_page.dart';
import 'package:ckgoc_docs_app/pages/inputs_page.dart';
import 'package:ckgoc_docs_app/pages/navigation_page.dart';
import 'package:ckgoc_docs_app/pages/overlays_page.dart';
import 'package:ckgoc_docs_app/pages/overview_page.dart';
import 'package:ckgoc_docs_app/pages/foundation_page.dart';
import 'package:ckgoc_docs_app/pages/app_page.dart';
import 'package:ckgoc_docs_app/pages/templates_page.dart';
import 'package:ckgoc_docs_app/pages/themes_page.dart';

void main() {
  runApp(const DocsApp());
}

class DocsApp extends StatefulWidget {
  const DocsApp({super.key});

  @override
  State<DocsApp> createState() => _DocsAppState();
}

class _DocsAppState extends State<DocsApp> {
  CkgocBrand _brand = CkgocBrand.castleKeep;
  Brightness? _brightness = Brightness.light;

  void _setBrand(CkgocBrand brand) => setState(() => _brand = brand);
  void _setBrightness(Brightness? b) => setState(() => _brightness = b);

  Widget _wrapPage(Widget child) {
    return Stack(
      children: [
        Positioned.fill(child: child),
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
  }

  @override
  Widget build(BuildContext context) {
    return CkgocApp(
      brand: _brand,
      brightness: _brightness,
      child: MaterialApp(
        title: 'Ckgoc Core Docs',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          late final Widget page;

          switch (settings.name) {
            case '/':
              page = _wrapPage(const OverviewPage());
              break;
            case '/app':
              page = _wrapPage(const AppPage());
              break;
            case '/foundation':
              page = _wrapPage(const FoundationPage());
              break;
            case '/themes':
              page = _wrapPage(const ThemesPage());
              break;
            case '/templates':
              page = _wrapPage(const TemplatesPage());
              break;
            case '/buttons':
              page = _wrapPage(const ButtonsPage());
              break;
            case '/display':
              page = _wrapPage(const DisplayPage());
              break;
            case '/inputs':
              page = _wrapPage(const InputsPage());
              break;
            case '/feedback':
              page = _wrapPage(const FeedbackPage());
              break;
            case '/navigation':
              page = _wrapPage(const NavigationPage());
              break;
            case '/overlays':
              page = _wrapPage(const OverlaysPage());
              break;
            case '/data-table':
              page = _wrapPage(const DataTablePage());
              break;
            case '/enums':
              page = _wrapPage(const EnumsPage());
              break;
            case '/brand-icons':
              page = _wrapPage(const BrandIconsPage());
              break;
            default:
              page = _wrapPage(const OverviewPage());
          }

          return PageRouteBuilder(
            settings: settings,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => page,
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

  final CkgocBrand brand;
  final Brightness? brightness;
  final ValueChanged<CkgocBrand> onBrandChanged;
  final ValueChanged<Brightness?> onBrightnessChanged;

  String get _brandLabel => switch (brand) {
        CkgocBrand.castleKeep => 'CastleKeep',
        CkgocBrand.skyGo => 'SkyGo',
      };

  String get _brightnessLabel => switch (brightness) {
        Brightness.light => 'Light',
        Brightness.dark => 'Dark',
        null => 'System',
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Brand selector
        CkgocMenu(
          trigger: CkgocContainer(
            elevated: true,
            variant: ContainerVariant.outlined,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _brandLabel,
                  style: theme.typography.labelSm.copyWith(
                    color: theme.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          items: [
            CkgocMenuItem(
              label: 'Brand: CastleKeep',
              onTap: () => onBrandChanged(CkgocBrand.castleKeep),
            ),
            CkgocMenuItem(
              label: 'Brand: SkyGo',
              onTap: () => onBrandChanged(CkgocBrand.skyGo),
            ),
          ],
        ),
        SizedBox(width: theme.spacing.sm),
        // Brightness selector
        CkgocMenu(
          trigger: CkgocContainer(
            elevated: true,
            variant: ContainerVariant.outlined,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sunny,
                  size: theme.spacing.md,
                  color: theme.colors.primary,
                ),
                SizedBox(width: theme.spacing.xs),
                Text(
                  _brightnessLabel,
                  style: theme.typography.labelSm.copyWith(
                    color: theme.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          items: [
            CkgocMenuItem(
              label: 'Follow system',
              icon: Icons.monitor,
              onTap: () => onBrightnessChanged(null),
            ),
            CkgocMenuItem(
              label: 'Force light',
              icon: Icons.sunny,
              onTap: () => onBrightnessChanged(Brightness.light),
            ),
            CkgocMenuItem(
              label: 'Force dark',
              icon: Icons.nightlight_round,
              onTap: () => onBrightnessChanged(Brightness.dark),
            ),
          ],
        ),
      ],
    );
  }
}
