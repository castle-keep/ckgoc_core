import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/inputs/ckgoc_text_field.dart';

class CkgocSearchField extends StatelessWidget {
  const CkgocSearchField({
    this.controller,
    this.focusNode,
    this.hint,
    this.onChanged,
    this.onClear,
    this.enabled = true,
    this.autoFocus = false,
    super.key,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final colors = context.ckgocTheme.colors;
    final spacing = context.ckgocTheme.spacing;

    return CkgocTextField(
      controller: controller,
      focusNode: focusNode,
      hint: hint ?? 'Search...',
      onChanged: onChanged,
      enabled: enabled,
      autoFocus: autoFocus,
      leading: Icon(
        LucideIcons.search,
        size: spacing.md,
        color: colors.onSurfaceVariant,
      ),
      trailing: onClear != null
          ? GestureDetector(
              onTap: onClear,
              child: Icon(
                LucideIcons.x,
                size: spacing.md,
                color: colors.onSurfaceVariant,
              ),
            )
          : null,
    );
  }
}
