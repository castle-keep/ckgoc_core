import 'package:flutter/material.dart';

/// Shadow definitions used by the design system for different elevations.
class CkgocShadows {
  const CkgocShadows({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
  final List<BoxShadow> none;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;

  /// Light-mode shadow set.
  static CkgocShadows light() => const CkgocShadows(
    none: [],
    sm: [
      BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
    ],
    md: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 4, offset: Offset(0, 1)),
    ],
    lg: [
      BoxShadow(color: Color(0x1A000000), blurRadius: 15, offset: Offset(0, 4)),
      BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 2)),
    ],
    xl: [
      BoxShadow(color: Color(0x1F000000), blurRadius: 25, offset: Offset(0, 8)),
      BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 4)),
    ],
  );

  /// Dark-mode shadow set.
  static CkgocShadows dark() => const CkgocShadows(
    none: [],
    sm: [
      BoxShadow(color: Color(0x33000000), blurRadius: 2, offset: Offset(0, 1)),
    ],
    md: [
      BoxShadow(color: Color(0x4D000000), blurRadius: 6, offset: Offset(0, 2)),
    ],
    lg: [
      BoxShadow(color: Color(0x66000000), blurRadius: 15, offset: Offset(0, 4)),
    ],
    xl: [
      BoxShadow(color: Color(0x80000000), blurRadius: 25, offset: Offset(0, 8)),
    ],
  );
}
