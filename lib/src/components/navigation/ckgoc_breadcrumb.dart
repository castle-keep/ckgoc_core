import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

// Hierarchical breadcrumb navigation trail.
//
// TODO: Implement widget body.
class CkgocBreadcrumb extends StatelessWidget {
  const CkgocBreadcrumb({required this.items, super.key});
  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
