import 'package:flutter/material.dart';

// Registration screen layout shell.
// TODO: Implement layout. See docs/templates/ for specification.
class RegisterTemplate extends StatelessWidget {
  const RegisterTemplate({
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
