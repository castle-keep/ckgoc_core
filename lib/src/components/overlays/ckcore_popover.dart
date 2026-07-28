import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// Popover panel anchored to a trigger widget.
//
// TODO: Implement widget body.
/// Popover panel anchored to a trigger widget.
///
/// TODO: implement interactive popover layout.
class CKPopover extends StatelessWidget {
  const CKPopover({required this.trigger, required this.content, super.key});
  final Widget trigger;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
