import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';
import 'buttons_screen.dart';
import 'data_table_screen.dart';
import 'display_screen.dart';
import 'feedback_screen.dart';
import 'inputs_screen.dart';
import 'navigation_screen.dart';
import 'overlays_screen.dart';
import 'templates_screen.dart';
import 'tokens_screen.dart';
import 'layout_example_screen.dart';

class HomeScreen extends StatefulWidget {
  final ckcoreBrand currentBrand;
  final Brightness? currentBrightness;
  final ValueChanged<ckcoreBrand> onBrandChanged;
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
    const LayoutExampleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: const Text('Company UI Showcase'),
        actions: [
          // Brand switcher
          DropdownButton<ckcoreBrand>(
            value: widget.currentBrand,
            underline: const SizedBox.shrink(),
            items: ckcoreBrand.values
                .map(
                  (b) => DropdownMenuItem(value: b, child: Text(b.displayName)),
                )
                .toList(),
            onChanged: (b) {
              if (b != null) widget.onBrandChanged(b);
            },
          ),
          const SizedBox(width: 8),
          // Brightness toggle using CKSwitch
          CKSwitch(
            value: widget.currentBrightness == Brightness.dark,
            onChanged: (isDark) {
              widget.onBrightnessChanged(
                isDark ? Brightness.dark : Brightness.light,
              );
            },
          ),
          Text(
            widget.currentBrightness == Brightness.dark ? 'Dark' : 'Light',
            style: theme.typography.textXs,
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
              NavigationRailDestination(
                icon: Icon(LucideIcons.grid),
                label: Text('Layout'),
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
