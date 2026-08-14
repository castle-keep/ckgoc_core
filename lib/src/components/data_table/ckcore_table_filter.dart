import 'package:ckcoreui/src/components/component_enums.dart';

/// Represents a single filter condition for a [CKDataTable] column.
///
/// The table collects filter information but does NOT apply filtering.
/// The parent/consumer is responsible for deciding how to use these filters
/// (AND logic, OR logic, API parameters, custom business logic, etc.).
class CKTableFilter {
  const CKTableFilter({
    required this.field,
    required this.operator,
    required this.value,
  });

  /// The column key that this filter applies to.
  final String field;

  /// The operator to use for comparison.
  final CKFilterOperator operator;

  /// The value to compare against.
  final dynamic value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CKTableFilter &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          operator == other.operator &&
          value == other.value;

  @override
  int get hashCode => field.hashCode ^ operator.hashCode ^ value.hashCode;

  @override
  String toString() =>
      'CKTableFilter(field: $field, operator: $operator, value: $value)';
}
