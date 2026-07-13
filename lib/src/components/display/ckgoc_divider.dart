import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

// TODO: Implement widget body.
class CkgocDivider extends StatelessWidget {
  const CkgocDivider({this.direction = Axis.horizontal, super.key});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = context.ckgocTheme;
    // TODO: implement
    return const SizedBox.shrink();
  }
}
