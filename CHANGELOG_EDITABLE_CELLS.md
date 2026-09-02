# CKDataTable Enhancement Summary

## Changes Made

### 1. New Core Class: `CKEditableCell`
**File**: `lib/src/components/data_table/ckcore_editable_cell.dart`

A new configuration class that defines how editable cells should render and validate:

- **Builder Function**: Creates custom input widgets for each cell
- **Row-Aware Validator**: Validates values with access to the complete row data
- **Factory Constructors**: Convenient constructors for common input types:
  - `CKEditableCell.textField()` - Text input with validation
  - `CKEditableCell.dropdown()` - Single selection dropdown (supports static or dynamic options)
  - `CKEditableCell.checkbox()` - Boolean toggle with label
  - `CKEditableCell.switch_()` - Switch toggle (supports success/error variants)
  - `CKEditableCell.datePicker()` - Date selection

### 2. Enhanced `CKDataTable`
**File**: `lib/src/components/data_table/ckcore_data_table.dart`

#### New Parameters
- `editableCells` (Map<String, CKEditableCell>?) - Replaces `editableColumns` with full configuration
- `onCellValueChanged` - Clearer naming for cell change callback

#### Deprecated Parameters (kept for backward compatibility)
- `editableColumns` - Use `editableCells` instead
- `onCellChanged` - Use `onCellValueChanged` instead

#### New State Management
- Active cell tracking (`_activeCellRowKey`, `_activeCellColumnKey`)
- Validation error storage (`_validationErrors`)
- Automatic revalidation when rows or cells change

#### New Methods
- `_handleCellChanged()` - Validates and updates cell values
- `_setActiveCell()` / `_clearActiveCell()` - Manages focus state
- `_revalidateAllCells()` - Revalidates all editable cells
- `_getValidationError()` - Retrieves validation error for a cell
- `_isCellActive()` - Checks if a cell is currently active

### 3. Updated `DataRowWidget`
**File**: `lib/src/components/data_table/row.dart`

#### New Parameters
- `editableCells` - Map of editable cell configurations
- `onCellValueChanged` - New cell change callback
- `getValidationError` - Function to retrieve validation errors
- `isCellActive` - Function to check active state
- `onCellFocusChanged` - Callback when cell focus changes

### 4. Enhanced `TableCellWidget`
**File**: `lib/src/components/data_table/cell.dart`

#### New Parameters
- `editableCell` - Configuration for editable cell
- `onCellValueChanged` - Cell value change callback
- `validationError` - Current validation error message
- `isActive` - Whether the cell is currently focused
- `onFocusChanged` - Focus change callback

#### New Widget: `FocusableEditableCell`
A wrapper that provides:
- Visual highlighting when active (border + background)
- Error state indication (red border + background)
- Focus management
- Smooth animations for state transitions

### 5. Enhanced `CKTextField`
**File**: `lib/src/components/inputs/ckcore_text_field.dart`

#### New Feature
- Added `value` parameter for controlled text input without external controller
- Automatic internal controller creation when `value` is provided
- Maintains backward compatibility with existing `controller` parameter

### 6. Documentation
**Files**:
- `doc/getting-started/editable-data-table-custom-inputs.md` - Comprehensive guide
- `example/lib/screens/editable_data_table_example.dart` - Working example

## Key Features

### 1. Custom Input Widgets
Cells can now use any input type:
```dart
editableCells: {
  'name': CKEditableCell.textField(hint: 'Name'),
  'type': CKEditableCell.dropdown(items: [...]),
  'verified': CKEditableCell.checkbox(label: 'Verified'),
  'active': CKEditableCell.switch_(),
  'date': CKEditableCell.datePicker(),
}
```

### 2. Row-Aware Validation
Validators receive both the value and the complete row:
```dart
'courier': CKEditableCell.textField(
  validator: (value, row) {
    // Validation depends on another field
    if (row['transfer_type'] == 'External' && value?.isEmpty == true) {
      return 'Required for external transfers';
    }
    return null;
  },
),
```

### 3. Active Cell Highlighting
- Focused cells show a colored border and subtle background
- Invalid cells show error styling
- Smooth animated transitions

### 4. Validation Error Display
- Inline error messages below input widgets
- Visual indicators (red border/background)
- Automatic revalidation when dependencies change

## Migration Path

### Old API (Deprecated but still supported)
```dart
CKDataTable(
  editableColumns: {'name', 'email'},
  onCellChanged: (rowKey, columnKey, value) { },
)
```

### New API
```dart
CKDataTable(
  editableCells: {
    'name': CKEditableCell.textField(
      validator: (value, row) => /* ... */,
    ),
    'email': CKEditableCell.textField(
      keyboardType: TextInputType.emailAddress,
      validator: (value, row) => /* ... */,
    ),
  },
  onCellValueChanged: (rowKey, columnKey, value) { },
)
```

## Backward Compatibility

All changes are backward compatible:
- Old `editableColumns` + `onCellChanged` still work
- New features are opt-in via `editableCells` + `onCellValueChanged`
- Both systems can coexist (though not recommended)

## Testing Recommendations

1. **Basic Functionality**: Test each input type (text, dropdown, checkbox, switch)
2. **Validation**: Test validation rules, especially row-aware rules
3. **Focus Management**: Verify active cell highlighting works correctly
4. **Error Display**: Ensure validation errors display properly
5. **Edge Cases**: 
   - Empty values
   - Invalid values
   - Changing dependencies (e.g., changing transfer_type)
   - Multiple cells editing simultaneously
   - Rapid value changes

## Example Use Case

The example demonstrates an item transfer table where validation rules depend on the transfer type:

- **Item** & **Destination**: Always required
- **Transfer Type**: Dropdown (Internal/External)
- **Courier**: Required only if External
- **Tracking No.**: Required only if External
- **Verified**: Boolean checkbox

When the user changes Transfer Type from External to Internal, the Courier and Tracking No. fields no longer show validation errors.
