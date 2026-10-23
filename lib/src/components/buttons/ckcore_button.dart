import 'package:ckcoreui/src/foundation/colors/ckcore_colors.dart';
import 'package:ckcoreui/src/foundation/motion/ckcore_motion.dart';
import 'package:ckcoreui/src/foundation/spacing/ckcore_spacing.dart';
import 'package:ckcoreui/src/foundation/typography/ckcore_typography.dart';
import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Button widget that follows the design system tokens and variants.
///
/// The default appearance is primary (filled, high emphasis). Use named constructors
/// for semantic alternatives:
/// ```dart
/// CKButton(onPressed: () {}, child: Text('Save'))              // primary (default)
/// CKButton.secondary(onPressed: () {}, child: Text('Cancel'))  // secondary
/// CKButton.outline(onPressed: () {}, child: Text('Learn'))     // outline
/// CKButton.destructive(onPressed: () {}, child: Text('Delete')) // danger
/// ```
///
/// Supports `size`, loading state, disabled state and full-width mode.
///
/// On hover the button floats up with a soft shadow (see [hoverStyle]); on press
/// it scales down slightly and springs back. Both are skipped for disabled or
/// loading buttons and when the platform requests reduced motion.
class CKButton extends StatelessWidget {
  /// Primary button (default, recommended appearance).
  /// Filled with high visual emphasis for primary actions.
  const CKButton({
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  });

  /// Secondary button variant (filled, lower emphasis than primary).
  const CKButton.secondary({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.secondary;

  /// Outline button variant (bordered, lower emphasis).
  const CKButton.outline({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.outline;

  /// Ghost button variant (minimal, text-only).
  const CKButton.ghost({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.ghost;

  /// Accent button variant (accent color, high emphasis).
  const CKButton.accent({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.accent;

  /// Destructive button variant (error color, for dangerous actions).
  const CKButton.destructive({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.destructive;

  /// Success button variant (success color, for positive actions).
  const CKButton.success({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.success;

  /// Warning button variant (warning color, for cautionary actions).
  const CKButton.warning({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.warning;

  /// Info button variant (info color, for informational actions).
  const CKButton.info({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.info;

  /// Link button variant (text-only with underline, lowest emphasis).
  const CKButton.link({
    this.size = ButtonSize.md,
    this.onPressed,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.isFullWidth = false,
    this.hoverStyle = ButtonHoverStyle.lift,
    super.key,
  }) : variant = ButtonVariant.link;

  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool loading;
  final bool disabled;
  final bool isFullWidth;

  /// Hover effect for mouse pointers. Defaults to [ButtonHoverStyle.lift].
  /// Presses always get a quick scale-down regardless of this setting.
  final ButtonHoverStyle hoverStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;
    final opacity = theme.opacity;

    final isDisabled = disabled || onPressed == null;
    final borderRadius = BorderRadius.circular(radius.md);

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
      // Flexible lets long labels wrap instead of overflowing narrow parents.
      content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Flexible(child: content)],
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
          // Block taps while loading so actions can't be double-submitted.
          ignoring: isDisabled || loading,
          child: _ButtonMotion(
            enabled: !(isDisabled || loading),
            hoverStyle: hoverStyle,
            borderRadius: borderRadius,
            // Ghost, link and outline buttons have no surface to cast a shadow.
            shadow: switch (variant) {
              ButtonVariant.ghost ||
              ButtonVariant.link ||
              ButtonVariant.outline => false,
              _ => true,
            },
            lift: variant != ButtonVariant.link,
            child: _buildButton(
              child: content,
              borderRadius: borderRadius,
              colors: colors,
              spacing: spacing,
              typography: theme.typography,
              motion: motion,
            ),
          ),
        ),
      ),
    );
  }

  // Heights derived from spacing tokens: xs=lg(24)+sm(8)=32, sm=s40, md=x2l, lg=x2l+sm, xl=x3l
  Size _minSize(ckcoreSpacing s) => switch (size) {
    ButtonSize.xs => Size(0, s.xl), // 32
    ButtonSize.sm => Size(0, s.s40), // 40
    ButtonSize.md => Size(0, s.x2l), // 48
    ButtonSize.lg => Size(0, s.x2l + s.sm), // 56
    ButtonSize.xl => Size(0, s.x3l), // 64
  };

  EdgeInsets _padding(ckcoreSpacing s) => switch (size) {
    ButtonSize.xs => EdgeInsets.symmetric(horizontal: s.s12, vertical: s.xs),
    ButtonSize.sm => EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
    ButtonSize.md => EdgeInsets.symmetric(horizontal: s.s20, vertical: s.s12),
    ButtonSize.lg => EdgeInsets.symmetric(horizontal: s.lg, vertical: s.md),
    ButtonSize.xl => EdgeInsets.symmetric(horizontal: s.xl, vertical: s.s20),
  };

  Color _foregroundColor(ckcoreColors c) => switch (variant) {
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
    required ckcoreColors colors,
    required ckcoreSpacing spacing,
    required ckcoreTypography typography,
    required ckcoreMotion motion,
  }) {
    final textStyle = switch (size) {
      ButtonSize.xs => typography.labelSm,
      ButtonSize.sm || ButtonSize.md => typography.labelMd,
      ButtonSize.lg => typography.labelLg,
      ButtonSize.xl => typography.labelXl,
    };
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
        textStyle: textStyle,
        animationDuration: motion.fast,
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
            textStyle: textStyle,
            animationDuration: motion.fast,
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
            textStyle: textStyle,
            animationDuration: motion.fast,
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
            textStyle: textStyle.copyWith(decoration: TextDecoration.underline),
          ),
          colors.primary,
        ),
        child: child,
      ),
    };
  }
}

/// Hover-lift and press-scale motion around a button.
class _ButtonMotion extends StatefulWidget {
  const _ButtonMotion({
    required this.enabled,
    required this.hoverStyle,
    required this.borderRadius,
    required this.shadow,
    required this.lift,
    required this.child,
  });
  final bool enabled;
  final ButtonHoverStyle hoverStyle;
  final BorderRadius borderRadius;
  final bool shadow;
  final bool lift;
  final Widget child;

  @override
  State<_ButtonMotion> createState() => _ButtonMotionState();
}

class _ButtonMotionState extends State<_ButtonMotion> {
  bool _hovered = false;
  bool _pressed = false;

  void _setHovered(bool v) {
    if (_hovered != v) setState(() => _hovered = v);
  }

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  void didUpdateWidget(_ButtonMotion old) {
    super.didUpdateWidget(old);
    if (!widget.enabled && (_hovered || _pressed)) {
      _hovered = false;
      _pressed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final hovering =
        widget.enabled && _hovered && widget.hoverStyle != ButtonHoverStyle.none;
    final lifted = hovering &&
        widget.hoverStyle == ButtonHoverStyle.lift &&
        widget.lift &&
        !_pressed;
    final grown = hovering && widget.hoverStyle == ButtonHoverStyle.grow;

    final scale = _pressed && widget.enabled
        ? 0.96
        : grown
            ? 1.03
            : 1.0;
    final dy = lifted ? -theme.spacing.xxs : 0.0;

    final shadows = lifted || grown
        ? (widget.shadow ? theme.shadows.md : const <BoxShadow>[])
        : const <BoxShadow>[];

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedContainer(
          duration: reduce
              ? Duration.zero
              : (_pressed ? theme.motion.fast : theme.motion.normal),
          curve: _pressed ? Curves.easeOut : Curves.easeOutCubic,
          transformAlignment: Alignment.center,
          transform: Matrix4.translationValues(0, dy, 0)
            ..scaleByDouble(scale, scale, 1, 1),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            boxShadow: shadows,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKButton] instead.
@Deprecated('Use CKButton instead')
typedef ckcorebutton = CKButton;
