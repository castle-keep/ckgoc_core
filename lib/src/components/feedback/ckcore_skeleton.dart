import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

/// Placeholder block with a gentle pulse while content loads.
///
/// The pulse is skipped when the platform requests reduced motion.
class CKSkeleton extends StatefulWidget {
  const CKSkeleton({
    required this.width,
    required this.height,
    this.borderRadius,
    super.key,
  });
  final double width;
  final double height;

  /// Corner radius. Defaults to the theme's `radius.base`.
  final double? borderRadius;

  @override
  State<CKSkeleton> createState() => _CKSkeletonState();
}

class _CKSkeletonState extends State<CKSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final radius = widget.borderRadius ?? theme.radius.base;

    return Semantics(
      label: 'Loading',
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(
              colors.surfaceVariant,
              colors.outlineVariant,
              _controller.value,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKSkeleton] instead.
@Deprecated('Use CKSkeleton instead')
typedef ckcoreskeleton = CKSkeleton;
