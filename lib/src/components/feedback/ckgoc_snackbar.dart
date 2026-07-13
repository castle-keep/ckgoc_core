import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';
import 'package:ckgoc_core/src/components/feedback/ckgoc_toast.dart';

abstract final class CkgocSnackbar {
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
        content: CkgocToast(
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
