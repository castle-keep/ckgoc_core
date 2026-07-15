import 'package:ckgoc_core/src/foundation/colors/ckgoc_colors.dart';
import 'package:ckgoc_core/src/foundation/spacing/ckgoc_spacing.dart';
import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

/// Button widget that follows the design system tokens and variants.
///
/// Supports `variant`, `size`, loading state, disabled state and full-width mode.
class CkgocButton extends StatelessWidget {
  const CkgocButton({
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    super.key,
  });
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool loading;
  final bool disabled;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;
    final opacity = theme.opacity;

    final isDisabled = disabled || onPressed == null;
    final borderRadius = BorderRadius.circular(radius.base);

    Widget content = loading
        ? SizedBox(
            width: spacing.md,
            height: spacing.md,
            child: CircularProgressIndicator(
              strokeWidth: spacing.xxs,
              color: _foregroundColor(colors),
            ),
          )
        : child ?? const SizedBox.shrink();

    if (isFullWidth) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [content],
      );
    }

    return AnimatedOpacity(
      duration: motion.fast,
      opacity: isDisabled ? opacity.disabled : opacity.full,
      child: AnimatedContainer(
        duration: motion.fast,
        curve: motion.decelerate,
        width: isFullWidth ? double.infinity : null,
        child: IgnorePointer(
          ignoring: isDisabled,
          child: _buildButton(
            child: content,
            borderRadius: borderRadius,
            colors: colors,
            spacing: spacing,
          ),
        ),
      ),
    );
  }

  // Heights derived from spacing tokens: xs=lg(24)+sm(8)=32, sm=s40, md=x2l, lg=x2l+sm, xl=x3l
  Size _minSize(CkgocSpacing s) => switch (size) {
    ButtonSize.xs => Size(0, s.xl), // 32
    ButtonSize.sm => Size(0, s.s40), // 40
    ButtonSize.md => Size(0, s.x2l), // 48
    ButtonSize.lg => Size(0, s.x2l + s.sm), // 56
    ButtonSize.xl => Size(0, s.x3l), // 64
  };

  EdgeInsets _padding(CkgocSpacing s) => switch (size) {
    ButtonSize.xs => EdgeInsets.symmetric(horizontal: s.s12, vertical: s.xs),
    ButtonSize.sm => EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
    ButtonSize.md => EdgeInsets.symmetric(horizontal: s.s20, vertical: s.s12),
    ButtonSize.lg => EdgeInsets.symmetric(horizontal: s.lg, vertical: s.md),
    ButtonSize.xl => EdgeInsets.symmetric(horizontal: s.xl, vertical: s.s20),
  };

  Color _foregroundColor(CkgocColors c) => switch (variant) {
    ButtonVariant.primary => c.onPrimary,
    ButtonVariant.secondary => c.onSecondary,
    ButtonVariant.outline => c.primary,
    ButtonVariant.ghost => c.primary,
    ButtonVariant.accent => c.primary,
    ButtonVariant.destructive => c.onError,
    ButtonVariant.success => c.onSuccess,
    ButtonVariant.warning => c.onWarning,
    ButtonVariant.info => c.onInfo,
    ButtonVariant.link => c.primary,
  };

  Widget _buildButton({
    required Widget child,
    required BorderRadius borderRadius,
    required CkgocColors colors,
    required CkgocSpacing spacing,
  }) {
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);
    final padding = _padding(spacing);
    final minSize = _minSize(spacing);

    // Keep brand colors when disabled — AnimatedOpacity provides the visual dim.
    // Focus ring: 2dp brand-colored border offset ring on keyboard focus.
    ButtonStyle withFocusRing(
      ButtonStyle base,
      Color ringColor, {
      BorderSide? defaultBorder,
    }) => base.copyWith(
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: colors.ring, width: spacing.xxs);
        }
        return defaultBorder;
      }),
    );

    ButtonStyle filled(Color bg, Color fg, Color overlay) => withFocusRing(
      ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        overlayColor: overlay,
        disabledBackgroundColor: bg,
        disabledForegroundColor: fg,
        padding: padding,
        minimumSize: minSize,
        shape: shape,
        elevation: 0,
      ),
      fg,
    );

    return switch (variant) {
      ButtonVariant.primary => ElevatedButton(
        onPressed: onPressed,
        style: filled(colors.primary, colors.onPrimary, colors.primaryHover),
        child: child,
      ),
      ButtonVariant.secondary => ElevatedButton(
        onPressed: onPressed,
        style: filled(
          colors.secondary,
          colors.onSecondary,
          colors.secondaryHover,
        ),
        child: child,
      ),
      ButtonVariant.outline => OutlinedButton(
        onPressed: onPressed,
        style: withFocusRing(
          OutlinedButton.styleFrom(
            foregroundColor: colors.primary,
            disabledForegroundColor: colors.primary,
            overlayColor: colors.primaryHover,
            side: BorderSide(color: colors.primary, width: 1),
            padding: padding,
            minimumSize: minSize,
            shape: shape,
          ),
          colors.primary,
          defaultBorder: BorderSide(color: colors.primary, width: 1),
        ),
        child: child,
      ),
      ButtonVariant.ghost => TextButton(
        onPressed: onPressed,
        style: withFocusRing(
          TextButton.styleFrom(
            foregroundColor: colors.primary,
            disabledForegroundColor: colors.primary,
            overlayColor: colors.primaryHover,
            padding: padding,
            minimumSize: minSize,
            shape: shape,
          ),
          colors.primary,
        ),
        child: child,
      ),
      ButtonVariant.accent => ElevatedButton(
        onPressed: onPressed,
        style: filled(colors.accent, colors.primary, colors.primaryHover),
        child: child,
      ),
      ButtonVariant.destructive => ElevatedButton(
        onPressed: onPressed,
        style: filled(colors.error, colors.onError, colors.errorContainer),
        child: child,
      ),
      ButtonVariant.success => ElevatedButton(
        onPressed: onPressed,
        style: filled(
          colors.success,
          colors.onSuccess,
          colors.successContainer,
        ),
        child: child,
      ),
      ButtonVariant.warning => ElevatedButton(
        onPressed: onPressed,
        style: filled(
          colors.warning,
          colors.onWarning,
          colors.warningContainer,
        ),
        child: child,
      ),
      ButtonVariant.info => ElevatedButton(
        onPressed: onPressed,
        style: filled(colors.info, colors.onInfo, colors.infoContainer),
        child: child,
      ),
      ButtonVariant.link => TextButton(
        onPressed: onPressed,
        style: withFocusRing(
          TextButton.styleFrom(
            foregroundColor: colors.primary,
            disabledForegroundColor: colors.primary,
            overlayColor: colors.primaryHover,
            padding: padding,
            minimumSize: minSize,
            shape: shape,
            textStyle: const TextStyle(decoration: TextDecoration.underline),
          ),
          colors.primary,
        ),
        child: child,
      ),
    };
  }
}
