import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// Placeholder shimmer animation while content loads.
// TODO: Implement shimmer/skeleton loading widget.
class CKSkeleton extends StatelessWidget {
  const CKSkeleton({
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
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKSkeleton] instead.
@Deprecated('Use CKSkeleton instead')
typedef ckcoreskeleton = CKSkeleton;
