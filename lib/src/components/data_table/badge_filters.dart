import 'package:flutter/material.dart';
import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/display/ckcore_badge.dart';
import 'package:ckcoreui/src/components/data_table/ckcore_table_column.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_dropdown.dart';

/// Widget that renders a dropdown filter for a badge column.
class BadgeColumnFilter extends StatelessWidget {
  const BadgeColumnFilter({
    required this.column,
    required this.availableVariants,
    required this.selectedVariants,
    required this.onChanged,
    super.key,
  });

  final CKTableColumn column;
  final Set<dynamic> availableVariants;
  final Set<dynamic> selectedVariants;
  final ValueChanged<Set<dynamic>> onChanged;

  @override
  Widget build(BuildContext context) {
    if (availableVariants.isEmpty) {
      return const SizedBox.shrink();
    }

    // Convert to single value (first selected or null for "all")
    final selectedValue = selectedVariants.isEmpty
        ? null
        : selectedVariants.first;

    return SizedBox(
      width: 180,
      child: CKDropdown<BadgeVariant>(
        hint: '${column.label} Filter',
        value: selectedValue as BadgeVariant?,
        items: [
          DropdownMenuItem<BadgeVariant>(
            value: null,
            child: Text('All ${column.label}'),
          ),
          for (final variant in availableVariants)
            if (variant is BadgeVariant)
              DropdownMenuItem<BadgeVariant>(
                value: variant,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CKBadge(label: _variantLabel(variant), variant: variant),
                  ],
                ),
              ),
        ],
        onChanged: (value) {
          if (value == null) {
            onChanged({});
          } else {
            onChanged({value});
          }
        },
      ),
    );
  }

  String _variantLabel(BadgeVariant v) => switch (v) {
    BadgeVariant.defaultFill => 'Default',
    BadgeVariant.primary => 'Primary',
    BadgeVariant.success => 'Success',
    BadgeVariant.warning => 'Warning',
    BadgeVariant.error => 'Error',
    BadgeVariant.info => 'Info',
    BadgeVariant.draft => 'Draft',
    BadgeVariant.live => 'Live',
    BadgeVariant.newBadge => 'New',
    BadgeVariant.beta => 'Beta',
    BadgeVariant.pro => 'Pro',
    BadgeVariant.outline => 'Outline',
    BadgeVariant.outlineSuccess => 'Outline Success',
    BadgeVariant.outlineError => 'Outline Error',
    BadgeVariant.online => 'Online',
    BadgeVariant.away => 'Away',
    BadgeVariant.busy => 'Busy',
    BadgeVariant.offline => 'Offline',
  };
}
