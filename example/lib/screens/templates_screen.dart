import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

// Showcase screen for Templates components.
// TODO: Add component demos as widgets are implemented.
class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    return Center(
      child: Text('Templates — coming soon', style: theme.typography.displaySm),
    );
  }
}
