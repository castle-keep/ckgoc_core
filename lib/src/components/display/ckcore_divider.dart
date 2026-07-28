import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// TODO: Implement widget body.
class CKDivider extends StatelessWidget {
  const CKDivider({this.direction = Axis.horizontal, super.key});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKDivider] instead.
@Deprecated('Use CKDivider instead')
typedef ckcoredivider = CKDivider;
