import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: 'Variants',
            spacing: s,
            children: [
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.primary,
                child: Text('Primary'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.secondary,
                child: Text('Secondary'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.outline,
                child: Text('Outline'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.ghost,
                child: Text('Ghost'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.accent,
                child: Text('Accent'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.destructive,
                child: Text('Destructive'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.success,
                child: Text('Success'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.warning,
                child: Text('Warning'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.info,
                child: Text('Info'),
              ),
              const CkgocButton(
                onPressed: _noop,
                variant: ButtonVariant.link,
                child: Text('Link'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'Sizes',
            spacing: s,
            children: [
              const CkgocButton(
                onPressed: _noop,
                size: ButtonSize.xs,
                child: Text('XS  32dp'),
              ),
              const CkgocButton(
                onPressed: _noop,
                size: ButtonSize.sm,
                child: Text('SM  40dp'),
              ),
              const CkgocButton(
                onPressed: _noop,
                size: ButtonSize.md,
                child: Text('MD  48dp'),
              ),
              const CkgocButton(
                onPressed: _noop,
                size: ButtonSize.lg,
                child: Text('LG  56dp'),
              ),
              const CkgocButton(
                onPressed: _noop,
                size: ButtonSize.xl,
                child: Text('XL  64dp'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'States',
            spacing: s,
            children: [
              const CkgocButton(onPressed: _noop, child: Text('Default')),
              const CkgocButton(
                onPressed: _noop,
                loading: true,
                child: Text('Loading'),
              ),
              const CkgocButton(
                onPressed: _noop,
                disabled: true,
                child: Text('Disabled'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'Full width',
            spacing: s,
            children: [
              const CkgocButton(
                onPressed: _noop,
                isFullWidth: true,
                child: Text('Full Width Primary'),
              ),
              const CkgocButton(
                onPressed: _noop,
                isFullWidth: true,
                variant: ButtonVariant.outline,
                child: Text('Full Width Outline'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    required this.spacing,
  });
  final String title;
  final List<Widget> children;
  final CkgocSpacing spacing;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.typography.labelSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: spacing.sm),
        Wrap(spacing: spacing.sm, runSpacing: spacing.sm, children: children),
      ],
    );
  }
}
