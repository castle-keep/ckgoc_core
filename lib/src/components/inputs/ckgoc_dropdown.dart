import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';

/// Dropdown component styled to match `CkgocTextField`.
class CkgocDropdown<T> extends StatefulWidget {
  const CkgocDropdown({
    this.items,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.borderless = false,
    this.menuMaxHeight = 400,
    this.menuMinHeight = 144,
    super.key,
  });

  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
  final bool borderless;
  final double menuMaxHeight;
  final double menuMinHeight;

  @override
  State<CkgocDropdown<T>> createState() => _CkgocDropdownState<T>();
}

class _CkgocDropdownState<T> extends State<CkgocDropdown<T>> {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _showAbove = false;
  double _menuHeight = 0;
  double _fieldWidth = 0;
  double _fieldHeight = 0;

  List<DropdownMenuItem<T>> get _items =>
      widget.items ?? <DropdownMenuItem<T>>[];

  DropdownMenuItem<T>? get _selectedItem {
    for (final item in _items) {
      if (item.value == widget.value) return item;
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant CkgocDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enabled || _items.isEmpty) _closeMenu();
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    if (!widget.enabled || _items.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final theme = context.ckgocTheme;
    final mediaQuery = MediaQuery.of(context);
    final spacing = theme.spacing;
    final fieldOffset = renderBox.localToGlobal(Offset.zero);
    final fieldSize = renderBox.size;
    final availableAbove = math.max(
      0.0,
      fieldOffset.dy - mediaQuery.padding.top - spacing.xs,
    );
    final availableBelow = math.max(
      0.0,
      mediaQuery.size.height -
          mediaQuery.viewInsets.bottom -
          mediaQuery.padding.bottom -
          fieldOffset.dy -
          fieldSize.height -
          spacing.xs,
    );

    var showAbove = availableBelow < widget.menuMinHeight && availableAbove > 0;
    var availableHeight = showAbove ? availableAbove : availableBelow;

    if (availableHeight <= 0) {
      showAbove = availableAbove > availableBelow;
      availableHeight = showAbove ? availableAbove : availableBelow;
    }

    final menuHeight = math.min(widget.menuMaxHeight, availableHeight);
    if (menuHeight <= 0) return;

    setState(() {
      _isOpen = true;
      _showAbove = showAbove;
      _menuHeight = menuHeight;
      _fieldWidth = fieldSize.width;
      _fieldHeight = fieldSize.height;
    });

    _overlayEntry = OverlayEntry(builder: (_) => _buildOverlay());
    overlay.insert(_overlayEntry!);
  }

  void _closeMenu() {
    if (_isOpen) {
      setState(() => _isOpen = false);
    }
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildOverlay() {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final offset = Offset(
      0,
      _showAbove ? -(_menuHeight + spacing.xs) : _fieldHeight + spacing.xs,
    );

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeMenu,
          ),
        ),
        CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: _fieldWidth,
              constraints: BoxConstraints(
                minWidth: _fieldWidth,
                maxWidth: _fieldWidth,
                maxHeight: _menuHeight,
              ),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(radius.base),
                border: Border.all(color: colors.outline),
                boxShadow: [
                  BoxShadow(
                    color: colors.onSurface.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius.base),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: spacing.xs),
                  shrinkWrap: true,
                  itemCount: _items.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: colors.outline.withValues(alpha: 0.6),
                  ),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final isEnabled = item.enabled;
                    final isSelected = item.value == widget.value;

                    return InkWell(
                      onTap: isEnabled
                          ? () {
                              widget.onChanged?.call(item.value);
                              _closeMenu();
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spacing.s12,
                          vertical: spacing.sm,
                        ),
                        color: isSelected
                            ? colors.primary.withValues(alpha: 0.08)
                            : null,
                        child: DefaultTextStyle(
                          style: typography.textMd.copyWith(
                            color: isEnabled
                                ? colors.onSurface
                                : colors.onSurfaceVariant,
                          ),
                          child: item.child,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final hasError = widget.errorText != null;
    final hasSuccess = widget.successText != null && !hasError;

    OutlineInputBorder border(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
          borderRadius: BorderRadius.circular(radius.base),
        );

    final ringColor = hasError
        ? colors.error.withValues(alpha: 0.2)
        : colors.primary.withValues(alpha: 0.2);
    final suffixIcon =
        widget.trailing ??
        Icon(
          _isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
          size: spacing.md,
          color: colors.onSurfaceVariant,
        );
    final selectedItem = _selectedItem;

    final decoration = widget.borderless
        ? InputDecoration(
            helperText: hasSuccess ? widget.successText : widget.helperText,
            errorText: widget.errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: false,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
        : InputDecoration(
            helperText: hasSuccess ? widget.successText : widget.helperText,
            helperStyle: typography.textSm.copyWith(
              color: hasSuccess ? colors.success : colors.onSurfaceVariant,
            ),
            errorText: widget.errorText,
            errorStyle: typography.textSm.copyWith(color: colors.error),
            filled: true,
            fillColor: widget.enabled ? colors.surface : colors.muted,
            contentPadding: EdgeInsets.symmetric(
              horizontal: spacing.s12,
              vertical: spacing.sm,
            ),
            enabledBorder: border(hasSuccess ? colors.success : colors.outline),
            focusedBorder: border(colors.primary, width: spacing.xxs),
            errorBorder: border(colors.error),
            focusedErrorBorder: border(colors.error, width: spacing.xxs),
            disabledBorder: border(colors.outline),
          );

    final field = CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleMenu,
        behavior: HitTestBehavior.opaque,
        child: Container(
          key: _fieldKey,
          child: InputDecorator(
            isEmpty: widget.value == null,
            isFocused: _isOpen,
            decoration: decoration,
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  SizedBox(width: spacing.sm),
                ],
                Expanded(
                  child: selectedItem != null
                      ? DefaultTextStyle(
                          style: typography.textMd.copyWith(
                            color: widget.enabled
                                ? colors.onSurface
                                : colors.onSurfaceVariant,
                          ),
                          child: selectedItem.child,
                        )
                      : Text(
                          widget.hint ?? '',
                          style: typography.textMd.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                ),
                SizedBox(width: spacing.sm),
                suffixIcon,
              ],
            ),
          ),
        ),
      ),
    );

    final wrapped = AnimatedContainer(
      duration: theme.motion.fast,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.base),
        boxShadow: _isOpen
            ? [BoxShadow(color: ringColor, spreadRadius: 3, blurRadius: 0)]
            : const [],
      ),
      child: field,
    );

    if (widget.label == null) return wrapped;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label!,
          style: typography.labelMd.copyWith(color: colors.onSurface),
        ),
        SizedBox(height: spacing.xs),
        wrapped,
      ],
    );
  }
}
