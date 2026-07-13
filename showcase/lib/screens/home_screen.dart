import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'buttons_screen.dart';
import 'data_table_screen.dart';
import 'display_screen.dart';
import 'inputs_screen.dart';
import 'navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.currentBrand,
    required this.currentBrightness,
    required this.onBrandChanged,
    required this.onBrightnessChanged,
    super.key,
  });
  final CkgocBrand currentBrand;
  final Brightness? currentBrightness;
  final ValueChanged<CkgocBrand> onBrandChanged;
  final ValueChanged<Brightness?> onBrightnessChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    const ButtonsScreen(),
    const InputsScreen(),
    const DisplayScreen(),
    const DataTableScreen(),
    const NavigationScreen(),
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
                icon: Icon(LucideIcons.navigation2),
                label: Text('Navigation'),
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
