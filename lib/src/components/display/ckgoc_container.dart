import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocContainer extends StatelessWidget {
  const CkgocContainer({
    required this.child,
    this.variant = ContainerVariant.surface,
    this.padding,
    this.elevated = false,
    super.key,
  });
  final Widget child;
  final ContainerVariant variant;
  final EdgeInsetsGeometry? padding;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final r = theme.radius;
    final sh = theme.shadows;

    final (bg, border) = switch (variant) {
      ContainerVariant.surface => (c.surface, null as Border?),
      ContainerVariant.muted => (c.surfaceVariant, null as Border?),
      ContainerVariant.outlined => (
        c.surface,
        Border.all(color: c.outline, width: s.xxs / 2),
      ),
    };

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: border,
        borderRadius: BorderRadius.circular(r.lg),
        boxShadow: elevated ? sh.sm : null,
      ),
      padding: padding ?? EdgeInsets.all(s.md),
      child: child,
    );
  }
}
