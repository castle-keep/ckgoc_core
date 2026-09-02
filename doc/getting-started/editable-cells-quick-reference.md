# CKDataTable Editable Cells - Quick Reference

## Factory Constructors

### Text Field
```dart
CKEditableCell.textField({
  String? hint,
  String? label,
  int maxLines = 1,
  TextInputType? keyboardType,
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

### Dropdown
```dart
CKEditableCell.dropdown({
  List<DropdownMenuItem<dynamic>>? items,
  List<DropdownMenuItem<dynamic>> Function(Map<String, dynamic> row)? itemsBuilder,
  String? hint,
  String? label,
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

### Checkbox
```dart
CKEditableCell.checkbox({
  String? label,
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

### Switch
```dart
CKEditableCell.switch_({
  String? label,
  SwitchVariant? variant, // SwitchVariant.success or SwitchVariant.error
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

### Date Picker
```dart
CKEditableCell.datePicker({
  String? label,
  DateTime? firstDate,
  DateTime? lastDate,
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

### Custom
```dart
CKEditableCell({
  required Widget Function(
    BuildContext context,
    dynamic currentValue,
    ValueChanged<dynamic> onChanged,
    Map<String, dynamic> row,
    bool isActive,
    String? validationError,
  ) builder,
  String? Function(dynamic value, Map<String, dynamic> row)? validator,
})
```

## Common Validation Patterns

### Required Field
```dart
validator: (value, row) {
  if (value == null || value.toString().trim().isEmpty) {
    return 'This field is required';
  }
  return null;
}
```

### Conditional Required
```dart
validator: (value, row) {
  if (row['some_field'] == 'some_value') {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Required when some_field is some_value';
    }
  }
  return null;
}
```

### Email Format
```dart
validator: (value, row) {
  if (value == null || value.toString().isEmpty) return null;
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value.toString())) {
    return 'Invalid email format';
  }
  return null;
}
```

### Numeric Range
```dart
validator: (value, row) {
  if (value == null) return null;
  final num? number = num.tryParse(value.toString());
  if (number == null) return 'Must be a number';
  if (number < 0 || number > 100) {
    return 'Must be between 0 and 100';
  }
  return null;
}
```

### Length Validation
```dart
validator: (value, row) {
  if (value == null) return null;
  final str = value.toString();
  if (str.length < 3) return 'Must be at least 3 characters';
  if (str.length > 50) return 'Must be less than 50 characters';
  return null;
}
```

## Table Configuration

```dart
CKDataTable(
  columns: [/* ... */],
  rows: _rows,
  rowKey: 'id',
  
  // New API
  editableCells: {
    'field1': CKEditableCell.textField(/* ... */),
    'field2': CKEditableCell.dropdown(/* ... */),
    // ... more fields
  },
  onCellValueChanged: (rowKey, columnKey, newValue) {
    // Update your data
    setState(() {
      final rowIndex = _rows.indexWhere((r) => r['id'] == rowKey);
      if (rowIndex != -1) {
        _rows[rowIndex][columnKey] = newValue;
      }
    });
  },
)
```

## Dynamic Dropdown Options

```dart
'subcategory': CKEditableCell.dropdown(
  itemsBuilder: (row) {
    switch (row['category']) {
      case 'Electronics':
        return [
          DropdownMenuItem(value: 'Laptop', child: Text('Laptop')),
          DropdownMenuItem(value: 'Phone', child: Text('Phone')),
        ];
      case 'Furniture':
        return [
          DropdownMenuItem(value: 'Chair', child: Text('Chair')),
          DropdownMenuItem(value: 'Desk', child: Text('Desk')),
        ];
      default:
        return [];
    }
  },
),
```

## Side Effects on Value Change

```dart
void _handleCellValueChanged(dynamic rowKey, String columnKey, dynamic newValue) {
  setState(() {
    final rowIndex = _rows.indexWhere((row) => row['id'] == rowKey);
    if (rowIndex != -1) {
      _rows[rowIndex][columnKey] = newValue;
      
      // Trigger side effects
      if (columnKey == 'category') {
        // Clear subcategory when category changes
        _rows[rowIndex]['subcategory'] = null;
      }
      
      if (columnKey == 'type' && newValue == 'Internal') {
        // Clear fields not needed for internal type
        _rows[rowIndex]['external_field'] = null;
      }
    }
  });
}
```

## Tips

1. **Return null for valid values** - Only return error strings when validation fails
2. **Keep validators pure** - No side effects in validators
3. **Use itemsBuilder for dynamic options** - When dropdown options depend on row data
4. **Clear dependent fields** - In `onCellValueChanged`, clear fields that depend on changed values
5. **Provide helpful error messages** - Users should understand what's wrong and how to fix it
