import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// One-time-password (OTP) input represented as multiple fixed-width cells.
///
/// Captures numeric input and notifies via [onChanged] and [onCompleted]
/// when the configured [length] is reached.
class CkgocOtpField extends StatefulWidget {
  const CkgocOtpField({
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.autoFocus = false,
    this.enabled = true,
    super.key,
  });
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool autoFocus;
  final bool enabled;

  @override
  State<CkgocOtpField> createState() => _CompanyOtpFieldState();
}

class _CompanyOtpFieldState extends State<CkgocOtpField> {
  late final TextEditingController _ctrl;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
    _focus = FocusNode();
    _ctrl.addListener(() => setState(() {}));
    _focus.addListener(() => setState(() {}));
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _focus.requestFocus(),
      );
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final spacing = theme.spacing;

    return GestureDetector(
      onTap: widget.enabled ? () => _focus.requestFocus() : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Invisible TextField — captures all keyboard input
          Opacity(
            opacity: 0,
            child: SizedBox(
              width: 1,
              child: TextField(
                controller: _ctrl,
                focusNode: _focus,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: widget.length,
                enabled: widget.enabled,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (v) {
                  widget.onChanged?.call(v);
                  if (v.length == widget.length) {
                    _focus.unfocus();
                    widget.onCompleted?.call(v);
                  }
                },
              ),
            ),
          ),
          // Visual cells
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.length, (i) {
              final isLast = i == widget.length - 1;
              return Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : spacing.sm),
                child: _OtpCell(
                  char: i < _ctrl.text.length ? _ctrl.text[i] : null,
                  isActive: _focus.hasFocus && i == _ctrl.text.length,
                  isDisabled: !widget.enabled,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _OtpCell extends StatelessWidget {
  const _OtpCell({required this.isActive, required this.isDisabled, this.char});
  final String? char;
  final bool isActive;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final opacity = theme.opacity;

    return AnimatedOpacity(
      duration: theme.motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: AnimatedContainer(
        duration: theme.motion.fast,
        width: theme.spacing.x2l,
        height: theme.spacing.x2l + theme.spacing.sm,
        decoration: BoxDecoration(
          color: isDisabled ? colors.muted : colors.surface,
          border: Border.all(
            color: isActive ? colors.primary : colors.outline,
            width: isActive ? theme.spacing.xxs : 1,
          ),
          borderRadius: BorderRadius.circular(radius.base),
        ),
        alignment: Alignment.center,
        child: char != null
            ? Text(
                char!,
                style: theme.typography.displayMd.copyWith(
                  color: colors.onSurface,
                ),
              )
            : isActive
            ? _BlinkingCursor(color: colors.primary)
            : null,
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({required this.color});
  final Color color;

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // ~motion.lazy
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.ckgocTheme.spacing;
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: spacing.xxs,
        height: spacing.lg,
        color: widget.color,
      ),
    );
  }
}
