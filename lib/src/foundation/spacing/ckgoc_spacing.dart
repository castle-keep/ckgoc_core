/// Spacing scale used throughout the design system.
class CkgocSpacing {
  const CkgocSpacing({
    this.none = 0,
    this.xs = 4,
    this.sm = 8,
    this.s12 = 12,
    this.md = 16,
    this.s20 = 20,
    this.lg = 24,
    this.xl = 32,
    this.s40 = 40,
    this.x2l = 48,
    this.x3l = 64,
    this.s80 = 80,
    this.x4l = 96,
    this.x5l = 128,
    this.xxs = 2,
  });
  final double none;
  final double xs;
  final double sm;
  final double s12;
  final double md;
  final double s20;
  final double lg;
  final double xl;
  final double s40;
  final double x2l;
  final double x3l;
  final double s80;
  final double x4l;
  final double x5l;
  final double xxs;

  CkgocSpacing copyWith({
    double? none,
    double? xs,
    double? sm,
    double? s12,
    double? md,
    double? s20,
    double? lg,
    double? xl,
    double? s40,
    double? x2l,
    double? x3l,
    double? s80,
    double? x4l,
    double? x5l,
    double? xxs,
  }) {
    return CkgocSpacing(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      s12: s12 ?? this.s12,
      md: md ?? this.md,
      s20: s20 ?? this.s20,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      s40: s40 ?? this.s40,
      x2l: x2l ?? this.x2l,
      x3l: x3l ?? this.x3l,
      s80: s80 ?? this.s80,
      x4l: x4l ?? this.x4l,
      x5l: x5l ?? this.x5l,
      xxs: xxs ?? this.xxs,
    );
  }

  /// Default spacing scale values.
  static const CkgocSpacing defaults = CkgocSpacing();
}
