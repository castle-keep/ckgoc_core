import 'package:flutter/material.dart';

// Forgot-password screen layout shell.
// TODO: Implement layout. See docs/templates/ for specification.
class ForgotPasswordTemplate extends StatelessWidget {
  const ForgotPasswordTemplate({
    required this.body,
    super.key,
    this.header,
    this.footer,
  });
  final Widget? header;
  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
