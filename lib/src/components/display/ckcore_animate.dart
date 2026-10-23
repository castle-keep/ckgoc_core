import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Entrance effects supported by [CKAnimate].
enum CKAnimation {
  /// Fade from transparent to opaque.
  fade,

  /// Fade in while travelling up from below.
  slideUp,

  /// Fade in while travelling down from above.
  slideDown,

  /// Fade in while travelling left from the right.
  slideLeft,

  /// Fade in while travelling right from the left.
  slideRight,

  /// Fade in while growing from 90% to 100% size.
  scale,
}

/// Wraps any widget with a token-driven entrance animation.
///
/// Duration and curve default to the active theme's motion tokens, so the
/// animation follows the brand. When the platform asks to reduce motion
/// (`MediaQuery.disableAnimations`) the child is shown immediately.
///
/// ```dart
/// CKAnimate(
///   animation: CKAnimation.slideUp,
///   child: CKCard(title: 'Hello'),
/// )
///
/// // Cascade a list: each child starts 60ms after the previous one.
/// Column(
///   children: CKAnimate.stagger(
///     children: [CKCard(title: 'One'), CKCard(title: 'Two')],
///   ),
/// )
/// ```
///
/// Change [trigger] to replay the animation.
class CKAnimate extends StatefulWidget {
  const CKAnimate({
    required this.child,
    this.animation = CKAnimation.fade,
    this.duration,
    this.delay = Duration.zero,
    this.curve,
    this.offset = 16,
    this.autoPlay = true,
    this.trigger,
    super.key,
  });

  /// The widget to animate.
  final Widget child;

  /// Which entrance effect to use.
  final CKAnimation animation;

  /// Animation length. Defaults to the theme's `motion.slow`.
  final Duration? duration;

  /// Wait before starting.
  final Duration delay;

  /// Easing. Defaults to the theme's `motion.decelerate`.
  final Curve? curve;

  /// Travel distance in logical pixels for the slide effects.
  final double offset;

  /// When false the child stays hidden until [trigger] changes.
  final bool autoPlay;

  /// Any value; when it changes the animation replays from the start.
  final Object? trigger;

  /// Wraps [children] in [CKAnimate]s whose [delay]s increase by [interval].
  static List<Widget> stagger({
    required List<Widget> children,
    CKAnimation animation = CKAnimation.slideUp,
    Duration interval = const Duration(milliseconds: 60),
    Duration? duration,
    Curve? curve,
  }) {
    return [
      for (var i = 0; i < children.length; i++)
        CKAnimate(
          animation: animation,
          duration: duration,
          curve: curve,
          delay: interval * i,
          child: children[i],
        ),
    ];
  }

  @override
  State<CKAnimate> createState() => _CKAnimateState();
}

class _CKAnimateState extends State<CKAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  Timer? _timer;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = _duration;
    if (!_started && widget.autoPlay) _play();
  }

  @override
  void didUpdateWidget(CKAnimate old) {
    super.didUpdateWidget(old);
    _controller.duration = _duration;
    if (widget.trigger != old.trigger) _play();
  }

  Duration get _duration =>
      widget.duration ??
      (context.ckcoreThemeMaybe?.motion.slow ??
          const Duration(milliseconds: 300));

  Curve get _curve =>
      widget.curve ??
      context.ckcoreThemeMaybe?.motion.decelerate ??
      Curves.easeOut;

  void _play() {
    _started = true;
    _timer?.cancel();
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      _controller.value = 1;
      return;
    }
    _controller.value = 0;
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Offset get _slide => switch (widget.animation) {
    CKAnimation.slideUp => Offset(0, widget.offset),
    CKAnimation.slideDown => Offset(0, -widget.offset),
    CKAnimation.slideLeft => Offset(widget.offset, 0),
    CKAnimation.slideRight => Offset(-widget.offset, 0),
    _ => Offset.zero,
  };

  @override
  Widget build(BuildContext context) {
    final progress = _controller.drive(CurveTween(curve: _curve));
    return AnimatedBuilder(
      animation: progress,
      child: widget.child,
      builder: (context, child) {
        final t = progress.value;
        // Elastic-style curves overshoot; keep opacity in range.
        final faded = Opacity(opacity: t.clamp(0.0, 1.0), child: child);
        if (widget.animation == CKAnimation.scale) {
          return Transform.scale(scale: 0.9 + 0.1 * t, child: faded);
        }
        final slide = _slide;
        if (slide == Offset.zero) return faded;
        return Transform.translate(offset: slide * (1 - t), child: faded);
      },
    );
  }
}
