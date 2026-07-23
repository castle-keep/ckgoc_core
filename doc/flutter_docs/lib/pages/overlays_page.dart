import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class OverlaysPage extends StatelessWidget {
  const OverlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Overlays',
      subtitle: 'Documentation for every file in lib/src/components/overlays.',
      children: [
        DocSection(data: _dialogDoc()),
        DocSection(data: _bottomSheetDoc()),
        DocSection(data: _menuDoc()),
        DocSection(data: _popoverDoc()),
        DocSection(data: _tooltipDoc()),
      ],
    );
  }
}

ComponentDocData _dialogDoc() => const ComponentDocData(
      title: 'CkgocDialog',
      summary:
          'Modal dialog with a standard constructor, a destructive constructor, and static helper methods for showing dialogs.',
      demo: _DialogDemo(),
      code: '''
await CkgocDialog.showDestructive(
  context: context,
  title: 'Delete project?',
  content: Text('This action cannot be undone.'),
  onConfirm: () {
    Navigator.of(context).pop();
  },
)
''',
      params: [
        DocParam(
          name: 'content',
          type: 'Widget',
          description: 'Main dialog body.',
          requiredParam: true,
        ),
        DocParam(
          name: 'title',
          type: 'String?',
          description: 'Optional dialog title.',
        ),
        DocParam(
          name: 'confirmLabel',
          type: 'String',
          description: 'Confirm button text.',
          defaultValue: 'Confirm',
        ),
        DocParam(
          name: 'cancelLabel',
          type: 'String',
          description: 'Cancel button text.',
          defaultValue: 'Cancel',
        ),
        DocParam(
          name: 'onConfirm',
          type: 'VoidCallback?',
          description: 'Confirm action callback.',
        ),
        DocParam(
          name: 'onCancel',
          type: 'VoidCallback?',
          description: 'Cancel action callback.',
        ),
        DocParam(
          name: 'showClose',
          type: 'bool',
          description: 'Shows close affordance in default dialog.',
          defaultValue: 'true',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use destructive?',
          answer:
              'Use it for irreversible or high-risk actions where the dialog should emphasize danger.',
        ),
        DocFaq(
          question: 'Do I have to call Navigator.pop inside onConfirm?',
          answer:
              'Yes, if your confirm handler should close the dialog immediately. The helper does not auto-close for you after custom work.',
        ),
      ],
    );

ComponentDocData _bottomSheetDoc() => const ComponentDocData(
      title: 'CkgocBottomSheet',
      summary:
          'Design-system bottom sheet with direct widget usage and a static show helper.',
      demo: _BottomSheetDemo(),
      code: '''
await CkgocBottomSheet.show(
  context: context,
  title: 'Actions',
  children: [
    ListTile(title: Text('Archive')),
    ListTile(title: Text('Duplicate')),
  ],
)
''',
      params: [
        DocParam(
          name: 'children',
          type: 'List<Widget>',
          description: 'Bottom sheet content widgets.',
          requiredParam: true,
        ),
        DocParam(
          name: 'title',
          type: 'String?',
          description: 'Optional sheet heading.',
        ),
        DocParam(
          name: 'onClose',
          type: 'VoidCallback?',
          description: 'Optional close callback.',
        ),
        DocParam(
          name: 'isDismissible',
          type: 'bool',
          description: 'Helper-only flag controlling barrier dismissal.',
          defaultValue: 'true',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Should I use ListTile or custom content inside children?',
          answer:
              'Either is fine. children is just a widget list, so you can build actions, forms, or multi-step flows.',
        ),
        DocFaq(
          question: 'Can it scroll?',
          answer:
              'Yes. Wrap long content in a scrollable widget inside children when needed.',
        ),
      ],
    );

ComponentDocData _menuDoc() => const ComponentDocData(
      title: 'CkgocMenu',
      summary:
          'Contextual dropdown menu anchored to a trigger widget and populated with CkgocMenuItem actions.',
      demo: _MenuDemo(),
      code: '''
CkgocMenu(
  trigger: CkgocButton(
    variant: ButtonVariant.outline,
    onPressed: null,
    child: Text('Open menu'),
  ),
  items: [
    CkgocMenuItem(
      label: 'Refresh data',
      icon: LucideIcons.refreshCw,
      onTap: refreshDashboard,
    ),
    CkgocMenuItem(
      label: 'Delete view',
      icon: LucideIcons.trash2,
      destructive: true,
      onTap: confirmDelete,
    ),
  ],
)
''',
      params: [
        DocParam(
          name: 'trigger',
          type: 'Widget',
          description: 'Anchor widget that opens the menu.',
          requiredParam: true,
        ),
        DocParam(
          name: 'items',
          type: 'List<CkgocMenuItem>',
          description: 'Menu entries.',
          requiredParam: true,
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How are actions handled?',
          answer:
              'Each CkgocMenuItem accepts an optional onTap callback. The menu resolves the selected item and then invokes that callback.',
        ),
        DocFaq(
          question: 'How should destructive items be represented?',
          answer:
              'Use destructive: true on CkgocMenuItem so the row icon and label are styled with the error color.',
        ),
      ],
      notes: [
        'The trigger can be any widget because CkgocMenu wraps it with its own tap handler.',
        'Use concise labels because the popup width is driven by the item content.',
      ],
    );

ComponentDocData _popoverDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocPopover',
      summary:
          'Popover API surface for anchored floating content. The current package implementation is still a placeholder widget body.',
      demo: _PopoverDemo(),
      code: '''
CkgocPopover(
  trigger: Icon(Icons.info_outline),
  content: Padding(
    padding: EdgeInsets.all(12),
    child: Text('Popover content'),
  ),
)
''',
      params: [
        DocParam(
          name: 'trigger',
          type: 'Widget',
          description: 'Anchor widget.',
          requiredParam: true,
        ),
        DocParam(
          name: 'content',
          type: 'Widget',
          description: 'Floating content.',
          requiredParam: true,
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'How is popover different from tooltip?',
          answer:
              'Popover content can be richer and interactive; tooltip is typically compact and purely informational.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _tooltipDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CkgocTooltip',
      summary:
          'Tooltip API surface for compact helper text. The current package implementation is still a placeholder widget body.',
      demo: _TooltipDemo(),
      code: '''
CkgocTooltip(
  message: 'More information',
  child: Icon(Icons.help_outline),
)
''',
      params: [
        DocParam(
          name: 'message',
          type: 'String',
          description: 'Tooltip text.',
          requiredParam: true,
        ),
        DocParam(
          name: 'child',
          type: 'Widget',
          description: 'Tooltip anchor.',
          requiredParam: true,
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'When should I use tooltip instead of helper text?',
          answer:
              'Use tooltip for contextual, on-demand explanations that should not add persistent visual weight.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

class _DialogDemo extends StatelessWidget {
  const _DialogDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        CkgocButton(
          onPressed: () => CkgocDialog.show(
            context: context,
            title: 'Save changes?',
            content: const Text('This document has unsaved changes.'),
          ),
          child: const Text('Show default dialog'),
        ),
        CkgocButton(
          variant: ButtonVariant.destructive,
          onPressed: () => CkgocDialog.showDestructive(
            context: context,
            title: 'Delete item?',
            content: const Text('This action cannot be undone.'),
          ),
          child: const Text('Show destructive dialog'),
        ),
      ],
    );
  }
}

class _BottomSheetDemo extends StatelessWidget {
  const _BottomSheetDemo();

  @override
  Widget build(BuildContext context) {
    return CkgocButton(
      onPressed: () => CkgocBottomSheet.show(
        context: context,
        title: 'Quick actions',
        children: const [
          ListTile(title: Text('Archive')),
          ListTile(title: Text('Duplicate')),
          ListTile(title: Text('Move')),
        ],
      ),
      child: const Text('Show bottom sheet'),
    );
  }
}

class _MenuDemo extends StatelessWidget {
  const _MenuDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Open the menu to test standard, coming-soon, and destructive actions.',
        ),
        const VSpace(height: 12),
        CkgocMenu(
          trigger: const CkgocContainer(
            variant: ContainerVariant.outlined,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(LucideIcons.moreVertical),
                HSpace(width: 8),
                Text('Open menu'),
              ],
            ),
          ),
          items: [
            CkgocMenuItem(
              label: 'Refresh data',
              icon: LucideIcons.refreshCw,
              onTap: () => CkgocSnackbar.show(
                context,
                'Refresh started.',
                variant: ToastVariant.info,
              ),
            ),
            CkgocMenuItem(
              label: 'Export CSV (Coming soon)',
              icon: LucideIcons.download,
              onTap: () => CkgocSnackbar.show(
                context,
                'Export CSV is coming soon.',
                variant: ToastVariant.warning,
              ),
            ),
            CkgocMenuItem(
              label: 'Delete view',
              icon: LucideIcons.trash2,
              destructive: true,
              onTap: () => CkgocSnackbar.show(
                context,
                'Delete view requires confirmation.',
                variant: ToastVariant.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PopoverDemo extends StatelessWidget {
  const _PopoverDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocPopover(
          trigger: Icon(Icons.info_outline),
          content: Padding(
            padding: EdgeInsets.all(12),
            child: Text('Popover content'),
          ),
        ),
      ],
    );
  }
}

class _TooltipDemo extends StatelessWidget {
  const _TooltipDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        VSpace(height: 12),
        CkgocTooltip(
          message: 'More information',
          child: Icon(Icons.help_outline),
        ),
      ],
    );
  }
}
