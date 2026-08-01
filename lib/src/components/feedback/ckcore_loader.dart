import 'dart:math' as math;
import 'package:ckcoreui/src/foundation/foundation.dart';
import 'package:ckcoreui/src/themes/themes.dart';
import 'package:ckcoreui/src/components/components.dart';
import 'package:flutter/material.dart';

/// Loader/spinner component with multiple animation styles.
///
/// The default is a circular spinner. Use named constructors for other animation types:
/// ```dart
/// CKLoader()                    // circular (default)
/// CKLoader.ring()
/// CKLoader.bar()
/// CKLoader.dots()
/// ```
class CKLoader extends StatelessWidget {
  /// Circular loader (default, most common animation type).
  const CKLoader({
    this.type = LoaderType.circular,
    this.color,
    this.size = 40,
    super.key,
  });

  /// Ring loader variant (spinning ring).
  const CKLoader.ring({this.color, this.size = 40, super.key})
    : type = LoaderType.ring;

  /// Bar loader variant (animated progress bar).
  const CKLoader.bar({this.color, this.size = 40, super.key})
    : type = LoaderType.bar;

  /// Dots loader variant (bouncing dots).
  const CKLoader.dots({this.color, this.size = 40, super.key})
    : type = LoaderType.dots;
  final LoaderType type;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.ckcoreTheme.colors;
    final opacity = context.ckcoreTheme.opacity;
    final activeColor = color ?? colors.primary;

    return switch (type) {
      LoaderType.circular => _CircularLoader(
        color: activeColor,
        size: size,
        opacity: opacity,
      ),
      LoaderType.ring => _RingLoader(
        color: activeColor,
        size: size,
        opacity: opacity,
      ),
      LoaderType.bar => _BarLoader(
        color: activeColor,
        size: size,
        opacity: opacity,
      ),
      LoaderType.dots => _DotsLoader(
        color: activeColor,
        dotSize: size * 0.275,
        opacity: opacity,
      ),
    };
  }
}

class _CircularLoader extends StatelessWidget {
  const _CircularLoader({
    required this.color,
    required this.size,
    required this.opacity,
  });
  final Color color;
  final double size;
  final ckcoreOpacity opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: (size * 0.075).clamp(2.0, 4.0),
        valueColor: AlwaysStoppedAnimation(color),
        backgroundColor: color.withValues(alpha: opacity.subtle),
      ),
    );
  }
}

class _RingLoader extends StatelessWidget {
  const _RingLoader({
    required this.color,
    required this.size,
    required this.opacity,
  });
  final Color color;
  final double size;
  final ckcoreOpacity opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: (size * 0.18).clamp(4.0, 10.0),
        valueColor: AlwaysStoppedAnimation(color),
        backgroundColor: color.withValues(alpha: opacity.subtle),
      ),
    );
  }
}

class _BarLoader extends StatelessWidget {
  const _BarLoader({
    required this.color,
    required this.size,
    required this.opacity,
  });
  final Color color;
  final double size;
  final ckcoreOpacity opacity;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final radius = theme.radius;
    final spacing = theme.spacing;
    return SizedBox(
      width: size * 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius.full),
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color),
          backgroundColor: color.withValues(alpha: opacity.subtle),
          minHeight: (size * 0.2).clamp(spacing.xs, spacing.sm),
        ),
      ),
    );
  }
}

class _DotsLoader extends StatefulWidget {
  const _DotsLoader({
    required this.color,
    required this.dotSize,
    required this.opacity,
  });
  final Color color;
  final double dotSize;
  final ckcoreOpacity opacity;

  @override
  State<_DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<_DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900), // motion.slow * 3
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dotCount = 3;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(dotCount, (i) {
        final delay = i / dotCount;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.dotSize * 0.3),
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final t = (_ctrl.value + delay) % 1.0;
              final scale = 0.55 + 0.45 * math.sin(t * math.pi);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.dotSize,
                  height: widget.dotSize,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

/// Deprecated: Use [CKLoader] instead.
@Deprecated('Use CKLoader instead')
typedef ckcoreloader = CKLoader;
