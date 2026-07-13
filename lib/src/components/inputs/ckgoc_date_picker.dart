import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// Date picker trigger + field.
//
// TODO: Implement widget body.
class CkgocDatePicker extends StatelessWidget {
  const CkgocDatePicker({
    this.value,
    this.onChanged,
    this.label,
    this.firstDate,
    this.lastDate,
    super.key,
  });
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? label;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
