import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

// Showcase screen for Templates components.
// TODO: Add component demos as widgets are implemented.
class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Center(
      child: Text('Templates — coming soon', style: theme.typography.displaySm),
    );
  }
}
