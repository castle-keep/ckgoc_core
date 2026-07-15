import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

/// Radio control with optional label and variant coloring.
class CkgocRadio<T> extends StatelessWidget {
  const CkgocRadio({
    required this.value,
    this.groupValue,
    this.onChanged,
    this.label,
    this.variant,
    super.key,
  });
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final SwitchVariant? variant;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final o = theme.opacity;
    final t = theme.typography;

    final isDisabled = onChanged == null;
    final isSelected = value == groupValue;
    final hasError = variant == SwitchVariant.error;

    final activeColor = switch (variant) {
      SwitchVariant.success => c.success,
      SwitchVariant.error => c.error,
      _ => c.primary,
    };

    final borderColor = isSelected
        ? activeColor
        : (hasError ? c.error : c.outline);

    final circle = AnimatedContainer(
      duration: theme.motion.fast,
      width: s.md,
      height: s.md,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: s.xxs / 2),
      ),
      child: isSelected
          ? Center(
              child: AnimatedContainer(
                duration: theme.motion.fast,
                width: s.sm,
                height: s.sm,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor,
                ),
              ),
            )
          : null,
    );

    void select() => onChanged?.call(value);

    final touchTarget = GestureDetector(
      onTap: isDisabled ? null : select,
      child: SizedBox(
        width: s.lg,
        height: s.lg,
        child: Center(child: circle),
      ),
    );

    if (label == null) {
      return AnimatedOpacity(
        duration: theme.motion.fast,
        opacity: isDisabled ? o.disabled : o.full,
        child: touchTarget,
      );
    }

    return GestureDetector(
      onTap: isDisabled ? null : select,
      child: AnimatedOpacity(
        duration: theme.motion.fast,
        opacity: isDisabled ? o.disabled : o.full,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            touchTarget,
            SizedBox(width: s.xs),
            Text(
              label!,
              style: t.labelMd.copyWith(
                color: isDisabled ? c.onSurfaceVariant : c.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
