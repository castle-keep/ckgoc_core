import 'package:flutter/material.dart';

// Full-screen error state layout.
// TODO: Implement layout. See docs/templates/ for specification.
class ErrorTemplate extends StatelessWidget {
  const ErrorTemplate({
    required this.title,
    super.key,
    this.description,
    this.onRetry,
  });
  final String title;
  final String? description;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
