import 'package:flutter/material.dart';

// List / index screen layout.
// TODO: Implement layout. See docs/templates/ for specification.
class ListTemplate extends StatelessWidget {
  const ListTemplate({
    required this.list,
    super.key,
    this.toolbar,
    this.filters,
    this.pagination,
    this.floatingAction,
  });
  final Widget? toolbar;
  final Widget? filters;
  final Widget list;
  final Widget? pagination;
  final Widget? floatingAction;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
