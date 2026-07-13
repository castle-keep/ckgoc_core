import 'package:flutter/material.dart';

// Full-screen empty state layout.
// TODO: Implement layout. See docs/templates/ for specification.
class EmptyTemplate extends StatelessWidget {
  const EmptyTemplate({
    required this.title,
    super.key,
    this.illustration,
    this.description,
    this.action,
  });
  final Widget? illustration;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
