import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/feedback/ckcore_toast.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Shows a [CKToast] as transient feedback.
///
/// * [CKSnackbarPosition.top] (default) floats at the top of the window, above
///   everything else in the app (headers, side navigation, app bars). It is
///   drawn in the root overlay, so it does not depend on any Scaffold's size.
///   It spans the window (with a small margin) unless you pass a [width],
///   in which case it is centered at that width.
/// * [CKSnackbarPosition.bottom] uses a floating [SnackBar] through the
///   [ScaffoldMessenger].
///
/// Showing a new snackbar replaces the current one. [width] only applies to the
/// top position.
abstract final class CKSnackbar {
  static _TopSnackbarHandle? _top;

  static void show(
    BuildContext context,
    String message, {
    ToastVariant variant = ToastVariant.defaultToast,
    Duration duration = const Duration(seconds: 3),
    CKSnackbarPosition position = CKSnackbarPosition.top,
    VoidCallback? onDismiss,
    double? width,
  }) {
    if (position == CKSnackbarPosition.top) {
      final overlay = Overlay.maybeOf(context, rootOverlay: true);
      if (overlay != null) {
        _showTop(
          context,
          overlay,
          message,
          variant,
          duration,
          onDismiss,
          width,
        );
        return;
      }
    }
    _showBottom(context, message, variant, duration, onDismiss);
  }

  /// Dismisses the snackbar that is currently showing, if any.
  static void hide() => _top?.dismiss();

  static void _showBottom(
    BuildContext context,
    String message,
    ToastVariant variant,
    Duration duration,
    VoidCallback? onDismiss,
  ) {
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

  static void _showTop(
    BuildContext context,
    OverlayState overlay,
    String message,
    ToastVariant variant,
    Duration duration,
    VoidCallback? onDismiss,
    double? width,
  ) {
    _top?.dismiss(immediately: true);

    final theme = context.ckcoreTheme;
    final handle = _TopSnackbarHandle();
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top: MediaQuery.viewPaddingOf(overlayContext).top + 12,
        left: 12,
        right: 12,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width ?? double.infinity),
            // The overlay can sit above the theme scope, so pass the theme in.
            child: CkcoreuiTheme(
              data: theme,
              child: _TopSnackbar(
                message: message,
                variant: variant,
                duration: duration,
                handle: handle,
                onClosed: () {
                  entry.remove();
                  if (identical(_top, handle)) _top = null;
                },
                onDismiss: onDismiss,
              ),
            ),
          ),
        ),
      ),
    );
    _top = handle;
    overlay.insert(entry);
  }
}

class _TopSnackbarHandle {
  void Function({bool immediately})? _dismiss;
  void dismiss({bool immediately = false}) =>
      _dismiss?.call(immediately: immediately);
}

class _TopSnackbar extends StatefulWidget {
  const _TopSnackbar({
    required this.message,
    required this.variant,
    required this.duration,
    required this.handle,
    required this.onClosed,
    this.onDismiss,
  });

  final String message;
  final ToastVariant variant;
  final Duration duration;
  final _TopSnackbarHandle handle;
  final VoidCallback onClosed;
  final VoidCallback? onDismiss;

  @override
  State<_TopSnackbar> createState() => _TopSnackbarState();
}

class _TopSnackbarState extends State<_TopSnackbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    reverseDuration: const Duration(milliseconds: 160),
  );
  Timer? _timer;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    widget.handle._dismiss = _dismiss;
    _timer = Timer(widget.duration, _dismiss);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.status == AnimationStatus.dismissed && !_closing) {
      if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
    }
  }

  Future<void> _dismiss({bool immediately = false}) async {
    if (_closing) return;
    _closing = true;
    _timer?.cancel();
    if (!immediately && mounted && _controller.value > 0) {
      await _controller.reverse();
    }
    widget.onClosed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.handle._dismiss = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    return Material(
      type: MaterialType.transparency,
      child: Semantics(
        liveRegion: true,
        child: FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, -0.4),
              end: Offset.zero,
            ).animate(curved),
            child: CKToast(
              message: widget.message,
              variant: widget.variant,
              onDismiss: () {
                widget.onDismiss?.call();
                _dismiss();
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKSnackbar] instead.
@Deprecated('Use CKSnackbar instead')
typedef CKCoreUISnackbar = CKSnackbar;
