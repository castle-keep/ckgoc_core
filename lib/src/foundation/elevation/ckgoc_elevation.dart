/// Elevation tokens.
class CkgocElevation {
  const CkgocElevation({
    this.none = 0,
    this.xs = 1,
    this.sm = 2,
    this.md = 4,
    this.lg = 8,
    this.xl = 16,
  });
  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  /// Named aliases

  /// Flat surface: backgrounds, canvas.
  double get surface => none;

  /// Slight lift: list items, rows.
  double get card => sm;

  /// Floating: dropdowns, menus.
  double get dropdown => md;

  /// Modals, drawers.
  double get modal => lg;

  /// Highest: toasts, alerts.
  double get toast => xl;

  CkgocElevation copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return CkgocElevation(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  /// Default elevation tokens.
  static const CkgocElevation defaults = CkgocElevation();
}
