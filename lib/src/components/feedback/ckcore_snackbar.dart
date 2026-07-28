import 'package:flutter/material.dart';
import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/feedback/ckcore_toast.dart';

abstract final class CKSnackbar {
  static void show(
    BuildContext context,
    String message, {
    ToastVariant variant = ToastVariant.defaultToast,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: CKToast(
          message: message,
          variant: variant,
          onDismiss: onDismiss ?? messenger.hideCurrentSnackBar,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

/// Deprecated: Use [CKSnackbar] instead.
@Deprecated('Use CKSnackbar instead')
typedef CKCoreUISnackbar = CKSnackbar;
