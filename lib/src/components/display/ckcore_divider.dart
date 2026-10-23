import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Thin separator line, horizontal by default.
///
/// A vertical divider fills the height it is given, so place it in a
/// bounded-height parent (for example a `SizedBox` or an `IntrinsicHeight`
/// row).
class CKDivider extends StatelessWidget {
  const CKDivider({this.direction = Axis.horizontal, super.key});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final colors = context.ckcoreTheme.colors;

    return direction == Axis.horizontal
        ? Divider(height: 1, thickness: 1, color: colors.outlineVariant)
        : VerticalDivider(width: 1, thickness: 1, color: colors.outlineVariant);
  }
}

/// Deprecated: Use [CKDivider] instead.
@Deprecated('Use CKDivider instead')
typedef ckcoredivider = CKDivider;
