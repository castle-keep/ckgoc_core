import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import 'package:ckcore_docs_app/docs_navigation.dart';

/// Landing page: a guided, interactive path from install to first screen.
class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'Get started with ckcoreui',
      subtitle:
          'Install, theme and build your first branded screen in about five minutes. '
          'Everything on this page is live: switch brand or light/dark in the top-right '
          'corner and watch it change.',
      children: [
        _StepsChecklist(),
        VSpace(height: 24),
        _ButtonPlayground(),
        VSpace(height: 24),
        _TokenExplorer(),
        VSpace(height: 24),
        _NextSteps(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared bits
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// 1. Steps with progress
// ---------------------------------------------------------------------------

class _StepData {
  const _StepData(this.title, this.description, this.code, this.codeTitle);
  final String title;
  final String description;
  final String code;
  final String codeTitle;
}

const _steps = <_StepData>[
  _StepData(
    'Install the package',
    'One command. It updates pubspec.yaml and fetches dependencies, including '
        'bundled fonts and brand logos.',
    'flutter pub add ckcoreui',
    'terminal',
  ),
  _StepData(
    'Wrap your app in CKApp',
    'CKApp replaces MaterialApp. It takes the same options plus a brand. '
        'Leave brightness null to follow the device.',
    '''import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      CKApp(
        brand: ckcoreBrand.castleKeep, // or ckcoreBrand.skyGo
        title: 'My App',
        home: const HomePage(),
      ),
    );''',
    'lib/main.dart',
  ),
  _StepData(
    'Build a screen with components and tokens',
    'Components are prefixed CK. Read colours, spacing and type from the '
        'BuildContext instead of hard-coding values.',
    '''class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.ckColors.background,
      body: Padding(
        padding: EdgeInsets.all(context.ckSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back').h2,
            SizedBox(height: context.ckSpacing.md),
            const CKTextField(label: 'Email', hint: 'you@company.com'),
            SizedBox(height: context.ckSpacing.md),
            CKButton(onPressed: () {}, child: const Text('Continue')),
          ],
        ),
      ),
    );
  }
}''',
    'lib/home_page.dart',
  ),
];

class _StepsChecklist extends StatefulWidget {
  const _StepsChecklist();

  @override
  State<_StepsChecklist> createState() => _StepsChecklistState();
}

class _StepsChecklistState extends State<_StepsChecklist> {
  final _done = <int>{};
  int _open = 0;

  void _toggle(int i) {
    setState(() {
      if (_done.contains(i)) {
        _done.remove(i);
        _open = i;
      } else {
        _done.add(i);
        // Jump to the next unfinished step.
        final next = List.generate(_steps.length, (n) => n)
            .where((n) => !_done.contains(n));
        _open = next.isEmpty ? i : next.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final finished = _done.length == _steps.length;

    return DocPanel(
      badge: '5 min',
      title: 'Quick start',
      blurb: 'Tick each step off as you go.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(theme.radius.full),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: _done.length / _steps.length),
              duration: theme.motion.normal,
              curve: Curves.easeOut,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                color: finished ? theme.colors.success : theme.colors.primary,
                backgroundColor: theme.colors.surfaceVariant,
              ),
            ),
          ),
          const VSpace(height: 6),
          Text(
            finished
                ? 'All done. You now have a branded app running.'
                : '${_done.length} of ${_steps.length} steps complete',
            style: theme.typography.labelSm,
          ),
          const VSpace(height: 16),
          for (var i = 0; i < _steps.length; i++) ...[
            _StepTile(
              index: i,
              data: _steps[i],
              done: _done.contains(i),
              open: _open == i,
              onOpen: () => setState(() => _open = _open == i ? -1 : i),
              onToggleDone: () => _toggle(i),
            ),
            const VSpace(height: 8),
          ],
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.data,
    required this.done,
    required this.open,
    required this.onOpen,
    required this.onToggleDone,
  });

  final int index;
  final _StepData data;
  final bool done;
  final bool open;
  final VoidCallback onOpen;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return AnimatedContainer(
      duration: theme.motion.normal,
      decoration: BoxDecoration(
        border: Border.all(
          color: open ? theme.colors.primary : theme.colors.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(theme.radius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(theme.radius.md),
            onTap: onOpen,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: theme.motion.fast,
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done
                          ? theme.colors.success
                          : theme.colors.surfaceVariant,
                    ),
                    child: done
                        ? Icon(Icons.check, size: 16, color: theme.colors.onSuccess)
                        : Text('${index + 1}', style: theme.typography.labelMd),
                  ),
                  const HSpace(width: 12),
                  Expanded(
                    child: Text(
                      data.title,
                      style: theme.typography.labelLg.copyWith(
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  Icon(open ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: theme.motion.normal,
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: open
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.description, style: theme.typography.textSm),
                        const VSpace(height: 12),
                        CodeBlock(code: data.code, title: data.codeTitle),
                        const VSpace(height: 12),
                        CKButton(
                          variant: done
                              ? ButtonVariant.outline
                              : ButtonVariant.primary,
                          size: ButtonSize.sm,
                          onPressed: onToggleDone,
                          child: Text(done ? 'Mark as not done' : 'Done, next'),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Button playground (live preview + generated code)
// ---------------------------------------------------------------------------

class _ButtonPlayground extends StatefulWidget {
  const _ButtonPlayground();

  @override
  State<_ButtonPlayground> createState() => _ButtonPlaygroundState();
}

class _ButtonPlaygroundState extends State<_ButtonPlayground> {
  ButtonVariant _variant = ButtonVariant.primary;
  ButtonSize _size = ButtonSize.md;
  bool _loading = false;
  bool _disabled = false;
  bool _fullWidth = false;
  String _label = 'Save changes';
  int _taps = 0;

  String get _code {
    final args = <String>[
      if (_variant != ButtonVariant.primary) 'variant: ButtonVariant.${_variant.name},',
      if (_size != ButtonSize.md) 'size: ButtonSize.${_size.name},',
      if (_loading) 'loading: true,',
      if (_disabled) 'disabled: true,',
      if (_fullWidth) 'isFullWidth: true,',
      'onPressed: () {},',
      "child: const Text('${_label.replaceAll("'", r"\'")}'),",
    ];
    return 'CKButton(\n${args.map((a) => '  $a').join('\n')}\n)';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocPanel(
      badge: 'Try it',
      title: 'Button playground',
      blurb: 'Change the options and the preview and the code update together.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Variant', style: theme.typography.labelMd),
          const VSpace(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final v in ButtonVariant.values)
                ChoiceChip(
                  label: Text(v.name),
                  selected: _variant == v,
                  onSelected: (_) => setState(() => _variant = v),
                ),
            ],
          ),
          const VSpace(height: 12),
          Text('Size', style: theme.typography.labelMd),
          const VSpace(height: 6),
          Wrap(
            spacing: 6,
            children: [
              for (final s in ButtonSize.values)
                ChoiceChip(
                  label: Text(s.name),
                  selected: _size == s,
                  onSelected: (_) => setState(() => _size = s),
                ),
            ],
          ),
          const VSpace(height: 12),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CKSwitch(
                label: 'loading',
                value: _loading,
                onChanged: (v) => setState(() => _loading = v),
              ),
              CKSwitch(
                label: 'disabled',
                value: _disabled,
                onChanged: (v) => setState(() => _disabled = v),
              ),
              CKSwitch(
                label: 'full width',
                value: _fullWidth,
                onChanged: (v) => setState(() => _fullWidth = v),
              ),
            ],
          ),
          const VSpace(height: 12),
          SizedBox(
            width: 320,
            child: CKTextField(
              label: 'Label',
              value: _label,
              onChanged: (v) => setState(() => _label = v),
            ),
          ),
          const VSpace(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(theme.radius.md),
            ),
            child: Column(
              children: [
                Align(
                  alignment:
                      _fullWidth ? Alignment.center : Alignment.centerLeft,
                  child: CKButton(
                    variant: _variant,
                    size: _size,
                    loading: _loading,
                    disabled: _disabled,
                    isFullWidth: _fullWidth,
                    onPressed: () => setState(() => _taps++),
                    child: Text(_label.isEmpty ? ' ' : _label),
                  ),
                ),
                const VSpace(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _taps == 0
                        ? 'Tap the button.'
                        : 'onPressed fired $_taps time${_taps == 1 ? '' : 's'}',
                    style: theme.typography.textXs,
                  ),
                ),
              ],
            ),
          ),
          const VSpace(height: 12),
          CodeBlock(code: _code, title: 'generated code'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Token explorer
// ---------------------------------------------------------------------------

class _TokenExplorer extends StatefulWidget {
  const _TokenExplorer();

  @override
  State<_TokenExplorer> createState() => _TokenExplorerState();
}

class _TokenExplorerState extends State<_TokenExplorer> {
  String? _copied;

  Future<void> _copy(String accessor) async {
    await Clipboard.setData(ClipboardData(text: accessor));
    if (!mounted) return;
    setState(() => _copied = accessor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final c = theme.colors;
    final colors = <String, Color>{
      'primary': c.primary,
      'secondary': c.secondary,
      'accent': c.accent,
      'background': c.background,
      'surface': c.surface,
      'surfaceVariant': c.surfaceVariant,
      'onSurface': c.onSurface,
      'outline': c.outline,
      'success': c.success,
      'warning': c.warning,
      'error': c.error,
      'info': c.info,
    };
    final spacing = <String, double>{
      'xs': theme.spacing.xs,
      'sm': theme.spacing.sm,
      'md': theme.spacing.md,
      'lg': theme.spacing.lg,
      'xl': theme.spacing.xl,
    };

    return DocPanel(
      badge: 'Tap to copy',
      title: 'Design tokens',
      blurb: 'Values below come from the active brand. Switch brand or mode '
          'in the top-right corner. Tap a token to copy how to use it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Colours  ·  context.ckColors', style: theme.typography.labelMd),
          const VSpace(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final e in colors.entries)
                _Swatch(
                  name: e.key,
                  color: e.value,
                  selected: _copied == 'context.ckColors.${e.key}',
                  onTap: () => _copy('context.ckColors.${e.key}'),
                ),
            ],
          ),
          const VSpace(height: 20),
          Text('Spacing  ·  context.ckSpacing', style: theme.typography.labelMd),
          const VSpace(height: 8),
          for (final e in spacing.entries)
            InkWell(
              onTap: () => _copy('context.ckSpacing.${e.key}'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text(
                        '${e.key}  ${e.value.toStringAsFixed(0)}px',
                        style: theme.typography.codeMd,
                      ),
                    ),
                    AnimatedContainer(
                      duration: theme.motion.normal,
                      height: 14,
                      width: e.value * 4,
                      decoration: BoxDecoration(
                        color: theme.colors.primary,
                        borderRadius: BorderRadius.circular(theme.radius.sm),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const VSpace(height: 20),
          Text('Typography  ·  context.ckTypography',
              style: theme.typography.labelMd),
          const VSpace(height: 8),
          for (final e in <String, TextStyle>{
            'displayLg': theme.typography.displayLg,
            'textXl': theme.typography.textXl,
            'textMd': theme.typography.textMd,
            'labelSm': theme.typography.labelSm,
            'codeMd': theme.typography.codeMd,
          }.entries)
            InkWell(
              onTap: () => _copy('context.ckTypography.${e.key}'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text(e.key, style: theme.typography.codeMd),
                    ),
                    Expanded(
                      child: Text(
                        'The quick brown fox',
                        style: e.value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const VSpace(height: 12),
          AnimatedSwitcher(
            duration: theme.motion.fast,
            child: _copied == null
                ? Text(
                    'Nothing copied yet.',
                    key: const ValueKey('none'),
                    style: theme.typography.textXs,
                  )
                : Row(
                    key: ValueKey(_copied),
                    children: [
                      Icon(Icons.check_circle,
                          size: 16, color: theme.colors.success),
                      const HSpace(width: 6),
                      Flexible(
                        child: Text('Copied $_copied',
                            style: theme.typography.codeMd),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.name,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Tooltip(
      message: 'context.ckColors.$name',
      child: InkWell(
        borderRadius: BorderRadius.circular(theme.radius.md),
        onTap: onTap,
        child: AnimatedContainer(
          duration: theme.motion.fast,
          width: 104,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.radius.md),
            border: Border.all(
              color: selected ? theme.colors.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(theme.radius.sm),
                  border: Border.all(color: theme.colors.outlineVariant),
                ),
              ),
              const VSpace(height: 4),
              Text(name,
                  style: theme.typography.labelSm,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Where next
// ---------------------------------------------------------------------------

class _NextSteps extends StatelessWidget {
  const _NextSteps();

  static const _links = <({String title, String text, String route, IconData icon})>[
    (
      title: 'Buttons',
      text: 'Variants, sizes, icon buttons and FABs.',
      route: '/buttons',
      icon: Icons.smart_button_outlined,
    ),
    (
      title: 'Inputs',
      text: 'Text, password, OTP, dates, dropdowns.',
      route: '/inputs',
      icon: Icons.keyboard_outlined,
    ),
    (
      title: 'Data Table',
      text: 'Sorting, paging, selection, editable cells.',
      route: '/data-table',
      icon: Icons.table_chart_outlined,
    ),
    (
      title: 'AI Tools',
      text: 'MCP server and skills for Copilot, Claude Code, Cursor.',
      route: '/ai-tools',
      icon: Icons.auto_awesome_outlined,
    ),
    (
      title: 'Animation',
      text: 'CKAnimate entrances, with staggered lists.',
      route: '/animate',
      icon: Icons.animation_outlined,
    ),
    (
      title: 'Themes',
      text: 'Brands, brightness and theme access.',
      route: '/themes',
      icon: Icons.palette_outlined,
    ),
    (
      title: 'Foundation',
      text: 'Every colour, spacing and type token.',
      route: '/foundation',
      icon: Icons.foundation_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocPanel(
      title: 'Where to next?',
      blurb: 'Every component page has a live demo, copy-ready code, '
          'a parameter table and FAQs.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final l in _links)
            SizedBox(
              width: 260,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () => currentRoute.value = l.route,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(l.icon, color: theme.colors.primary),
                        const HSpace(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.title, style: theme.typography.labelLg),
                              Text(l.text, style: theme.typography.textXs),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
