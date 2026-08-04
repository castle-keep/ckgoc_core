import 'package:ckcoreui/src/themes/themes.dart';
import 'package:ckcoreui/src/components/components.dart';
import 'package:flutter/material.dart';

//TODO: this is a working progress
class CKLoadingState extends StatelessWidget {
  const CKLoadingState({
    this.message,
    this.loaderSize,
    this.variant = LoaderType.circular,
    super.key,
  });
  final LoaderType variant;
  final String? message;
  // Defaults to spacing.s40 (40dp) — const required for default param value
  final double? loaderSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final colors = theme.colors;
    final resolvedSize = loaderSize ?? spacing.s40;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CKLoader(size: resolvedSize, type: variant),
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

/// Deprecated: Use [CKLoadingState] instead.
@Deprecated('Use CKLoadingState instead')
typedef ckcoreloadingState = CKLoadingState;
