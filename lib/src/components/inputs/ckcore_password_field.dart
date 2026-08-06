import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';

/// Password field built on top of `CKTextField` with toggleable visibility.
class CKPasswordField extends StatefulWidget {
  const CKPasswordField({
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.autoFocus = false,
    super.key,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool enabled;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final String? Function(String?)? validator;

  @override
  State<CKPasswordField> createState() => _CompanyPasswordFieldState();
}

class _CompanyPasswordFieldState extends State<CKPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.ckcoreTheme.colors;
    final spacing = context.ckcoreTheme.spacing;

    return CKTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: widget.label,
      hint: widget.hint ?? 'Enter password',
      helperText: widget.helperText,
      errorText: widget.errorText,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autoFocus: widget.autoFocus,
      obscureText: _obscure,
      trailing: GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Icon(
          _obscure ? LucideIcons.eyeOff : LucideIcons.eye,
          size: spacing.md,
          color: colors.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Deprecated: Use [CKPasswordField] instead.
@Deprecated('Use CKPasswordField instead')
typedef ckcorepasswordField = CKPasswordField;
