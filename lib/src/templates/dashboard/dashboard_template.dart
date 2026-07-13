import 'package:flutter/material.dart';

// Dashboard layout.
// TODO: Implement layout. See docs/templates/ for specification.
class DashboardTemplate extends StatelessWidget {
  const DashboardTemplate({
    required this.content,
    super.key,
    this.sidebar,
    this.topBar,
  });
  final Widget? sidebar;
  final Widget? topBar;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
