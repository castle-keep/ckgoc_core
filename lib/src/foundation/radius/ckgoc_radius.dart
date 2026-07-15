/// Corner radius tokens used across the design system.
class CkgocRadius {
  const CkgocRadius({
    this.none = 0,
    this.sm = 4,
    this.base = 6,
    this.md = 8,
    this.lg = 12,
    this.xl = 16,
    this.x2l = 24,
    this.x3l = 32,
    this.full = 9999,
  });
  final double none;
  final double sm;
  final double base;
  final double md;
  final double lg;
  final double xl;
  final double x2l;
  final double x3l;
  final double full;

  CkgocRadius copyWith({
    double? none,
    double? sm,
    double? base,
    double? md,
    double? lg,
    double? xl,
    double? x2l,
    double? x3l,
    double? full,
  }) {
    return CkgocRadius(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      base: base ?? this.base,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
      x3l: x3l ?? this.x3l,
      full: full ?? this.full,
    );
  }

  /// Default radius token values.
  static const CkgocRadius defaults = CkgocRadius();
}
