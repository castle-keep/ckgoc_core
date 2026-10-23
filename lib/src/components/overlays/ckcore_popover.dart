import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Popover panel anchored to a trigger widget.
///
/// Tapping the [trigger] toggles the [content] panel below it. Tapping outside
/// the panel closes it.
class CKPopover extends StatefulWidget {
  const CKPopover({required this.trigger, required this.content, super.key});
  final Widget trigger;
  final Widget content;

  @override
  State<CKPopover> createState() => _CKPopoverState();
}

class _CKPopoverState extends State<CKPopover> {
  final _link = LayerLink();
  OverlayEntry? _entry;

  bool get _isOpen => _entry != null;

  void _toggle() => _isOpen ? _close() : _open();

  void _open() {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;
    _entry = OverlayEntry(builder: _buildOverlay);
    overlay.insert(_entry!);
  }

  void _close() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  Widget _buildOverlay(BuildContext overlayContext) {
    // The overlay sits above CKApp's theme scope only if built from the
    // trigger's context, so read tokens from here.
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _close();
              if (mounted) setState(() {});
            },
          ),
        ),
        CompositedTransformFollower(
          link: _link,
          targetAnchor: Alignment.bottomLeft,
          offset: Offset(0, spacing.xs),
          showWhenUnlinked: false,
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: colors.surfaceElevated,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(theme.radius.lg),
                side: BorderSide(color: colors.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: theme.breakpoints.sm),
                child: Padding(
                  padding: EdgeInsets.all(spacing.md),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: Semantics(
        button: true,
        expanded: _isOpen,
        child: InkWell(
          onTap: () {
            _toggle();
            setState(() {});
          },
          borderRadius: BorderRadius.circular(context.ckcoreTheme.radius.lg),
          child: widget.trigger,
        ),
      ),
    );
  }
}
