import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// List tile used by list views and selection lists.
///
/// TODO: implement rendering body.
class CKListTile extends StatelessWidget {
  const CKListTile({
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckcoreTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}

/// Deprecated: Use [CKListTile] instead.
@Deprecated('Use CKListTile instead')
typedef ckcorelistTile = CKListTile;
