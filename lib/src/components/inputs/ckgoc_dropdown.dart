import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// Single-selection dropdown. Stateless — value controlled externally.
//
// TODO: Implement widget body.
class CkgocDropdown<T> extends StatelessWidget {
  const CkgocDropdown({
    required this.items,
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.errorText,
  });
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
