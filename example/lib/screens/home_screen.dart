import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

import 'buttons_screen.dart';
import 'data_table_screen.dart';
import 'display_screen.dart';
import 'feedback_screen.dart';
import 'inputs_screen.dart';
import 'navigation_screen.dart';
import 'overlays_screen.dart';
import 'templates_screen.dart';
import 'tokens_screen.dart';

class HomeScreen extends StatefulWidget {
  final CkgocBrand currentBrand;
  final Brightness? currentBrightness;
  final ValueChanged<CkgocBrand> onBrandChanged;
  final ValueChanged<Brightness?> onBrightnessChanged;

  const HomeScreen({
    super.key,
    required this.currentBrand,
    required this.currentBrightness,
    required this.onBrandChanged,
    required this.onBrightnessChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    const TokensScreen(),
    const ButtonsScreen(),
    const InputsScreen(),
    const DisplayScreen(),
    const DataTableScreen(),
    const FeedbackScreen(),
    const NavigationScreen(),
    const OverlaysScreen(),
    const TemplatesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: const Text('Company UI Showcase'),
        actions: [
          // Brand switcher
          DropdownButton<CkgocBrand>(
            value: widget.currentBrand,
            underline: const SizedBox.shrink(),
            items: CkgocBrand.values
                .map(
                  (b) => DropdownMenuItem(value: b, child: Text(b.displayName)),
                )
                .toList(),
            onChanged: (b) {
              if (b != null) widget.onBrandChanged(b);
            },
          ),
          const SizedBox(width: 8),
          // Brightness toggle
          IconButton(
            icon: Icon(
              widget.currentBrightness == Brightness.dark
                  ? LucideIcons.sun
                  : LucideIcons.moon,
            ),
            tooltip: 'Toggle brightness',
            onPressed: () {
              widget.onBrightnessChanged(
                widget.currentBrightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            scrollable: true,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(LucideIcons.palette),
                label: Text('Tokens'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.mousePointerClick),
                label: Text('Buttons'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.keyboard),
                label: Text('Inputs'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.layoutGrid),
                label: Text('Display'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.table2),
                label: Text('Data Table'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.messageCircle),
                label: Text('Feedback'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.navigation2),
                label: Text('Navigation'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.layers),
                label: Text('Overlays'),
              ),
              NavigationRailDestination(
                icon: Icon(LucideIcons.layoutTemplate),
                label: Text('Templates'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
