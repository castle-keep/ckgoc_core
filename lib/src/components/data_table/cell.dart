import 'package:ckgoc_core/src/components/data_table/ckgoc_table_column.dart';
import 'package:ckgoc_core/src/components/display/ckgoc_avatar.dart';
import 'package:ckgoc_core/src/components/display/ckgoc_badge.dart';
import 'package:ckgoc_core/src/components/inputs/ckgoc_text_field.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class TableCellWidget extends StatelessWidget {
  const TableCellWidget({
    required this.column,
    required this.value,
    required this.row,
    this.editController,
    this.onCellChanged,
    super.key,
  });
  final CkgocTableColumn column;
  final dynamic value;
  final Map<String, dynamic> row;
  final TextEditingController? editController;
  final ValueChanged<dynamic>? onCellChanged;

  @override
  Widget build(BuildContext context) {
    if (editController != null) {
      return EditableCellWidget(
        controller: editController!,
        onChanged: onCellChanged,
      );
    }
    if (column.cellBuilder != null) {
      return column.cellBuilder!(value, row);
    }
    return switch (column.type) {
      CkgocColumnType.badge => _badgeCell(context),
      CkgocColumnType.avatarText => _avatarTextCell(context),
      CkgocColumnType.progress => _progressCell(context),
      CkgocColumnType.custom => const SizedBox.shrink(),
      CkgocColumnType.text => _textCell(context),
    };
  }

  Widget _textCell(BuildContext context) {
    final theme = context.ckgocTheme;
    return Text(
      value?.toString() ?? '',
      style: theme.typography.textSm.copyWith(color: theme.colors.onSurface),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _badgeCell(BuildContext context) {
    final variant =
        column.badgeVariantBuilder?.call(value) ?? BadgeVariant.defaultFill;
    return CkgocBadge(label: value?.toString() ?? '', variant: variant);
  }

  Widget _avatarTextCell(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final label = value?.toString() ?? '';
    final initials = _initials(label);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CkgocAvatar(initials: initials, size: AvatarSize.sm),
        SizedBox(width: s.sm),
        Flexible(
          child: Text(
            label,
            style: theme.typography.labelSm.copyWith(
              color: theme.colors.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _progressCell(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final pct = (value is num ? (value as num).toDouble() : 0.0).clamp(
      0.0,
      1.0,
    );

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(theme.radius.full),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: theme.colors.outlineVariant,
              valueColor: AlwaysStoppedAnimation(theme.colors.primary),
              minHeight: s.xs,
            ),
          ),
        ),
        SizedBox(width: s.sm),
        Text(
          '${(pct * 100).round()}%',
          style: theme.typography.labelSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

class EditableCellWidget extends StatelessWidget {
  const EditableCellWidget({
    required this.controller,
    this.onChanged,
    super.key,
  });
  final TextEditingController controller;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) {
    return CkgocTextField(
      controller: controller,
      hint: null,
      onChanged: onChanged == null ? null : (v) => onChanged!(v),
      maxLines: 1,
      borderless: true,
    );
  }
}
