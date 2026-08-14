import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';
import 'package:flutter/material.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_filter.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_column.dart';
import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_dropdown.dart';
import 'package:ckcoreui/src/components/buttons/ckcore_button.dart';

/// Filter overlay that appears below a column header.
/// The overlay width matches the column width it's anchored to.
class ColumnFilterOverlay extends StatefulWidget {
  const ColumnFilterOverlay({
    required this.column,
    required this.columnWidth,
    required this.onFilterApply,
    required this.onFilterClear,
    this.existingFilter,
    super.key,
  });

  final CKTableColumn column;
  final double columnWidth;
  final ValueChanged<CKTableFilter> onFilterApply;
  final VoidCallback onFilterClear;
  final CKTableFilter? existingFilter;

  @override
  State<ColumnFilterOverlay> createState() => _ColumnFilterOverlayState();
}

class _ColumnFilterOverlayState extends State<ColumnFilterOverlay> {
  late CKFilterOperator _selectedOperator;
  late TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _selectedOperator =
        widget.existingFilter?.operator ?? CKFilterOperator.equals;
    _valueController = TextEditingController(
      text: widget.existingFilter?.value?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _apply() {
    if (_valueController.text.trim().isEmpty) {
      return;
    }
    widget.onFilterApply(
      CKTableFilter(
        field: widget.column.key,
        operator: _selectedOperator,
        value: _valueController.text.trim(),
      ),
    );
    // overlay closed by parent OverlayEntry logic
  }

  void _clear() {
    widget.onFilterClear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final t = theme.typography;
    final r = theme.radius;

    return Material(
      child: Container(
        width: widget.columnWidth,
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(r.md),
          border: Border.all(color: c.outlineVariant, width: s.xxs / 2),
          boxShadow: theme.shadows.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(s.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter: ${widget.column.label}',
                    style: t.labelSm.copyWith(color: c.onSurfaceVariant),
                  ),
                  SizedBox(height: s.sm),
                  // Operator dropdown
                  CKDropdown<CKFilterOperator>(
                    hint: 'Select operator',
                    value: _selectedOperator,
                    items: CKFilterOperator.values
                        .map(
                          (op) => DropdownMenuItem(
                            value: op,
                            child: Text(op.label),
                          ),
                        )
                        .toList(),
                    onChanged: (op) {
                      if (op != null) {
                        setState(() => _selectedOperator = op);
                      }
                    },
                  ),
                  SizedBox(height: s.sm),
                  // Value input
                  CKTextField(
                    controller: _valueController,
                    hint: 'Enter value',
                  ),
                ],
              ),
            ),
            Divider(
              height: s.xxs / 2,
              thickness: s.xxs / 2,
              color: c.outlineVariant,
            ),
            // Action buttons
            Padding(
              padding: EdgeInsets.all(s.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CKButton(
                    variant: ButtonVariant.outline,
                    size: ButtonSize.sm,
                    onPressed: _clear,
                    child: const Text('Clear'),
                  ),
                  CKButton(
                    size: ButtonSize.sm,
                    onPressed: _apply,
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
