import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

// Vertical navigation rail for tablet / desktop.
//
// TODO: Implement widget body.
class CkgocNavigationRail extends StatelessWidget {
  const CkgocNavigationRail({
    required this.selectedIndex,
    required this.items,
    this.onDestinationSelected,
    super.key,
  });
  final int selectedIndex;
  final List<CkgocNavItem> items;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
