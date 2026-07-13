import 'package:flutter/material.dart';

class CkgocMotion {
  const CkgocMotion({
    this.instant = const Duration(milliseconds: 50),
    this.fast = const Duration(milliseconds: 100),
    this.normal = const Duration(milliseconds: 200),
    this.slow = const Duration(milliseconds: 300),
    this.lazy = const Duration(milliseconds: 500),
    this.standard = const _StandardCurve(),
    this.decelerate = const _DecelerateCurve(),
    this.accelerate = const _AccelerateCurve(),
    this.emphasized = const _EmphasizedCurve(),
  });
  final Duration instant;
  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration lazy;
  final Curve standard;
  final Curve decelerate;
  final Curve accelerate;
  final Curve emphasized;

  CkgocMotion copyWith({
    Duration? instant,
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? lazy,
    Curve? standard,
    Curve? decelerate,
    Curve? accelerate,
    Curve? emphasized,
  }) {
    return CkgocMotion(
      instant: instant ?? this.instant,
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      lazy: lazy ?? this.lazy,
      standard: standard ?? this.standard,
      decelerate: decelerate ?? this.decelerate,
      accelerate: accelerate ?? this.accelerate,
      emphasized: emphasized ?? this.emphasized,
    );
  }

  static const CkgocMotion defaults = CkgocMotion();
}

class _StandardCurve extends Curve {
  const _StandardCurve();
  @override
  double transformInternal(double t) => Curves.easeInOut.transform(t);
}

class _DecelerateCurve extends Curve {
  const _DecelerateCurve();
  @override
  double transformInternal(double t) => Curves.easeOut.transform(t);
}

class _AccelerateCurve extends Curve {
  const _AccelerateCurve();
  @override
  double transformInternal(double t) => Curves.easeIn.transform(t);
}

class _EmphasizedCurve extends Curve {
  const _EmphasizedCurve();
  @override
  double transformInternal(double t) => Curves.elasticOut.transform(t);
}
