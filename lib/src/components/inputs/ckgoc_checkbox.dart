import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocCheckbox extends StatelessWidget {
  const CkgocCheckbox({
    required this.value,
    this.onChanged,
    this.label,
    this.variant,
    super.key,
  });
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final SwitchVariant? variant;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final c = theme.colors;
    final s = theme.spacing;
    final r = theme.radius;
    final o = theme.opacity;
    final t = theme.typography;

    final isDisabled = onChanged == null;
    final isChecked = value == true;
    final isIntermediate = value == null;
    final isFilled = isChecked || isIntermediate;
    final hasError = variant == SwitchVariant.error;

    final activeColor = switch (variant) {
      SwitchVariant.success => c.success,
      SwitchVariant.error => c.error,
      _ => c.primary,
    };

    final onActiveColor = switch (variant) {
      SwitchVariant.success => c.onSuccess,
      SwitchVariant.error => c.onError,
      _ => c.onPrimary,
    };

    final borderColor = isFilled
        ? activeColor
        : (hasError ? c.error : c.outline);

    final box = AnimatedContainer(
      duration: theme.motion.fast,
      width: s.md,
      height: s.md,
      decoration: BoxDecoration(
        color: isFilled ? activeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(r.sm),
        border: Border.all(color: borderColor, width: s.xxs / 2),
      ),
      child: isFilled
          ? Center(
              child: Icon(
                isIntermediate ? LucideIcons.minus : LucideIcons.check,
                size: s.s12,
                color: onActiveColor,
              ),
            )
          : null,
    );

    void toggle() => onChanged?.call(value != true);

    final touchTarget = GestureDetector(
      onTap: isDisabled ? null : toggle,
      child: SizedBox(
        width: s.lg,
        height: s.lg,
        child: Center(child: box),
      ),
    );

    Widget result = AnimatedOpacity(
      duration: theme.motion.fast,
      opacity: isDisabled ? o.disabled : o.full,
      child: touchTarget,
    );

    if (label == null) return result;

    return GestureDetector(
      onTap: isDisabled ? null : toggle,
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
