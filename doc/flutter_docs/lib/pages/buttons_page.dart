import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Buttons',
      subtitle: 'Documentation for every file in lib/src/components/buttons.',
      children: [
        DocSection(data: _buttonDoc()),
        DocSection(data: _iconButtonDoc()),
        DocSection(data: _fabDoc()),
      ],
    );
  }
}

ComponentDocData _buttonDoc() {
  const code = '''
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    for (final variant in ButtonVariant.values)
      CkgocButton(
        variant: variant,
        size: ButtonSize.md,
        onPressed: () {},
        child: Text(variant.name),
      ),
  ],
)
''';

  return const ComponentDocData(
    title: 'CkgocButton',
    summary:
        'Core action button. Use it for primary, secondary, outline, ghost, status, and link actions. This demo renders every ButtonVariant and every ButtonSize.',
    demo: _ButtonDemo(),
    code: code,
    params: [
      DocParam(
        name: 'variant',
        type: 'ButtonVariant',
        description: 'Visual style of the button.',
        defaultValue: 'ButtonVariant.primary',
      ),
      DocParam(
        name: 'size',
        type: 'ButtonSize',
        description: 'Controls button height and padding.',
        defaultValue: 'ButtonSize.md',
      ),
      DocParam(
        name: 'onPressed',
        type: 'VoidCallback?',
        description: 'Tap handler. Null disables interaction.',
      ),
      DocParam(
        name: 'child',
        type: 'Widget?',
        description: 'Button content, usually Text or Row.',
      ),
      DocParam(
        name: 'loading',
        type: 'bool',
        description: 'Replaces the child with a spinner.',
        defaultValue: 'false',
      ),
      DocParam(
        name: 'disabled',
        type: 'bool',
        description: 'Forces disabled visuals even if onPressed is non-null.',
        defaultValue: 'false',
      ),
      DocParam(
        name: 'isFullWidth',
        type: 'bool',
        description: 'Expands the button to full available width.',
        defaultValue: 'false',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When should I use disabled versus onPressed: null?',
        answer:
            'Use onPressed: null when the action truly cannot run. Use disabled: true when you want to preserve the callback but temporarily block interaction for state or workflow reasons.',
      ),
      DocFaq(
        question: 'How do I show a busy state?',
        answer:
            'Set loading: true. The component replaces the child with a spinner while keeping size and variant styling consistent.',
      ),
    ],
    notes: [
      'Enum demo coverage: all ButtonVariant values and all ButtonSize values are rendered in the live demo.',
    ],
  );
}

ComponentDocData _iconButtonDoc() {
  const code = '''
CkgocIconButton(
  icon: Icons.settings,
  tooltip: 'Settings',
  onPressed: () {},
)
''';

  return const ComponentDocData(
    title: 'CkgocIconButton',
    summary:
        'Compact icon-first action. Use it for toolbars, table actions, and app chrome.',
    demo: _IconButtonDemo(),
    code: code,
    params: [
      DocParam(
        name: 'icon',
        type: 'IconData',
        description: 'The icon glyph to render.',
        requiredParam: true,
      ),
      DocParam(
        name: 'onPressed',
        type: 'VoidCallback?',
        description: 'Tap handler. Null disables the button.',
      ),
      DocParam(
        name: 'tooltip',
        type: 'String?',
        description: 'Optional tooltip text for hover and accessibility.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'Should I wrap it in Tooltip myself?',
        answer:
            'No. Pass tooltip directly and the component will wrap the button for you.',
      ),
      DocFaq(
        question: 'Can I use custom colors?',
        answer:
            'Not through the public constructor. It intentionally inherits theme tokens for consistency.',
      ),
    ],
  );
}

ComponentDocData _fabDoc() {
  const code = '''
Column(
  children: [
    CkgocFab(icon: Icons.add, onPressed: () {}),
    SizedBox(height: 12),
    CkgocFab(icon: Icons.edit, label: 'Compose', onPressed: () {}),
  ],
)
''';

  return const ComponentDocData(
    title: 'CkgocFab',
    summary:
        'Floating action button. Without a label it renders the classic circular FAB; with a label it renders the extended FAB.',
    demo: _FabDemo(),
    code: code,
    params: [
      DocParam(
        name: 'icon',
        type: 'IconData',
        description: 'Primary FAB icon.',
        requiredParam: true,
      ),
      DocParam(
        name: 'onPressed',
        type: 'VoidCallback?',
        description: 'Tap handler.',
      ),
      DocParam(
        name: 'label',
        type: 'String?',
        description:
            'Optional text label. When present, the extended FAB variant is used.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'How do I switch between regular and extended FAB?',
        answer:
            'Leave label null for the circular version. Provide label to render the extended variant.',
      ),
      DocFaq(
        question: 'Where should I place it?',
        answer:
            'Usually in Scaffold.floatingActionButton, but it can also be embedded directly in docs and dashboards.',
      ),
    ],
  );
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final variant in ButtonVariant.values)
              CkgocButton(
                variant: variant,
                onPressed: () {},
                child: Text(variant.name),
              ),
          ],
        ),
        const VSpace(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final size in ButtonSize.values)
              CkgocButton(
                size: size,
                onPressed: () {},
                child: Text(size.name),
              ),
          ],
        ),
        const VSpace(height: 16),
        const CkgocButton(
          loading: true,
          child: Text('Saving'),
        ),
      ],
    );
  }
}

class _IconButtonDemo extends StatelessWidget {
  const _IconButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CkgocIconButton(
          icon: Icons.settings,
          tooltip: 'Settings',
          onPressed: () {},
        ),
        const HSpace(width: 12),
        const CkgocIconButton(icon: Icons.lock, tooltip: 'Disabled'),
      ],
    );
  }
}

class _FabDemo extends StatelessWidget {
  const _FabDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CkgocFab(icon: Icons.add, onPressed: () {}),
        const VSpace(height: 12),
        CkgocFab(icon: Icons.edit, label: 'Compose', onPressed: () {}),
      ],
    );
  }
}
