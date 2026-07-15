import 'package:flutter/material.dart';

/// Record detail / view screen layout.
///
/// TODO: Implement layout. See docs/templates/ for specification.
class DetailTemplate extends StatelessWidget {
  const DetailTemplate({
    required this.header,
    required this.body,
    super.key,
    this.appBar,
    this.actions,
  });
  final Widget? appBar;
  final Widget header;
  final Widget body;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
