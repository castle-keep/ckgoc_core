import 'package:ckgoc_core/src/components/feedback/ckgoc_loader.dart';
import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

class CkgocLoadingState extends StatelessWidget {
  const CkgocLoadingState({this.message, this.loaderSize, super.key});
  final String? message;
  // Defaults to spacing.s40 (40dp) — const required for default param value
  final double? loaderSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final colors = theme.colors;
    final resolvedSize = loaderSize ?? spacing.s40;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CkgocLoader(size: resolvedSize),
          if (message != null) ...[
            SizedBox(height: spacing.md),
            Text(
              message!,
              style: typography.textSm.copyWith(color: colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
