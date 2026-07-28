import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Time picker trigger and display field.
///
/// Tappable control that opens a time picker and reports the selection via
/// [onChanged]. Use [label] to provide an accessible label for the control.
class CKTimePicker extends StatelessWidget {
  const CKTimePicker({this.value, this.onChanged, this.label, super.key});
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKTimePicker] instead.
@Deprecated('Use CKTimePicker instead')
typedef ckcoretimePicker = CKTimePicker;
