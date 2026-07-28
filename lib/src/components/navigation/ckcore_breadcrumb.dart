import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

// Hierarchical breadcrumb navigation trail.
//
// TODO: Implement widget body.
class CKBreadcrumb extends StatelessWidget {
  const CKBreadcrumb({required this.items, super.key});
  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
