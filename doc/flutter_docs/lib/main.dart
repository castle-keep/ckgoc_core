import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

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
import 'package:ckcore_docs_app/pages/splash_screen.dart';
import 'package:ckcore_docs_app/docs/docs_header.dart';
import 'package:ckcore_docs_app/docs/docs_sidebar.dart';
import 'package:flutter/services.dart';

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
  Brightness? _brightness; // null = follow the system
  bool _splashDone = false;

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  /// Ctrl/Cmd+K focuses the sidebar search from anywhere.
  bool _onKey(KeyEvent event) {
    if (!_splashDone || event is! KeyDownEvent) return false;
    if (event.logicalKey != LogicalKeyboardKey.keyK) return false;
    final keys = HardwareKeyboard.instance;
    if (!(keys.isControlPressed || keys.isMetaPressed)) return false;
    docsSearchFocus.requestFocus();
    return true;
  }

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

  Widget _docs() {
    return Column(
      children: [
        DocsHeader(
          brand: _brand,
          brightness: _brightness,
          onBrandChanged: _setBrand,
          onBrightnessChanged: _setBrightness,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DocsSidebar(),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: currentRoute,
                  builder: (context, route, _) => _DocsPage(route: route),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CKApp(
      brand: _brand,
      brightness: _brightness,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: !_splashDone
            ? SplashScreen(
                key: const ValueKey('splash'),
                brand: _brand,
                onDone: () => setState(() => _splashDone = true),
              )
            : KeyedSubtree(key: const ValueKey('docs'), child: _docs()),
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
    return _page();
  }
}
