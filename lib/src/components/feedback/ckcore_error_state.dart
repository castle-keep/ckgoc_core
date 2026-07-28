import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// TODO: Implement widget body
class CKErrorState extends StatelessWidget {
  const CKErrorState({
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
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKErrorState] instead.
@Deprecated('Use CKErrorState instead')
typedef ckcoreerrorState = CKErrorState;
