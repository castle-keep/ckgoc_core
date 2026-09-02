# CKDataTable - Custom Editable Inputs & Row-Aware Validation

This guide explains how to use CKDataTable's enhanced editable cell system with custom input widgets and row-aware validation.

## Overview

The new editable cell system provides:

1. **Custom Input Widgets**: Use different input types (text, dropdown, checkbox, switch, date picker) instead of only text fields
2. **Row-Aware Validation**: Validation rules that can access the complete row data to make decisions based on other cell values
3. **Active Cell Highlighting**: Visual feedback showing which cell is currently being edited
4. **Validation Error Display**: Inline error messages with visual indicators

## Basic Usage

### 1. Configure Editable Cells

Replace the old `editableColumns` parameter with `editableCells`:

```dart
CKDataTable(
  // ... other parameters
  editableCells: {
    'column_key': CKEditableCell.textField(
      hint: 'Enter value',
      validator: (value, row) {
        if (value == null || value.toString().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    ),
  },
  onCellValueChanged: (rowKey, columnKey, newValue) {
    // Handle the value change
    print('Row $rowKey, Column $columnKey changed to $newValue');
  },
)
```

### 2. Available Input Types

#### Text Field
```dart
'item': CKEditableCell.textField(
  hint: 'Enter item name',
  validator: (value, row) {
    if (value?.toString().trim().isEmpty ?? true) {
      return 'Item is required';
    }
    return null;
  },
),
```

#### Dropdown
```dart
'transfer_type': CKEditableCell.dropdown(
  items: const [
    DropdownMenuItem(value: 'Internal', child: Text('Internal')),
    DropdownMenuItem(value: 'External', child: Text('External')),
  ],
  hint: 'Select type',
  validator: (value, row) {
    if (value == null) {
      return 'Please select a type';
    }
    return null;
  },
),
```

#### Checkbox
```dart
'verified': CKEditableCell.checkbox(
  label: 'Verified',
  validator: (value, row) {
    if (row['status'] == 'Complete' && value != true) {
      return 'Must be verified when complete';
    }
    return null;
  },
),
```

#### Switch
```dart
'active': CKEditableCell.switch_(
  label: 'Active',
  variant: SwitchVariant.success, // Optional: success or error styling
),
```

#### Date Picker
```dart
'delivery_date': CKEditableCell.datePicker(
  label: 'Delivery Date',
  firstDate: DateTime.now(),
  validator: (value, row) {
    if (row['status'] == 'Shipped' && value == null) {
      return 'Delivery date required for shipped items';
    }
    return null;
  },
),
```

## Row-Aware Validation

The key feature is that validators receive both the **current value** and the **complete row data**:

```dart
validator: (value, row) {
  // Access other fields in the same row
  if (row['transfer_type'] == 'External') {
    if (value == null || value.toString().isEmpty) {
      return 'Required for external transfers';
    }
  }
  return null; // No error
}
```

### Example: Conditional Required Fields

```dart
editableCells: {
  // Transfer type dropdown
  'transfer_type': CKEditableCell.dropdown(
    items: const [
      DropdownMenuItem(value: 'Internal', child: Text('Internal')),
      DropdownMenuItem(value: 'External', child: Text('External')),
    ],
  ),
  
  // Courier: required only if transfer type is External
  'courier': CKEditableCell.dropdown(
    items: const [
      DropdownMenuItem(value: 'FedEx', child: Text('FedEx')),
      DropdownMenuItem(value: 'UPS', child: Text('UPS')),
      DropdownMenuItem(value: 'DHL', child: Text('DHL')),
    ],
    validator: (value, row) {
      if (row['transfer_type'] == 'External') {
        if (value == null || value.toString().isEmpty) {
          return 'Required for external transfers';
        }
      }
      return null;
    },
  ),
  
  // Tracking number: required only if transfer type is External
  'tracking_no': CKEditableCell.textField(
    hint: 'Enter tracking number',
    validator: (value, row) {
      if (row['transfer_type'] == 'External') {
        if (value == null || value.toString().isEmpty) {
          return 'Required for external transfers';
        }
        // Additional format validation
        if (value.toString().length < 8) {
          return 'Tracking number must be at least 8 characters';
        }
      }
      return null;
    },
  ),
}
```

## Dynamic Dropdown Options

You can also provide dropdown options dynamically based on row data:

```dart
'subcategory': CKEditableCell.dropdown(
  itemsBuilder: (row) {
    // Show different options based on the category field
    if (row['category'] == 'Electronics') {
      return [
        DropdownMenuItem(value: 'Laptop', child: Text('Laptop')),
        DropdownMenuItem(value: 'Phone', child: Text('Phone')),
      ];
    } else if (row['category'] == 'Furniture') {
      return [
        DropdownMenuItem(value: 'Chair', child: Text('Chair')),
        DropdownMenuItem(value: 'Desk', child: Text('Desk')),
      ];
    }
    return [];
  },
),
```

## Handling Value Changes

Use `onCellValueChanged` to update your data:

```dart
void _handleCellValueChanged(dynamic rowKey, String columnKey, dynamic newValue) {
  setState(() {
    final rowIndex = _rows.indexWhere((row) => row['id'] == rowKey);
    if (rowIndex != -1) {
      _rows[rowIndex][columnKey] = newValue;
      
      // Optional: trigger side effects
      if (columnKey == 'transfer_type' && newValue == 'Internal') {
        // Clear fields that are not needed for internal transfers
        _rows[rowIndex]['courier'] = '';
        _rows[rowIndex]['tracking_no'] = '';
      }
    }
  });
}
```

## Visual Feedback

The table automatically provides visual feedback:

1. **Active Cell Highlighting**: The currently focused cell has a border and subtle background
2. **Validation Errors**: Invalid cells show a red border and error message
3. **Smooth Transitions**: All visual changes are animated for better UX

## Migration from Old API

If you're using the old `editableColumns` API:

### Before (Old API)
```dart
CKDataTable(
  editableColumns: {'name', 'email', 'phone'},
  onCellChanged: (rowKey, columnKey, newValue) {
    // Handle change
  },
)
```

### After (New API)
```dart
CKDataTable(
  editableCells: {
    'name': CKEditableCell.textField(
      hint: 'Enter name',
      validator: (value, row) => /* ... */,
    ),
    'email': CKEditableCell.textField(
      hint: 'Enter email',
      keyboardType: TextInputType.emailAddress,
      validator: (value, row) => /* ... */,
    ),
    'phone': CKEditableCell.textField(
      hint: 'Enter phone',
      keyboardType: TextInputType.phone,
      validator: (value, row) => /* ... */,
    ),
  },
  onCellValueChanged: (rowKey, columnKey, newValue) {
    // Handle change
  },
)
```

The old API is deprecated but still supported for backward compatibility.

## Complete Example

See [editable_data_table_example.dart](../../example/lib/screens/editable_data_table_example.dart) for a complete working example demonstrating all features.

## Advanced: Custom Input Widgets

For complete control, use the custom builder:

```dart
'custom_field': CKEditableCell(
  builder: (context, value, onChanged, row, isActive, error) {
    return YourCustomWidget(
      value: value,
      onChanged: onChanged,
      // Use isActive to show focus state
      // Use error to show validation message
      // Use row to access other field values
    );
  },
  validator: (value, row) => /* ... */,
),
```

## Best Practices

1. **Keep Validators Pure**: Validators should not have side effects. Use `onCellValueChanged` for that.
2. **Provide Clear Error Messages**: Users should understand why validation failed.
3. **Use Appropriate Input Types**: Dropdowns for constrained choices, text fields for free-form input.
4. **Consider Mobile**: Ensure your custom widgets work well on small screens.
5. **Test Validation Logic**: Row-aware validation can be complex—test all combinations.
