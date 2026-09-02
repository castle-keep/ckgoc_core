import 'package:flutter/material.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_dropdown.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_date_picker.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_checkbox.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_switch.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Configuration for an editable cell in [CKDataTable].
///
/// Defines how a cell should be rendered when editable, including:
/// - Custom input widget via [builder]
/// - Row-aware validation via [validator]
///
/// Use factory constructors for common input types:
/// - [CKEditableCell.textField] for text input
/// - [CKEditableCell.dropdown] for dropdown selection
/// - [CKEditableCell.checkbox] for boolean toggle
/// - [CKEditableCell.switch_] for switch toggle
/// - [CKEditableCell.datePicker] for date selection
class CKEditableCell {
  /// Creates a text field editable cell.
  ///
  /// Example:
  /// ```dart
  /// CKEditableCell.textField(
  ///   hint: 'Enter item name',
  ///   validator: (value, row) => value?.isEmpty ?? true ? 'Required' : null,
  /// )
  /// ```
  factory CKEditableCell.textField({
    String? hint,
    String? label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(dynamic value, Map<String, dynamic> row)? validator,
  }) {
    return CKEditableCell(
      builder: (context, currentValue, onChanged, row, isActive, error) {
        return Tooltip(
          message: error ?? '',
          preferBelow: false,
          child: CKTextField(
            value: currentValue?.toString() ?? '',
            hint: hint,
            label: label,
            maxLines: maxLines,
            keyboardType: keyboardType,
            onChanged: onChanged,
            // errorText: error,
            borderless: true,
            autoFocus: isActive,
          ),
        );
      },
      validator: validator,
    );
  }

  /// Creates a dropdown editable cell.
  ///
  /// The [items] can be static or dynamic based on row data using [itemsBuilder].
  ///
  /// Example with static items:
  /// ```dart
  /// CKEditableCell.dropdown(
  ///   items: const [
  ///     DropdownMenuItem(value: 'Internal', child: Text('Internal')),
  ///     DropdownMenuItem(value: 'External', child: Text('External')),
  ///   ],
  /// )
  /// ```
  ///
  /// Example with row-aware items:
  /// ```dart
  /// CKEditableCell.dropdown(
  ///   itemsBuilder: (row) {
  ///     // Show different options based on another field
  ///     if (row['category'] == 'A') {
  ///       return [DropdownMenuItem(value: 'X', child: Text('X'))];
  ///     }
  ///     return [DropdownMenuItem(value: 'Y', child: Text('Y'))];
  ///   },
  /// )
  /// ```
  factory CKEditableCell.dropdown({
    List<DropdownMenuItem<dynamic>>? items,
    List<DropdownMenuItem<dynamic>> Function(Map<String, dynamic> row)?
    itemsBuilder,
    String? hint,
    String? label,
    String? Function(dynamic value, Map<String, dynamic> row)? validator,
  }) {
    assert(
      items != null || itemsBuilder != null,
      'Either items or itemsBuilder must be provided',
    );

    return CKEditableCell(
      builder: (context, currentValue, onChanged, row, isActive, error) {
        final dropdownItems = itemsBuilder?.call(row) ?? items!;
        return Tooltip(
          message: error ?? '',
          preferBelow: false,
          child: CKDropdown<dynamic>(
            value: currentValue,
            items: dropdownItems,
            hint: hint,
            label: label,
            onChanged: (value) => onChanged(value),
            // errorText: error,
            borderless: true,
          ),
        );
      },
      validator: validator,
    );
  }

  /// Creates a checkbox editable cell.
  ///
  /// Example:
  /// ```dart
  /// CKEditableCell.checkbox(
  ///   label: 'Verified',
  ///   validator: (value, row) {
  ///     if (row['status'] == 'Complete' && value != true) {
  ///       return 'Must be verified when complete';
  ///     }
  ///     return null;
  ///   },
  /// )
  /// ```
  factory CKEditableCell.checkbox({
    String? label,
    String? Function(dynamic value, Map<String, dynamic> row)? validator,
  }) {
    return CKEditableCell(
      builder: (context, currentValue, onChanged, row, isActive, error) {
        return Tooltip(
          message: error ?? '',
          preferBelow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CKCheckbox(
                    value: currentValue == true,
                    onChanged: (value) => onChanged(value),
                  ),
                  if (label != null) ...[
                    const SizedBox(width: 8),
                    Flexible(child: Text(label)),
                  ],
                ],
              ),
            ],
          ),
        );
      },
      validator: validator,
    );
  }

  /// Creates a switch editable cell.
  ///
  /// Use [variant] to specify success (green) or error (red) styling.
  /// Omit [variant] for the default neutral styling.
  ///
  /// Example:
  /// ```dart
  /// CKEditableCell.switch_(
  ///   label: 'Active',
  /// )
  /// ```
  factory CKEditableCell.switch_({
    String? label,
    SwitchVariant? variant,
    String? Function(dynamic value, Map<String, dynamic> row)? validator,
  }) {
    return CKEditableCell(
      builder: (context, currentValue, onChanged, row, isActive, error) {
        final switchWidget = variant == null
            ? CKSwitch(
                value: currentValue == true,
                onChanged: (value) => onChanged(value),
              )
            : switch (variant) {
                SwitchVariant.success => CKSwitch.success(
                  value: currentValue == true,
                  onChanged: (value) => onChanged(value),
                ),
                SwitchVariant.error => CKSwitch.error(
                  value: currentValue == true,
                  onChanged: (value) => onChanged(value),
                ),
              };

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            switchWidget,
            if (label != null) ...[
              const SizedBox(width: 8),
              Flexible(child: Text(label)),
            ],
          ],
        );
      },
      validator: validator,
    );
  }

  /// Creates a date picker editable cell.
  ///
  /// Example:
  /// ```dart
  /// CKEditableCell.datePicker(
  ///   label: 'Delivery Date',
  ///   firstDate: DateTime.now(),
  ///   validator: (value, row) {
  ///     if (row['status'] == 'Shipped' && value == null) {
  ///       return 'Delivery date required for shipped items';
  ///     }
  ///     return null;
  ///   },
  /// )
  /// ```
  factory CKEditableCell.datePicker({
    String? label,
    DateTime? firstDate,
    DateTime? lastDate,
    String? Function(dynamic value, Map<String, dynamic> row)? validator,
  }) {
    return CKEditableCell(
      builder: (context, currentValue, onChanged, row, isActive, error) {
        return Tooltip(
          message: error ?? '',
          preferBelow: false,
          child: CKDatePicker(
            value: currentValue is DateTime ? currentValue : null,
            onChanged: onChanged,
            label: label,
            firstDate: firstDate,
            lastDate: lastDate,
          ),
        );
      },
      validator: validator,
    );
  }

  /// Creates a custom editable cell with a builder function.
  ///
  /// The [builder] receives:
  /// - [context]: Build context
  /// - [currentValue]: Current cell value
  /// - [onChanged]: Callback to update the value
  /// - [row]: Complete row data for context-aware inputs
  /// - [isActive]: Whether this cell is currently focused/active
  /// - [validationError]: Current validation error message, if any
  const CKEditableCell({required this.builder, this.validator});

  /// Builder that creates the input widget for this cell.
  final Widget Function(
    BuildContext context,
    dynamic currentValue,
    ValueChanged<dynamic> onChanged,
    Map<String, dynamic> row,
    bool isActive,
    String? validationError,
  )
  builder;

  /// Validator that can access the full row for context-aware validation.
  ///
  /// Example: Require a field only when another field has a specific value:
  /// ```dart
  /// validator: (value, row) {
  ///   if (row['type'] == 'External' && (value == null || value.isEmpty)) {
  ///     return 'Required for external transfers';
  ///   }
  ///   return null;
  /// }
  /// ```
  final String? Function(dynamic value, Map<String, dynamic> row)? validator;
}
