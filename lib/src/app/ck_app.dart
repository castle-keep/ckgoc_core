// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:ckcoreui/src/themes/ckcore_brand.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/themes/ckcore_theme_resolver.dart';
import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';

/// High-level Material app wrapper that automatically applies CKCoreUI themes.
///
/// `CKApp` is a drop-in replacement for `MaterialApp` that handles theme
/// resolution based on the specified [brand] and system brightness.
///
/// Example:
/// ```dart
/// CKApp(
///   brand: ckcoreBrand.castleKeep,
///   home: HomePage(),
///   title: 'My App',
/// )
/// ```
///
/// For routing solutions like GoRouter, use [CKApp.router]:
/// ```dart
/// CKApp.router(
///   brand: ckcoreBrand.castleKeep,
///   routerConfig: goRouter,
/// )
/// ```
class CKApp extends StatefulWidget {
  /// Creates a CKApp.
  ///
  /// All parameters forward to [MaterialApp] except [brand], [brightness],
  /// and [responsive], which are CKCoreUI-specific.
  const CKApp({
    required this.brand,
    super.key,
    this.brightness,
    this.responsive = false,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
  }) : _routerConfig = null,
       _routerDelegate = null,
       _routeInformationParser = null,
       _routeInformationProvider = null;

  /// Creates a CKApp for routing scenarios.
  ///
  /// This constructor is equivalent to using the default constructor with
  /// a [routes] and [home] parameter, but is provided for parity with
  /// [MaterialApp.router].
  ///
  /// Example:
  /// ```dart
  /// CKApp.router(
  ///   brand: ckcoreBrand.castleKeep,
  ///   routerConfig: goRouter,
  /// )
  /// ```
  const CKApp.router({
    required this.brand,
    required RouterConfig<Object> routerConfig,
    super.key,
    this.brightness,
    this.responsive = false,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
  }) : navigatorKey = null,
       home = null,
       routes = const <String, WidgetBuilder>{},
       initialRoute = null,
       onGenerateRoute = null,
       onUnknownRoute = null,
       navigatorObservers = const <NavigatorObserver>[],
       _routerConfig = routerConfig,
       _routerDelegate = null,
       _routeInformationParser = null,
       _routeInformationProvider = null;

  /// Creates a CKApp for routing scenarios using separate router components.
  ///
  /// This constructor allows direct use of router delegate and parser,
  /// making it compatible with packages like Stacked.
  ///
  /// Example:
  /// ```dart
  /// CKApp.delegate(
  ///   brand: ckcoreBrand.castleKeep,
  ///   routerDelegate: stackedRouter.delegate(),
  ///   routeInformationParser: stackedRouter.defaultRouteParser(),
  /// )
  /// ```
  const CKApp.delegate({
    required this.brand,
    required RouterDelegate<Object> routerDelegate,
    required RouteInformationParser<Object> routeInformationParser,
    RouteInformationProvider? routeInformationProvider,
    super.key,
    this.brightness,
    this.responsive = false,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
  }) : navigatorKey = null,
       home = null,
       routes = const <String, WidgetBuilder>{},
       initialRoute = null,
       onGenerateRoute = null,
       onUnknownRoute = null,
       navigatorObservers = const <NavigatorObserver>[],
       _routerConfig = null,
       _routerDelegate = routerDelegate,
       _routeInformationParser = routeInformationParser,
       _routeInformationProvider = routeInformationProvider;

  /// The design system brand to use for automatic theme generation.
  final ckcoreBrand brand;

  /// Optional brightness override. If not specified, follows system brightness.
  final Brightness? brightness;

  /// Whether to wrap the app in a responsive layout provider.
  ///
  /// When `true`, the app will be wrapped with responsive-aware components
  /// (if available). Default is `false`.
  final bool responsive;

  // ========== MaterialApp Parameters ==========

  /// See [MaterialApp.navigatorKey].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// See [MaterialApp.home].
  final Widget? home;

  /// See [MaterialApp.routes].
  final Map<String, WidgetBuilder> routes;

  /// See [MaterialApp.initialRoute].
  final String? initialRoute;

  /// See [MaterialApp.onGenerateRoute].
  final RouteFactory? onGenerateRoute;

  /// See [MaterialApp.onUnknownRoute].
  final RouteFactory? onUnknownRoute;

  /// See [MaterialApp.navigatorObservers].
  final List<NavigatorObserver> navigatorObservers;

  /// See [MaterialApp.builder].
  final TransitionBuilder? builder;

  /// See [MaterialApp.title].
  final String title;

  /// See [MaterialApp.onGenerateTitle].
  final GenerateAppTitle? onGenerateTitle;

  /// See [MaterialApp.color].
  final Color? color;

  /// Optional theme override. If not provided, auto-generated from brand.
  final ThemeData? theme;

  /// Optional dark theme override. If not provided, auto-generated from brand.
  final ThemeData? darkTheme;

  /// See [MaterialApp.highContrastTheme].
  final ThemeData? highContrastTheme;

  /// See [MaterialApp.highContrastDarkTheme].
  final ThemeData? highContrastDarkTheme;

  /// See [MaterialApp.themeMode].
  final ThemeMode themeMode;

  /// See [MaterialApp.locale].
  final Locale? locale;

  /// See [MaterialApp.localizationsDelegates].
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// See [MaterialApp.localeListResolutionCallback].
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// See [MaterialApp.localeResolutionCallback].
  final LocaleResolutionCallback? localeResolutionCallback;

  /// See [MaterialApp.supportedLocales].
  final Iterable<Locale> supportedLocales;

  /// See [MaterialApp.debugShowMaterialGrid].
  final bool debugShowMaterialGrid;

  /// See [MaterialApp.showPerformanceOverlay].
  final bool showPerformanceOverlay;

  /// See [MaterialApp.checkerboardRasterCacheImages].
  final bool checkerboardRasterCacheImages;

  /// See [MaterialApp.checkerboardOffscreenLayers].
  final bool checkerboardOffscreenLayers;

  /// See [MaterialApp.showSemanticsDebugger].
  final bool showSemanticsDebugger;

  /// See [MaterialApp.debugShowCheckedModeBanner].
  final bool debugShowCheckedModeBanner;

  /// See [MaterialApp.shortcuts].
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// See [MaterialApp.actions].
  final Map<Type, Action<Intent>>? actions;

  /// See [MaterialApp.restorationScopeId].
  final String? restorationScopeId;

  /// See [MaterialApp.scrollBehavior].
  final ScrollBehavior? scrollBehavior;

  /// See [MaterialApp.useInheritedMediaQuery].
  final bool useInheritedMediaQuery;

  /// Router config for [CKApp.router] variant.
  final RouterConfig<Object>? _routerConfig;

  /// Router delegate for [CKApp.delegate] variant.
  final RouterDelegate<Object>? _routerDelegate;

  /// Route information parser for [CKApp.delegate] variant.
  final RouteInformationParser<Object>? _routeInformationParser;

  /// Optional route information provider for [CKApp.delegate] variant.
  final RouteInformationProvider? _routeInformationProvider;

  @override
  State<CKApp> createState() => _CKAppState();
}

class _CKAppState extends State<CKApp> {
  RouterConfig<Object>? _routerConfig;
  late final RouterDelegate<Object>? _delegate;
  late final RouteInformationParser<Object>? _parser;
  late final RouteInformationProvider? _provider;

  @override
  void initState() {
    super.initState();
    // Store delegate/parser once to preserve navigation state across hot reloads
    _delegate = widget._routerDelegate;
    _parser = widget._routeInformationParser;
    _provider = widget._routeInformationProvider;
    _createRouterConfig();
  }

  void _createRouterConfig() {
    // Create router config using stored delegate/parser to preserve route state
    if (_delegate != null && _parser != null) {
      _routerConfig = RouterConfig<Object>(
        routerDelegate: _delegate,
        routeInformationParser: _parser,
        // PlatformRouteInformationProvider with empty RouteInformation
        // will read the current URL from the browser/platform
        routeInformationProvider:
            _provider ??
            PlatformRouteInformationProvider(
              initialRouteInformation: RouteInformation(
                uri: Uri.parse(
                  WidgetsBinding.instance.platformDispatcher.defaultRouteName,
                ),
              ),
            ),
      );
    }
  }

  ThemeData _materialFrom(CkcoreuiThemeData ck) {
    final c = ck.colors;
    final t = ck.typography;

    // Create text theme using all ckcoreui typography tokens
    final customTextTheme = TextTheme(
      bodySmall: t.textSm.copyWith(color: c.onSurface),
      bodyMedium: t.textMd.copyWith(color: c.onSurface),
      bodyLarge: t.textLg.copyWith(color: c.onSurface),
      labelSmall: t.labelSm.copyWith(color: c.onSurface),
      labelMedium: t.labelMd.copyWith(color: c.onSurface),
      labelLarge: t.labelLg.copyWith(color: c.onSurface),
      displaySmall: t.displaySm.copyWith(color: c.onSurface),
      displayMedium: t.displayMd.copyWith(color: c.onSurface),
      displayLarge: t.displayLg.copyWith(color: c.onSurface),
      headlineSmall: t.labelLg.copyWith(color: c.onSurface),
      headlineMedium: t.displaySm.copyWith(color: c.onSurface),
      headlineLarge: t.displayMd.copyWith(color: c.onSurface),
      titleSmall: t.labelMd.copyWith(color: c.onSurface),
      titleMedium: t.labelLg.copyWith(color: c.onSurface),
      titleLarge: t.labelXl.copyWith(color: c.onSurface),
    );

    // Create primary text theme (for text on primary colored backgrounds)
    final primaryTextTheme = customTextTheme.apply(
      bodyColor: c.onPrimary,
      displayColor: c.onPrimary,
    );

    return ThemeData(
      brightness: ck.brightness,
      primaryColor: c.primary,
      scaffoldBackgroundColor: c.background,
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: ck.brightness,
        primary: c.primary,
        onPrimary: c.onPrimary,
        secondary: c.secondary,
        onSecondary: c.onSecondary,
        error: c.error,
        onError: c.onError,
        surface: c.surface,
        onSurface: c.onSurface,
        surfaceContainerHighest: c.surface,
        onSurfaceVariant: c.onSurface,
        outline: c.outline,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: c.onSurface,
        onInverseSurface: c.surface,
        inversePrimary: c.primary,
      ),
      textTheme: customTextTheme,
      primaryTextTheme: primaryTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: c.surface,
        foregroundColor: c.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: c.onSurface),
        titleTextStyle: t.labelXl.copyWith(color: c.onSurface),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: c.surface,
        selectedIconTheme: IconThemeData(color: c.primary),
        unselectedIconTheme: IconThemeData(
          color: c.onSurface.withValues(alpha: 0.7),
        ),
        selectedLabelTextStyle: t.labelMd.copyWith(color: c.primary),
        unselectedLabelTextStyle: t.labelMd.copyWith(color: c.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: t.labelMd.copyWith(color: c.onSurface),
        hintStyle: t.textMd.copyWith(color: c.onSurface.withValues(alpha: 0.6)),
      ),
      // Button themes derived from CKButton styles so Material buttons
      // visually match CKButton across the app.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          disabledBackgroundColor: c.primary,
          disabledForegroundColor: c.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: ck.spacing.s20,
            vertical: ck.spacing.s12,
          ),
          minimumSize: Size(0, ck.spacing.x2l),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ck.radius.base),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.primary,
          disabledForegroundColor: c.primary,
          side: BorderSide(color: c.primary, width: 1),
          padding: EdgeInsets.symmetric(
            horizontal: ck.spacing.s20,
            vertical: ck.spacing.s12,
          ),
          minimumSize: Size(0, ck.spacing.x2l),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ck.radius.base),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          disabledForegroundColor: c.primary,
          padding: EdgeInsets.symmetric(
            horizontal: ck.spacing.s20,
            vertical: ck.spacing.s12,
          ),
          minimumSize: Size(0, ck.spacing.x2l),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ck.radius.base),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ck.radius.md),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        titleTextStyle: t.labelLg.copyWith(color: c.onSurface),
        contentTextStyle: t.textMd.copyWith(color: c.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ck.radius.lg),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return c.primary;
          return c.onSurface;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return c.primary;
          return c.onSurface;
        }),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected))
            return c.primary.withValues(alpha: 0.5);
          return c.onSurface.withValues(alpha: 0.2);
        }),
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return c.primary;
          return c.surface;
        }),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.surface,
        textStyle: t.textMd.copyWith(color: c.onSurface),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBrightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    // Resolve theme data for both light and dark variants so MaterialApp
    // can toggle between them when using ThemeMode.system.
    final lightThemeData = ckcoreThemeResolver.resolve(
      widget.brand,
      Brightness.light,
    );
    final darkThemeData = ckcoreThemeResolver.resolve(
      widget.brand,
      Brightness.dark,
    );

    // Resolve the active ckcore theme for the current brightness (for the
    // Inherited ckcoreTheme wrapper used by package widgets).
    final themeData = effectiveBrightness == Brightness.dark
        ? darkThemeData
        : lightThemeData;

    // Build appropriate MaterialApp (or MaterialApp.router)
    final materialApp =
        (widget._routerConfig != null || widget._routerDelegate != null)
        ? _buildRouterApp()
        : _buildApp(
            lightThemeData: lightThemeData,
            darkThemeData: darkThemeData,
          );

    // Wrap with ckcoreTheme to provide design tokens to the widget tree
    final themedApp = ckcoreTheme(data: themeData, child: materialApp);

    return themedApp;
  }

  Widget _buildApp({
    required CkcoreuiThemeData lightThemeData,
    required CkcoreuiThemeData darkThemeData,
  }) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      home: widget.home,
      routes: widget.routes,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      navigatorObservers: widget.navigatorObservers,
      builder: widget.builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme ?? _materialFrom(lightThemeData),
      darkTheme: widget.darkTheme ?? _materialFrom(darkThemeData),
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
    );
  }

  Widget _buildRouterApp() {
    // Use stored router config created in initState (preserves route across rebuilds)
    // or use the routerConfig provided via CKApp.router constructor
    final routerConfig = _routerConfig ?? widget._routerConfig!;

    return MaterialApp.router(
      routerConfig: routerConfig,
      builder: widget.builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme:
          widget.theme ??
          _materialFrom(
            ckcoreThemeResolver.resolve(widget.brand, Brightness.light),
          ),
      darkTheme:
          widget.darkTheme ??
          _materialFrom(
            ckcoreThemeResolver.resolve(widget.brand, Brightness.dark),
          ),
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
    );
  }
}
