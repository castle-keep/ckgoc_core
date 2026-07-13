import 'package:flutter/material.dart';

// Full-screen offline / no-connection state layout.
// TODO: Implement layout. See docs/templates/ for specification.
class OfflineTemplate extends StatelessWidget {
  const OfflineTemplate({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
