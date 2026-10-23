import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Branded intro shown once when the docs app opens.
///
/// Plays a short staggered entrance and then calls [onDone]. Tap, click or any
/// key skips it. Under reduced motion it dismisses straight away.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.brand,
    required this.onDone,
    this.duration = const Duration(milliseconds: 2400),
    super.key,
  });

  final ckcoreBrand brand;
  final VoidCallback onDone;
  final Duration duration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  final _focus = FocusNode();
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _progress.addStatusListener((status) {
      if (status == AnimationStatus.completed) _finish();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      // Skip the intro entirely for people who asked for less motion.
      WidgetsBinding.instance.addPostFrameCallback((_) => _finish());
    } else if (!_progress.isAnimating && !_finished) {
      _progress.forward();
    }
  }

  void _finish() {
    if (_finished || !mounted) return;
    _finished = true;
    widget.onDone();
  }

  @override
  void dispose() {
    _progress.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;

    return Focus(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent) {
          _finish();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _finish,
        child: Semantics(
          label: 'ckcoreui documentation is loading. Tap to skip.',
          child: Scaffold(
            backgroundColor: colors.primary,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CKAnimate(
                    animation: CKAnimation.scale,
                    duration: theme.motion.lazy,
                    child: Container(
                      width: spacing.x5l,
                      height: spacing.x5l,
                      padding: EdgeInsets.all(spacing.lg),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        shape: BoxShape.circle,
                        boxShadow: theme.shadows.xl,
                      ),
                      child: BrandIcon.brandLogoWidget(
                        context,
                        widget.brand,
                        size: spacing.x4l,
                        variant: BrandIconVariant.logo,
                      ),
                    ),
                  ),
                  SizedBox(height: spacing.lg),
                  CKAnimate(
                    animation: CKAnimation.slideUp,
                    delay: const Duration(milliseconds: 250),
                    child: Text(
                      'ckcoreui',
                      style: theme.typography.displayMd.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: spacing.xs),
                  CKAnimate(
                    animation: CKAnimation.slideUp,
                    delay: const Duration(milliseconds: 450),
                    child: Text(
                      'Design system for Flutter',
                      style: theme.typography.textMd.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing.xl),
                  CKAnimate(
                    delay: const Duration(milliseconds: 600),
                    child: SizedBox(
                      width: spacing.x5l + spacing.x3l,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(theme.radius.full),
                        child: AnimatedBuilder(
                          animation: _progress,
                          builder: (_, __) => LinearProgressIndicator(
                            value: _progress.value,
                            minHeight: spacing.xs,
                            color: colors.accent,
                            backgroundColor:
                                colors.onPrimary.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing.md),
                  CKAnimate(
                    delay: const Duration(milliseconds: 900),
                    child: Text(
                      'Tap or press any key to skip',
                      style: theme.typography.textXs.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
