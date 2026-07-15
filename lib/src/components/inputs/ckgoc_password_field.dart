import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/inputs/ckgoc_text_field.dart';

/// Password field built on top of `CkgocTextField` with toggleable visibility.
class CkgocPasswordField extends StatefulWidget {
  const CkgocPasswordField({
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
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

  @override
  State<CkgocPasswordField> createState() => _CompanyPasswordFieldState();
}

class _CompanyPasswordFieldState extends State<CkgocPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.ckgocTheme.colors;
    final spacing = context.ckgocTheme.spacing;

    return CkgocTextField(
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
