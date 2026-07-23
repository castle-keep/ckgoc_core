import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

class OverlaysScreen extends StatefulWidget {
  const OverlaysScreen({super.key});

  @override
  State<OverlaysScreen> createState() => _OverlaysScreenState();
}

class _OverlaysScreenState extends State<OverlaysScreen> {
  int _drawerSelected = 0;

  void _showMenuMessage(String message) {
    CkgocSnackbar.show(context, message, variant: ToastVariant.info);
  }

  static const _drawerItems = [
    CkgocDrawerItem(icon: LucideIcons.layoutDashboard, label: 'Dashboard'),
    CkgocDrawerItem(icon: LucideIcons.barChart2, label: 'Analytics'),
    CkgocDrawerItem(icon: LucideIcons.users, label: 'Users'),
    CkgocDrawerItem(icon: LucideIcons.package, label: 'Products'),
    CkgocDrawerItem(icon: LucideIcons.settings, label: 'Settings'),
    CkgocDrawerItem(icon: LucideIcons.helpCircle, label: 'Help'),
  ];

  Widget _label(String text, CkgocThemeData theme) => Padding(
    padding: EdgeInsets.only(bottom: theme.spacing.sm),
    child: Text(
      text,
      style: theme.typography.labelSm.copyWith(
        color: theme.colors.onSurfaceVariant,
        letterSpacing: 0.8,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final r = theme.radius;

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('DIALOGS', theme),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: [
              CkgocButton(
                variant: ButtonVariant.outline,
                onPressed: () => CkgocDialog.show(
                  context: context,
                  title: 'Dialog Title',
                  content: const Text(
                    'This is the dialog body content. Confirm that you want to proceed with this action.',
                  ),
                  confirmLabel: 'Confirm',
                  cancelLabel: 'Cancel',
                  onConfirm: () => Navigator.of(context).pop(),
                ),
                child: const Text('Default Dialog'),
              ),
              CkgocButton(
                variant: ButtonVariant.destructive,
                onPressed: () => CkgocDialog.showDestructive(
                  context: context,
                  title: 'Delete Item',
                  content: const Text(
                    'This cannot be undone.\nAre you sure you want to delete?',
                  ),
                  confirmLabel: 'Yes, Delete Permanently',
                  cancelLabel: 'Cancel',
                  onConfirm: () => Navigator.of(context).pop(),
                ),
                child: const Text('Destructive Dialog'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('BOTTOM SHEET', theme),
          CkgocButton(
            variant: ButtonVariant.outline,
            onPressed: () => CkgocBottomSheet.show(
              context: context,
              title: 'Share Options',
              children: [
                _SheetItem(icon: LucideIcons.link, label: 'Copy Link'),
                _SheetItem(icon: LucideIcons.mail, label: 'Send Email'),
                _SheetItem(
                  icon: LucideIcons.messageCircle,
                  label: 'Share via Chat',
                ),
                _SheetItem(icon: LucideIcons.smartphone, label: 'Share to App'),
              ],
            ),
            child: const Text('Open Bottom Sheet'),
          ),
          SizedBox(height: s.xl),
          _label('MENU', theme),
          CkgocMenu(
            trigger: CkgocButton(
              variant: ButtonVariant.outline,
              onPressed: null,
              child: const Text('Open Menu'),
            ),
            items: [
              CkgocMenuItem(
                label: 'Refresh data',
                icon: LucideIcons.refreshCw,
                onTap: () => _showMenuMessage('Refresh started.'),
              ),
              CkgocMenuItem(
                label: 'Pin dashboard',
                icon: LucideIcons.pin,
                onTap: () => _showMenuMessage('Dashboard pinned.'),
              ),
              CkgocMenuItem(
                label: 'Export CSV (Coming soon)',
                icon: LucideIcons.download,
                onTap: () => _showMenuMessage('Export CSV is coming soon.'),
              ),
              CkgocMenuItem(
                label: 'Delete view',
                icon: LucideIcons.trash2,
                destructive: true,
                onTap: () =>
                    _showMenuMessage('Delete view requires confirmation.'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('DRAWER', theme),
          SizedBox(
            height: 420,
            width: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(r.lg),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: c.outline),
                  borderRadius: BorderRadius.circular(r.lg),
                ),
                child: _DrawerPreview(
                  items: _drawerItems,
                  selected: _drawerSelected,
                  onSelected: (i) => setState(() => _drawerSelected = i),
                ),
              ),
            ),
          ),
          SizedBox(height: s.xl),
        ],
      ),
    );
  }
}

class _SheetItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SheetItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.lg,
          vertical: theme.spacing.sm + 4,
        ),
        child: Row(
          children: [
            Icon(icon, size: theme.spacing.md, color: theme.colors.onSurface),
            SizedBox(width: theme.spacing.md),
            Text(
              label,
              style: theme.typography.textMd.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerPreview extends StatelessWidget {
  final List<CkgocDrawerItem> items;
  final int selected;
  final ValueChanged<int> onSelected;

  const _DrawerPreview({
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final radius = theme.radius;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: colors.primary,
          width: double.infinity,
          padding: EdgeInsets.all(spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.onPrimary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(radius.md),
                ),
                child: Icon(
                  LucideIcons.layers,
                  size: 20,
                  color: colors.onPrimary,
                ),
              ),
              SizedBox(height: spacing.sm),
              Text(
                'My App',
                style: typography.labelLg.copyWith(color: colors.onPrimary),
              ),
              SizedBox(height: spacing.xs),
              Text(
                'user@example.com',
                style: typography.textSm.copyWith(
                  color: colors.onPrimary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.xs,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) {
              final isSelected = i == selected;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(radius.base),
                ),
                child: InkWell(
                  onTap: () => onSelected(i),
                  borderRadius: BorderRadius.circular(radius.base),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.md,
                      vertical: spacing.sm + 2,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          items[i].icon,
                          size: spacing.md,
                          color: isSelected
                              ? colors.primary
                              : colors.onSurfaceVariant,
                        ),
                        SizedBox(width: spacing.sm),
                        Text(
                          items[i].label,
                          style: typography.labelMd.copyWith(
                            color: isSelected
                                ? colors.primary
                                : colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
