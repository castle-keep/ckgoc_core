import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.primary,
                child: const Text('Primary'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.secondary,
                child: const Text('Secondary'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.outline,
                child: const Text('Outline'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.ghost,
                child: const Text('Ghost'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.accent,
                child: const Text('Accent'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.destructive,
                child: const Text('Destructive'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.success,
                child: const Text('Success'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.warning,
                child: const Text('Warning'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.info,
                child: const Text('Info'),
              ),
              CKButton(
                onPressed: _noop,
                variant: ButtonVariant.link,
                child: const Text('Link'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'Sizes',
            spacing: s,
            children: [
              CKButton(
                onPressed: _noop,
                size: ButtonSize.xs,
                child: const Text('XS  32dp'),
              ),
              CKButton(
                onPressed: _noop,
                size: ButtonSize.sm,
                child: const Text('SM  40dp'),
              ),
              CKButton(
                onPressed: _noop,
                size: ButtonSize.md,
                child: const Text('MD  48dp'),
              ),
              CKButton(
                onPressed: _noop,
                size: ButtonSize.lg,
                child: const Text('LG  56dp'),
              ),
              CKButton(
                onPressed: _noop,
                size: ButtonSize.xl,
                child: const Text('XL  64dp'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'States',
            spacing: s,
            children: [
              CKButton(onPressed: _noop, child: const Text('Default')),
              CKButton(
                onPressed: _noop,
                loading: true,
                child: const Text('Loading'),
              ),
              CKButton(
                onPressed: _noop,
                disabled: true,
                child: const Text('Disabled'),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _Section(
            title: 'Full width',
            spacing: s,
            children: [
              CKButton(
                onPressed: _noop,
                isFullWidth: true,
                child: const Text('Full Width Primary'),
              ),
              CKButton(
                onPressed: _noop,
                isFullWidth: true,
                variant: ButtonVariant.outline,
                child: const Text('Full Width Outline'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ckcoreSpacing spacing;

  const _Section({
    required this.title,
    required this.children,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
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
