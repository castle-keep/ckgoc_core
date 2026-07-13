import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// TODO: Implement widget body
class CkgocErrorState extends StatelessWidget {
  const CkgocErrorState({
    required this.title,
    this.description,
    this.onRetry,
    super.key,
  });
  final String title;
  final String? description;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
