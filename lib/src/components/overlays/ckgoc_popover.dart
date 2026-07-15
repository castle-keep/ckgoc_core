import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// Popover panel anchored to a trigger widget.
//
// TODO: Implement widget body.
/// Popover panel anchored to a trigger widget.
///
/// TODO: implement interactive popover layout.
class CkgocPopover extends StatelessWidget {
  const CkgocPopover({required this.trigger, required this.content, super.key});
  final Widget trigger;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
