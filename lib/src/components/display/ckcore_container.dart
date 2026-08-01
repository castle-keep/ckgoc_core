import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// Generic surface container that applies design-system background, borders,
/// and padding. The default appearance uses the surface background.
///
/// Use named constructors for alternative variants:
/// ```dart
/// CKContainer(child: ...)              // surface (default)
/// CKContainer.muted(child: ...)        // muted background
/// CKContainer.outlined(child: ...)     // with border
/// ```
class CKContainer extends StatelessWidget {
  /// Surface container (default, neutral appearance with surface color).
  const CKContainer({
    required this.child,
    this.variant = ContainerVariant.surface,
    this.padding,
    this.elevated = false,
    super.key,
  });

  /// Muted variant container (muted/variant surface color).
  const CKContainer.muted({
    required this.child,
    this.padding,
    this.elevated = false,
    super.key,
  }) : variant = ContainerVariant.muted;

  /// Outlined variant container (surface with border).
  const CKContainer.outlined({
    required this.child,
    this.padding,
    this.elevated = false,
    super.key,
  }) : variant = ContainerVariant.outlined;
  final Widget child;
  final ContainerVariant variant;
  final EdgeInsetsGeometry? padding;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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
      clipBehavior: Clip.hardEdge,
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

/// Deprecated: Use [CKContainer] instead.
@Deprecated('Use CKContainer instead')
typedef ckcorecontainer = CKContainer;
