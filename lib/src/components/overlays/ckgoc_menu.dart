import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

// Contextual dropdown menu.
//
// TODO: Implement widget body.
class CkgocMenu extends StatelessWidget {
  const CkgocMenu({required this.trigger, required this.items, super.key});
  final Widget trigger;
  final List<CkgocMenuItem> items;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
