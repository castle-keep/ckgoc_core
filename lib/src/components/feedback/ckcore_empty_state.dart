import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// TODO: Implement widget body.
class CKEmptyState extends StatelessWidget {
  const CKEmptyState({
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
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKEmptyState] instead.
@Deprecated('Use CKEmptyState instead')
typedef ckcoreemptyState = CKEmptyState;
