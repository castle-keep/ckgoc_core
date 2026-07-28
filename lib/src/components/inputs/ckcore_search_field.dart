import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';

/// Search field wrapper providing a leading search icon and optional clear.
class CKSearchField extends StatelessWidget {
  const CKSearchField({
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
    final colors = context.ckcoreTheme.colors;
    final spacing = context.ckcoreTheme.spacing;

    return CKTextField(
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

/// Deprecated: Use [CKSearchField] instead.
@Deprecated('Use CKSearchField instead')
typedef ckcoresearchField = CKSearchField;
