import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// Time picker trigger and display field.
///
/// Tappable control that opens a time picker and reports the selection via
/// [onChanged]. Use [label] to provide an accessible label for the control.
class CkgocTimePicker extends StatelessWidget {
  const CkgocTimePicker({this.value, this.onChanged, this.label, super.key});
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
