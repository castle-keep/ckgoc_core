import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// TODO: Implement widget body.
class CkgocEmptyState extends StatelessWidget {
  const CkgocEmptyState({
    required this.title,
    this.description,
    this.illustration,
    this.action,
    super.key,
  });
  final String title;
  final String? description;
  final Widget? illustration;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
