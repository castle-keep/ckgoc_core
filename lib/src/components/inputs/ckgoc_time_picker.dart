import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// Time picker trigger + field.
//
// TODO: Implement widget body.
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
