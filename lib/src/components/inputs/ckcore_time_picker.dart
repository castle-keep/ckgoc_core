import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';

/// Time picker trigger and display field.
///
/// Tappable control that opens a time picker and reports the selection via
/// [onChanged]. Use [label] to provide an accessible label for the control.
///
/// Works controlled (pass [value] and update it in [onChanged]) or
/// uncontrolled (it remembers the last pick).
class CKTimePicker extends StatefulWidget {
  const CKTimePicker({
    this.value,
    this.onChanged,
    this.label,
    this.validator,
    this.isRequired = false,
    super.key,
  });
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final String? label;
  final String? Function(TimeOfDay?)? validator;
  final bool isRequired;

  @override
  State<CKTimePicker> createState() => _CKTimePickerState();
}

class _CKTimePickerState extends State<CKTimePicker> {
  TimeOfDay? _picked;
  String? _error;

  TimeOfDay? get _effective => widget.value ?? _picked;

  Future<void> _open() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _effective ?? TimeOfDay.now(),
    );
    if (!mounted) return;
    setState(() {
      _picked = result ?? _picked;
      _error = _validate(result ?? _effective);
    });
    if (result != null) widget.onChanged?.call(result);
  }

  String? _validate(TimeOfDay? time) {
    if (time == null) return widget.isRequired ? 'This field is required' : null;
    return widget.validator?.call(time);
  }

  @override
  Widget build(BuildContext context) {
    final time = _effective;
    return CKTextField(
      value: time == null
          ? ''
          : MaterialLocalizations.of(context).formatTimeOfDay(time),
      readOnly: true,
      onTap: _open,
      label: widget.label,
      hint: 'Pick a time',
      errorText: _error,
      isRequired: widget.isRequired,
      trailing: Icon(
        LucideIcons.clock,
        size: context.ckcoreTheme.spacing.lg - 4,
      ),
    );
  }
}

/// Deprecated: Use [CKTimePicker] instead.
@Deprecated('Use CKTimePicker instead')
typedef ckcoretimePicker = CKTimePicker;
