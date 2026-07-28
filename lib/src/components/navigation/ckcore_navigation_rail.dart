import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

// Vertical navigation rail for tablet / desktop.
//
// TODO: Implement widget body.
class CKNavigationRail extends StatelessWidget {
  const CKNavigationRail({
    required this.selectedIndex,
    required this.items,
    this.onDestinationSelected,
    super.key,
  });
  final int selectedIndex;
  final List<CKNavItem> items;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
