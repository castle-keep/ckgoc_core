/// Opacity scale used across the design system.
class ckcoreOpacity {
  const ckcoreOpacity({
    this.disabled = 0.38,
    this.muted = 0.60,
    this.hover = 0.08,
    this.scrim = 0.50,
    this.subtle = 0.12,
    this.transparent = 0.0,
    this.full = 1.0,
  });
  final double disabled;
  final double muted;
  final double hover;
  final double scrim;
  final double subtle;
  final double transparent;
  final double full;

  ckcoreOpacity copyWith({
    double? disabled,
    double? muted,
    double? hover,
    double? scrim,
    double? subtle,
    double? transparent,
    double? full,
  }) {
    return ckcoreOpacity(
      disabled: disabled ?? this.disabled,
      muted: muted ?? this.muted,
      hover: hover ?? this.hover,
      scrim: scrim ?? this.scrim,
      subtle: subtle ?? this.subtle,
      transparent: transparent ?? this.transparent,
      full: full ?? this.full,
    );
  }

  /// Default opacity scale values.
  static const ckcoreOpacity defaults = ckcoreOpacity();
}
