import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// Placeholder shimmer animation while content loads.
// TODO: Implement shimmer/skeleton loading widget.
class CkgocSkeleton extends StatelessWidget {
  const CkgocSkeleton({
    required this.width,
    required this.height,
    this.borderRadius,
    super.key,
  });
  final double width;
  final double height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
