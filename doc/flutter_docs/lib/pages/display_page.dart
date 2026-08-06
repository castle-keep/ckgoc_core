import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import '../docs/mappings.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Display Components',
      subtitle: 'Documentation for every file in lib/src/components/display.',
      children: [
        DocSection(data: _accordionDoc()),
        DocSection(data: _avatarDoc()),
        DocSection(data: _badgeDoc()),
        DocSection(data: _cardDoc()),
        DocSection(data: _chipsDoc()),
        DocSection(data: _containerDoc()),
        DocSection(data: _dividerDoc()),
        DocSection(data: _listTileDoc()),
        DocSection(data: _stepperDoc()),
        DocSection(data: _timelineDoc()),
      ],
    );
  }
}

ComponentDocData _accordionDoc() {
  const code = '''
CKAccordion(
  initiallyExpanded: 0,
  allowMultiple: false,
  items: const [
    CKAccordionItem(title: 'First', content: Text('Content A')),
    CKAccordionItem(title: 'Second', content: Text('Content B')),
  ],
)
''';
  return const ComponentDocData(
    title: 'CKAccordion',
    summary:
        'Expandable content groups. Useful for FAQs, settings sections, and content disclosure patterns.',
    demo: _AccordionDemo(),
    code: code,
    params: [
      DocParam(
        name: 'items',
        type: 'List<CKAccordionItem>',
        description: 'Accordion sections to render.',
      ),
      DocParam(
        name: 'initiallyExpanded',
        type: 'int?',
        description: 'Initial expanded item index.',
      ),
      DocParam(
        name: 'allowMultiple',
        type: 'bool',
        description: 'Allows multiple panels to stay open.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'How do I provide rich content?',
        answer:
            'Each item accepts a Widget as content, so you can pass columns, forms, or custom layouts.',
      ),
      DocFaq(
        question: 'Can more than one item be open?',
        answer: 'Yes. Set allowMultiple: true.',
      ),
    ],
  );
}

ComponentDocData _avatarDoc() {
  const code = '''
Wrap(
  spacing: 12,
  runSpacing: 12,
  children: [
    for (final size in AvatarSize.values)
      CKAvatar(initials: 'CK', size: size, status: AvatarStatus.online),
  ],
)
''';
  return const ComponentDocData(
    title: 'CKAvatar and CKAvatarGroup',
    summary:
        'Identity primitives for users, teams, assignees, and participants. The demo covers every AvatarSize and every AvatarStatus.',
    demo: _AvatarDemo(),
    code: code,
    params: [
      DocParam(
        name: 'initials',
        type: 'String?',
        description: 'Initials shown when no image is provided.',
      ),
      DocParam(
        name: 'image',
        type: 'ImageProvider?',
        description: 'Avatar image source.',
      ),
      DocParam(
        name: 'size',
        type: 'AvatarSize',
        description: 'Token-based avatar size.',
      ),
      DocParam(
        name: 'status',
        type: 'AvatarStatus?',
        description: 'Optional presence indicator.',
      ),
      DocParam(
        name: 'backgroundColor',
        type: 'Color?',
        description: 'Manual background override for initials avatars.',
      ),
      DocParam(
        name: 'square',
        type: 'bool',
        description: 'Renders a rounded square instead of a circle.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When should I use initials instead of image?',
        answer:
            'Use initials when the profile image is unavailable or you want deterministic theme-colored placeholders.',
      ),
      DocFaq(
        question: 'How do I show several users together?',
        answer:
            'Use CKAvatarGroup with a list of avatars and adjust maxVisible.',
      ),
    ],
    notes: [
      'Enum demo coverage: all AvatarSize and AvatarStatus values are rendered.',
    ],
  );
}

ComponentDocData _badgeDoc() {
  const code = '''
// Default constructor for primary badge
CKBadge(label: 'New')

// Named constructors for other variants
CKBadge.success(label: 'Approved')
''';
  return const ComponentDocData(
    title: 'CKBadge',
    summary:
        'Status, counters, and compact labeling. The live demo renders every BadgeVariant including presence badges.',
    demo: _BadgeDemo(),
    code: code,
    params: [
      DocParam(
        name: 'label',
        type: 'String',
        description: 'Visible badge text.',
        requiredParam: true,
      ),
      DocParam(
        name: 'variant',
        type: 'BadgeVariant',
        description:
            'Visual badge style. Deprecated: prefer named constructors like `CKBadge.success()`; the `variant` parameter will become internal.',
        defaultValue: 'BadgeVariant.error',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'Which variants are best for system state?',
        answer:
            'Use success, warning, error, info, or presence-specific variants such as online and offline.',
      ),
    ],
    notes: [
      'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
      'Enum demo coverage: all BadgeVariant values are rendered.',
      'Named constructors: CKBadge.success, CKBadge.error, CKBadge.outline, CKBadge.online/offline presence variants.',
      'Accessibility: Prefer succinct `label` text; use presence variants with explicit semantics when conveying availability.',
      'See also: CKAvatar for presence displays and CKCard for labeled status surfaces.',
    ],
  );
}

ComponentDocData _cardDoc() {
  const code = '''
// Default constructor for neutral/default card
CKCard(
  title: 'Quarterly report',
  subtitle: 'Updated 5 minutes ago',
  description: 'Revenue increased by 18% month over month.',
  action: CKButton(onPressed: () {}, child: Text('Open')),
)

// Named constructors for semantic variants
CKCard.success(...)
CKCard.warning(...)
CKCard.error(...)
''';
  return const ComponentDocData(
    title: 'CKCard',
    summary:
        'Content surface for summaries, actions, and dashboard modules. The demo covers every CardVariant and both CardLayout values.',
    demo: _CardDemo(),
    code: code,
    params: [
      DocParam(
        name: 'title',
        type: 'String',
        description: 'Main card heading.',
      ),
      DocParam(
        name: 'subtitle',
        type: 'String?',
        description: 'Secondary heading text.',
      ),
      DocParam(name: 'description', type: 'String?', description: 'Body copy.'),
      DocParam(
        name: 'media',
        type: 'Widget?',
        description: 'Optional visual content area.',
      ),
      DocParam(
        name: 'action',
        type: 'Widget?',
        description: 'Primary action slot, often a button.',
      ),
      DocParam(
        name: 'trailing',
        type: 'Widget?',
        description: 'Trailing slot for metadata or menus.',
      ),
      DocParam(
        name: 'layout',
        type: 'CardLayout',
        description: 'Vertical or horizontal arrangement.',
      ),
      DocParam(
        name: 'variant',
        type: 'CardVariant',
        description: 'Surface meaning and styling.',
      ),
      DocParam(
        name: 'onTap',
        type: 'VoidCallback?',
        description: 'Turns the card into a tappable surface.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When do I use onTap versus action?',
        answer:
            'Use onTap when the whole card should navigate. Use action for an explicit button inside the card.',
      ),
      DocFaq(
        question: 'How do I place charts or images?',
        answer: 'Pass them through the media slot.',
      ),
    ],
    notes: [
      'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
      'Enum demo coverage: all CardVariant values plus horizontal and vertical layouts are rendered.',
      'Named constructors: CKCard.success, CKCard.warning, CKCard.error, CKCard.info.',
      'Accessibility: When using `onTap` ensure the card content provides a clear, accessible label; prefer including an explicit action button for important primary actions.',
      'See also: CKContainer for simple surface wrapping.',
    ],
  );
}

ComponentDocData _chipsDoc() {
  const code = '''
Wrap(
  spacing: 8,
  children: [
    for (final state in ChipState.values)
      CKFilterChip(label: state.name, state: state),
  ],
)
''';
  return const ComponentDocData(
    title: 'CKFilterChip and CKInputChip',
    summary:
        'Compact selection and token components. The demo covers every ChipState for both chip types.',
    demo: _ChipDemo(),
    code: code,
    params: [
      DocParam(
        name: 'label',
        type: 'String',
        description: 'Visible chip text.',
      ),
      DocParam(
        name: 'selected',
        type: 'bool',
        description: 'Filter-chip selection state.',
      ),
      DocParam(
        name: 'onTap',
        type: 'VoidCallback?',
        description: 'Filter-chip tap handler.',
      ),
      DocParam(
        name: 'state',
        type: 'ChipState',
        description: 'Shared state enum for filter and input chips.',
      ),
      DocParam(
        name: 'onRemove',
        type: 'VoidCallback?',
        description: 'Input-chip remove handler.',
      ),
      DocParam(
        name: 'leading',
        type: 'Widget?',
        description: 'Input-chip leading widget.',
      ),
    ],
    faqs: [
      DocFaq(
        question:
            'What is the difference between FilterChip and InputChip here?',
        answer:
            'Filter chips represent selectable filters. Input chips represent entered tokens and can show a remove affordance.',
      ),
      DocFaq(
        question: 'How do I show a validation problem?',
        answer:
            'Use ChipState.error to switch the component into error styling.',
      ),
    ],
    notes: [
      'Enum demo coverage: all ChipState values are rendered for both chip types.',
    ],
  );
}

ComponentDocData _containerDoc() {
  const code = '''
// Default constructor for surface container
CKContainer(
  elevated: true,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Contained content'),
  ),
)

// Named constructors for other variants
CKContainer.outlined(...)
CKContainer.muted(...)
''';
  return const ComponentDocData(
    title: 'CKContainer',
    summary:
        'Reusable themed surface wrapper. The demo renders every ContainerVariant with and without elevation.',
    demo: _ContainerDemo(),
    code: code,
    params: [
      DocParam(
        name: 'child',
        type: 'Widget',
        description: 'Content inside the container.',
        requiredParam: true,
      ),
      DocParam(
        name: 'variant',
        type: 'ContainerVariant',
        description: 'Surface style.',
        defaultValue: 'ContainerVariant.surface',
      ),
      DocParam(
        name: 'padding',
        type: 'EdgeInsetsGeometry?',
        description: 'Optional custom padding.',
      ),
      DocParam(
        name: 'elevated',
        type: 'bool',
        description: 'Adds depth styling.',
        defaultValue: 'false',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'Should I always pass padding?',
        answer:
            'Only if the default spacing does not fit your layout. It is acceptable to let inner children control their own spacing.',
      ),
      DocFaq(
        question: 'What is the difference between outlined and elevated?',
        answer:
            'Outlined emphasizes border structure. Elevated emphasizes shadow or depth.',
      ),
    ],
    notes: [
      'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
      'Enum demo coverage: all ContainerVariant values are rendered.',
      'Named constructors/variants: CKContainer.outlined, CKContainer.muted, CKContainer (surface).',
      'Accessibility: Containers are visual wrappers only; ensure interactive children expose semantics and focus behavior.',
    ],
  );
}

ComponentDocData _dividerDoc() {
  const code = '''
Column(
  children: [
    Text('Above'),
    CKDivider(),
    Text('Below'),
  ],
)
''';
  return const ComponentDocData(
    comingSoon: true,
    title: 'CKDivider',
    summary:
        'Simple separator widget. The public API is intentionally small: horizontal or vertical via the direction parameter.',
    demo: _DividerDemo(),
    code: code,
    params: [
      DocParam(
        name: 'direction',
        type: 'Axis',
        description: 'Separator direction.',
        defaultValue: 'Axis.horizontal',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When do I use vertical?',
        answer:
            'Use vertical when separating content inside rows or toolbar clusters.',
      ),
      DocFaq(
        question: 'Can I customize thickness here?',
        answer:
            'Not through the current public API. Keep this component for consistent token-based separators.',
      ),
    ],
    notes: [
      'Implementation status: placeholder in the package source (returns SizedBox.shrink()).',
      'When implemented: the public API will remain intentionally small; thickness and color will follow design tokens.',
    ],
  );
}

ComponentDocData _listTileDoc() {
  const code = '''
CKListTile(
  leading: Icon(Icons.person),
  title: Text('Profile'),
  subtitle: Text('Manage your account'),
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)
''';
  return const ComponentDocData(
    title: 'CKListTile',
    summary:
        'Simple list row wrapper for navigation or settings-style layouts.',
    demo: _ListTileDemo(),
    code: code,
    comingSoon: true,
    params: [
      DocParam(
        name: 'title',
        type: 'Widget',
        description: 'Primary row content.',
        requiredParam: true,
      ),
      DocParam(
        name: 'leading',
        type: 'Widget?',
        description: 'Leading visual.',
      ),
      DocParam(
        name: 'subtitle',
        type: 'Widget?',
        description: 'Secondary content under the title.',
      ),
      DocParam(
        name: 'trailing',
        type: 'Widget?',
        description: 'Trailing icon or metadata.',
      ),
      DocParam(
        name: 'onTap',
        type: 'VoidCallback?',
        description: 'Tap handler.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When should I use this instead of ListTile?',
        answer:
            'Use it when you want package-consistent spacing and style without manually aligning Flutter ListTile to the design system.',
      ),
      DocFaq(
        question: 'Can title be more than text?',
        answer: 'Yes. It is a Widget, so it can be any custom composition.',
      ),
    ],
    notes: [
      'Implementation status: placeholder in the package source. The API is intentionally small to match design tokens; rendering will be implemented to match spacing conventions.',
      'Accessibility: When implemented, ensure `title` and `subtitle` provide meaningful text; wrap non-text content with `Semantics` as needed.',
    ],
  );
}

ComponentDocData _stepperDoc() {
  const code = '''
CKStepper(
  orientation: CKStepperOrientation.horizontal,
  steps: const [
    CKStep(title: 'Requested', status: StepStatus.completed),
    CKStep(title: 'Approved', status: StepStatus.inProgress),
    CKStep(title: 'Done', status: StepStatus.pending),
  ],
)
''';
  return const ComponentDocData(
    title: 'CKStepper',
    summary:
        'Progress through discrete steps. The live demo covers every StepStatus and both stepper orientations.',
    demo: _StepperDemo(),
    code: code,
    params: [
      DocParam(
        name: 'steps',
        type: 'List<CKStep>',
        description: 'Ordered steps to render.',
      ),
      DocParam(
        name: 'orientation',
        type: 'CKStepperOrientation',
        description: 'Vertical or horizontal layout.',
      ),
      DocParam(
        name: 'checkColor',
        type: 'Color?',
        description: 'Optional completed-check override.',
      ),
      DocParam(
        name: 'lineColor',
        type: 'Color?',
        description: 'Optional connecting line override.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'What status should the current step use?',
        answer:
            'Use StepStatus.inProgress for the active step and pending for future steps.',
      ),
      DocFaq(
        question: 'Can steps include custom icons?',
        answer: 'Yes. Build each CKStep with the icon parameter.',
      ),
    ],
    notes: [
      'Enum demo coverage: all StepStatus values and both CKStepperOrientation values are rendered.',
    ],
  );
}

ComponentDocData _timelineDoc() {
  const code = '''
CKTimeline(
  orientation: CKTimelineOrientation.vertical,
  events: const [
    CKTimelineEvent(title: 'Created', timestamp: '09:00', status: StepStatus.completed),
    CKTimelineEvent(title: 'Reviewed', timestamp: '10:30', status: StepStatus.inProgress),
    CKTimelineEvent(title: 'Published', timestamp: '11:45', status: StepStatus.pending),
  ],
)
''';
  return const ComponentDocData(
    title: 'CKTimeline',
    summary:
        'Chronological event display. The demo covers both orientations with timestamped events.',
    demo: _TimelineDemo(),
    code: code,
    params: [
      DocParam(
        name: 'events',
        type: 'List<CKTimelineEvent>',
        description: 'Ordered timeline entries.',
      ),
      DocParam(
        name: 'orientation',
        type: 'CKTimelineOrientation',
        description: 'Vertical or horizontal layout.',
      ),
      DocParam(
        name: 'lineColor',
        type: 'Color?',
        description: 'Optional custom connector color.',
      ),
      DocParam(
        name: 'dotColor',
        type: 'Color?',
        description: 'Optional default event dot color.',
      ),
    ],
    faqs: [
      DocFaq(
        question: 'When should I use horizontal orientation?',
        answer:
            'Use it for compact milestone overviews where there are only a few events.',
      ),
      DocFaq(
        question: 'Can individual events change color?',
        answer: 'Yes. Each CKTimelineEvent accepts a dotColor override.',
      ),
    ],
    notes: [
      'Enum demo coverage: both CKTimelineOrientation values are rendered.',
    ],
  );
}

class _AccordionDemo extends StatelessWidget {
  const _AccordionDemo();

  @override
  Widget build(BuildContext context) {
    return const CKAccordion(
      initiallyExpanded: 0,
      items: [
        CKAccordionItem(
          title: 'Billing',
          content: Text('Invoices, payment methods, and statements.'),
        ),
        CKAccordionItem(
          title: 'Security',
          content: Text('Passwords, sessions, and access control.'),
        ),
      ],
    );
  }
}

class _AvatarDemo extends StatelessWidget {
  const _AvatarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final size in AvatarSize.values)
              CKAvatar(
                initials: size.name.substring(0, 1).toUpperCase(),
                size: size,
                status: AvatarStatus.online,
              ),
          ],
        ),
        const VSpace(height: 16),
        Wrap(
          spacing: 12,
          children: [
            for (final status in AvatarStatus.values)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CKAvatar(initials: 'CK', status: status),
                  const VSpace(height: 6),
                  Text(status.name),
                ],
              ),
          ],
        ),
        const VSpace(height: 16),
        const CKAvatarGroup(
          avatars: [
            CKAvatar(initials: 'AL'),
            CKAvatar(initials: 'BR'),
            CKAvatar(initials: 'CK'),
            CKAvatar(initials: 'DK'),
            CKAvatar(initials: 'EZ'),
          ],
        ),
      ],
    );
  }
}

class _BadgeDemo extends StatelessWidget {
  const _BadgeDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final variant in BadgeVariant.values)
          badgeForVariant(variant, variant.name),
      ],
    );
  }
}

class _CardDemo extends StatelessWidget {
  const _CardDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final variant in CardVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: cardForVariant(
              variant,
              title: variant.name,
              subtitle: 'Status card',
              description: 'This card documents the ${variant.name} style.',
              action: CKButton(onPressed: () {}, child: const Text('Open')),
            ),
          ),
        const CKCard(
          title: 'Horizontal layout',
          subtitle: 'CardLayout.horizontal',
          description: 'Useful when media and text should sit side by side.',
          layout: CardLayout.horizontal,
          media: ColoredBox(color: Colors.blueGrey),
        ),
      ],
    );
  }
}

class _ChipDemo extends StatelessWidget {
  const _ChipDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final state in ChipState.values)
              CKFilterChip(
                label: state.name,
                state: state,
                selected: state == ChipState.selected,
                onTap: () {},
              ),
          ],
        ),
        const VSpace(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final state in ChipState.values)
              CKInputChip(
                label: state.name,
                state: state,
                leading: const Icon(Icons.tag, size: 16),
                onRemove: () {},
              ),
          ],
        ),
      ],
    );
  }
}

class _ContainerDemo extends StatelessWidget {
  const _ContainerDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final variant in ContainerVariant.values)
          Container(
            width: 220,
            child: containerForVariant(
              variant,
              elevated: variant == ContainerVariant.surface,
              padding: const EdgeInsets.all(16),
              child: Text('variant: ${variant.name}'),
            ),
          ),
      ],
    );
  }
}

class _DividerDemo extends StatelessWidget {
  const _DividerDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Above'),
        const VSpace(height: 8),
        const CKDivider(),
        const VSpace(height: 8),
        const Text('Below'),
        const VSpace(height: 16),
        Container(
          height: 40,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Left'),
              HSpace(width: 12),
              CKDivider(direction: Axis.vertical),
              HSpace(width: 12),
              Text('Right'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListTileDemo extends StatelessWidget {
  const _ListTileDemo();

  @override
  Widget build(BuildContext context) {
    return CKContainer(
      child: Column(
        children: [
          CKListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            subtitle: const Text('Manage your account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const CKDivider(),
          CKListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _StepperDemo extends StatelessWidget {
  const _StepperDemo();

  @override
  Widget build(BuildContext context) {
    const steps = [
      CKStep(title: 'Requested', status: StepStatus.completed),
      CKStep(title: 'Approved', status: StepStatus.inProgress),
      CKStep(title: 'Finished', status: StepStatus.pending),
    ];
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CKStepper(steps: steps),
        VSpace(height: 24),
        CKStepper(
          steps: steps,
          orientation: CKStepperOrientation.horizontal,
        ),
      ],
    );
  }
}

class _TimelineDemo extends StatelessWidget {
  const _TimelineDemo();

  @override
  Widget build(BuildContext context) {
    const events = [
      CKTimelineEvent(
        title: 'Created',
        timestamp: '09:00',
        status: StepStatus.completed,
      ),
      CKTimelineEvent(
        title: 'Reviewed',
        timestamp: '10:30',
        status: StepStatus.inProgress,
      ),
      CKTimelineEvent(
        title: 'Published',
        timestamp: '11:45',
        status: StepStatus.pending,
      ),
    ];
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CKTimeline(events: events),
        VSpace(height: 24),
        CKTimeline(
          events: events,
          orientation: CKTimelineOrientation.horizontal,
        ),
      ],
    );
  }
}
