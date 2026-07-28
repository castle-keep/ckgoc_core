import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// Contextual tooltip on long-press or hover.
//
// TODO: Implement widget body.
/// Contextual tooltip on long-press or hover.
///
/// TODO: implement the display logic.
class CKTooltip extends StatelessWidget {
  const CKTooltip({required this.message, required this.child, super.key});
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
