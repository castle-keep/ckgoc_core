import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';

class AnimatePage extends StatelessWidget {
  const AnimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'Animation',
      subtitle:
          'CKAnimate wraps any widget with a fade, slide or scale entrance. '
          'Timing and easing come from the brand motion tokens, and the effect '
          'is skipped when the device asks for reduced motion.',
      children: [
        DocSection(
          data: ComponentDocData(
            title: 'CKAnimate',
            summary:
                'Drop-in entrance animation. Wrap a widget, pick a CKAnimation, optionally '
                'delay it. Use CKAnimate.stagger to cascade a list, or change trigger to replay.',
            demo: _AnimateDemo(),
            code: '''
// One widget
CKAnimate(
  animation: CKAnimation.slideUp,
  child: CKCard(title: 'Welcome'),
)

// Cascade a list (each child starts 60ms after the previous)
Column(
  children: CKAnimate.stagger(
    children: [
      CKCard(title: 'One'),
      CKCard(title: 'Two'),
      CKCard(title: 'Three'),
    ],
  ),
)

// Replay whenever a value changes
CKAnimate(
  trigger: selectedTab,
  animation: CKAnimation.fade,
  child: TabContent(selectedTab),
)''',
            params: [
              DocParam(
                name: 'child',
                type: 'Widget',
                description: 'The widget to animate.',
                requiredParam: true,
              ),
              DocParam(
                name: 'animation',
                type: 'CKAnimation',
                defaultValue: 'fade',
                description:
                    'fade, slideUp, slideDown, slideLeft, slideRight or scale.',
              ),
              DocParam(
                name: 'duration',
                type: 'Duration?',
                defaultValue: 'theme motion.slow',
                description: 'Length of the animation.',
              ),
              DocParam(
                name: 'delay',
                type: 'Duration',
                defaultValue: 'Duration.zero',
                description: 'Wait before starting.',
              ),
              DocParam(
                name: 'curve',
                type: 'Curve?',
                defaultValue: 'theme motion.decelerate',
                description: 'Easing curve.',
              ),
              DocParam(
                name: 'offset',
                type: 'double',
                defaultValue: '16',
                description: 'Slide distance in logical pixels.',
              ),
              DocParam(
                name: 'autoPlay',
                type: 'bool',
                defaultValue: 'true',
                description:
                    'When false the animation waits until trigger changes.',
              ),
              DocParam(
                name: 'trigger',
                type: 'Object?',
                description: 'Change this value to replay the animation.',
              ),
              DocParam(
                name: 'CKAnimate.stagger',
                type: 'static List<Widget>',
                description:
                    'Wraps children with increasing delays. Takes animation, interval (default 60ms), duration and curve.',
              ),
            ],
            faqs: [
              DocFaq(
                question: 'Does it respect reduced motion?',
                answer:
                    'Yes. When MediaQuery.disableAnimations is true the child appears immediately.',
              ),
              DocFaq(
                question: 'Why does the list animate again after I scroll back?',
                answer:
                    'Lazy lists (ListView.builder) rebuild items as they re-enter the viewport. '
                        'Animate once-per-screen content, or keep the list items alive.',
              ),
              DocFaq(
                question: 'Can I animate something leaving?',
                answer:
                    'CKAnimate is entrance-only. Use AnimatedSwitcher or AnimatedOpacity for exits.',
              ),
              DocFaq(
                question: 'How do I change the speed brand-wide?',
                answer:
                    'Override the motion tokens on the theme. CKAnimate reads motion.slow and motion.decelerate.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimateDemo extends StatefulWidget {
  const _AnimateDemo();

  @override
  State<_AnimateDemo> createState() => _AnimateDemoState();
}

class _AnimateDemoState extends State<_AnimateDemo> {
  CKAnimation _animation = CKAnimation.slideUp;
  double _durationMs = 300;
  double _delayMs = 0;
  bool _stagger = false;
  int _plays = 0;

  void _replay() => setState(() => _plays++);

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final duration = Duration(milliseconds: _durationMs.round());
    final delay = Duration(milliseconds: _delayMs.round());

    Widget card(String title) => CKCard(
          title: title,
          subtitle: 'Animated with CKAnimate',
          elevated: true,
        );

    final code = StringBuffer()
      ..writeln('CKAnimate(')
      ..writeln('  animation: CKAnimation.${_animation.name},');
    if (_durationMs.round() != 300) {
      code.writeln('  duration: Duration(milliseconds: ${_durationMs.round()}),');
    }
    if (_delayMs.round() != 0) {
      code.writeln('  delay: Duration(milliseconds: ${_delayMs.round()}),');
    }
    code
      ..writeln('  child: CKCard(title: \'Card\'),')
      ..write(')');
    final generated = _stagger
        ? 'Column(\n  children: CKAnimate.stagger(\n    animation: CKAnimation.${_animation.name},\n    children: [card1, card2, card3],\n  ),\n)'
        : code.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Effect', style: theme.typography.labelMd),
        const VSpace(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final a in CKAnimation.values)
              ChoiceChip(
                label: Text(a.name),
                selected: _animation == a,
                onSelected: (_) => setState(() {
                  _animation = a;
                  _plays++;
                }),
              ),
          ],
        ),
        const VSpace(height: 12),
        Row(
          children: [
            SizedBox(width: 110, child: Text('Duration ${_durationMs.round()}ms', style: theme.typography.textSm)),
            Expanded(
              child: Slider(
                value: _durationMs,
                min: 100,
                max: 1200,
                divisions: 11,
                onChanged: (v) => setState(() => _durationMs = v),
                onChangeEnd: (_) => _replay(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 110, child: Text('Delay ${_delayMs.round()}ms', style: theme.typography.textSm)),
            Expanded(
              child: Slider(
                value: _delayMs,
                min: 0,
                max: 1000,
                divisions: 10,
                onChanged: (v) => setState(() => _delayMs = v),
                onChangeEnd: (_) => _replay(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            CKSwitch(
              label: 'Stagger a list',
              value: _stagger,
              onChanged: (v) => setState(() {
                _stagger = v;
                _plays++;
              }),
            ),
            const Spacer(),
            CKButton.outline(
              size: ButtonSize.sm,
              onPressed: _replay,
              child: const Text('Replay'),
            ),
          ],
        ),
        const VSpace(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colors.surfaceVariant,
            borderRadius: BorderRadius.circular(theme.radius.md),
          ),
          // Keying on _plays rebuilds the subtree so every Replay starts fresh.
          child: KeyedSubtree(
            key: ValueKey('$_plays-${_animation.name}-$_stagger'),
            child: _stagger
                ? Column(
                    children: CKAnimate.stagger(
                      animation: _animation,
                      duration: duration,
                      children: [
                        for (final t in ['One', 'Two', 'Three'])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: card(t),
                          ),
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 320,
                      child: CKAnimate(
                        animation: _animation,
                        duration: duration,
                        delay: delay,
                        child: card('Card'),
                      ),
                    ),
                  ),
          ),
        ),
        const VSpace(height: 12),
        CodeBlock(code: generated, title: 'generated code'),
      ],
    );
  }
}
