import 'package:flutter/material.dart';

// Create / new record screen layout.
// TODO: Implement layout. See docs/templates/ for specification.
class CreateTemplate extends StatelessWidget {
  const CreateTemplate({
    required this.form,
    super.key,
    this.appBar,
    this.actions,
  });
  final Widget? appBar;
  final Widget form;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
