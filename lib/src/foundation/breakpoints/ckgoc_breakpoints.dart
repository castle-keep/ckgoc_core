/// Breakpoint definitions for responsive layouts.
class CkgocBreakpoints {
  const CkgocBreakpoints({
    this.xs = 0,
    this.sm = 360,
    this.md = 600,
    this.lg = 840,
    this.xl = 1200,
    this.x2l = 1600,
  });
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double x2l;

  /// Default breakpoint values.
  static const CkgocBreakpoints defaults = CkgocBreakpoints();
}
