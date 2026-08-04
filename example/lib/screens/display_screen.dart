import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final Set<String> _selectedFilters = {'All'};
  final List<String> _inputChips = [
    'React',
    'Flutter',
    'Figma',
    'Design',
    'Mobile',
    'Material Filter Chip',
  ];

  void _toggleFilter(String label) {
    setState(() {
      if (_selectedFilters.contains(label)) {
        _selectedFilters.remove(label);
      } else {
        _selectedFilters.add(label);
      }
    });
  }

  void _removeChip(String label) {
    setState(() => _inputChips.remove(label));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('MATERIAL AVATAR', theme),
          SizedBox(height: s.sm),
          CircleAvatar(
            backgroundColor: theme.colors.primary,
            child: Text(
              'JD',
              style: theme.typography.displaySm.copyWith(
                color: theme.colors.onPrimary,
              ),
            ),
          ),
          _label('AVATAR — SIZES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              CKAvatar(initials: 'JD', size: AvatarSize.xs),
              CKAvatar(initials: 'MS', size: AvatarSize.sm),
              CKAvatar(initials: 'AB', size: AvatarSize.md),
              CKAvatar(initials: 'RK', size: AvatarSize.lg),
              CKAvatar(initials: 'TL', size: AvatarSize.xl),
              CKAvatar(initials: 'PQ', size: AvatarSize.x2l),
              CKAvatar(initials: 'WX', size: AvatarSize.x3l),
            ],
          ),
          SizedBox(height: s.lg),
          _label('AVATAR — WITH STATUS', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              CKAvatar(
                initials: 'JD',
                size: AvatarSize.lg,
                status: AvatarStatus.online,
              ),
              CKAvatar(
                initials: 'MS',
                size: AvatarSize.lg,
                status: AvatarStatus.away,
              ),
              CKAvatar(
                initials: 'AB',
                size: AvatarSize.lg,
                status: AvatarStatus.busy,
              ),
              CKAvatar(
                initials: 'RK',
                size: AvatarSize.lg,
                status: AvatarStatus.offline,
              ),
            ],
          ),
          SizedBox(height: s.lg),
          _label('AVATAR — SQUARE', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              CKAvatar(initials: 'JD', size: AvatarSize.sm, square: true),
              CKAvatar(initials: 'MS', size: AvatarSize.md, square: true),
              CKAvatar(initials: 'AB', size: AvatarSize.lg, square: true),
              CKAvatar(initials: 'RK', size: AvatarSize.xl, square: true),
              CKAvatar(initials: 'TL', size: AvatarSize.x2l, square: true),
            ],
          ),
          SizedBox(height: s.lg),
          _label('AVATAR — GROUP', theme),
          SizedBox(height: s.sm),
          CKAvatarGroup(
            size: AvatarSize.md,
            maxVisible: 4,
            avatars: const [
              CKAvatar(initials: 'JD'),
              CKAvatar(initials: 'AB'),
              CKAvatar(initials: 'RK'),
              CKAvatar(initials: 'TL'),
              CKAvatar(initials: 'MS'),
              CKAvatar(initials: 'PQ'),
              CKAvatar(initials: 'WX'),
            ],
          ),
          SizedBox(height: s.xl),
          _label('FILLED BADGES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: const [
              Badge(label: Text('Material')),
              CKBadge(label: 'Default'),
              CKBadge.success(label: 'Success'),
              CKBadge.warning(label: 'Warning'),
              CKBadge.error(label: 'Error'),
              CKBadge.info(label: 'Info'),
              CKBadge.newBadge(label: 'NEW'),
              CKBadge.live(label: 'LIVE'),
              CKBadge.beta(label: 'Beta'),
              CKBadge.pro(label: 'PRO'),
              CKBadge.count(count: 5),
              CKBadge.count(count: 120),
            ],
          ),
          SizedBox(height: s.lg),
          _label('STATUS & OUTLINE BADGES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: const [
              CKBadge.online(label: 'Online'),
              CKBadge.away(label: 'Away'),
              CKBadge.busy(label: 'Busy'),
              CKBadge.offline(label: 'Offline'),
              CKBadge.outline(label: 'Outline'),
              CKBadge.outlineSuccess(label: 'Success'),
              CKBadge.outlineError(label: 'Error'),
            ],
          ),
          SizedBox(height: s.xl),
          _label('FILTER CHIPS', theme),
          SizedBox(height: s.sm),
          FilterChip(
            label: Text('Material Filter Chip'),
            selected: false,
            onSelected: (bool selected) =>
                _toggleFilter('Material Filter Chip'),
          ),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: ['All', 'Travel', 'Hotels', 'Food', 'Shopping', 'Tech']
                .map(
                  (label) => CKFilterChip(
                    label: label,
                    selected: _selectedFilters.contains(label),
                    onTap: () => _toggleFilter(label),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: s.lg),
          _label('INPUT CHIPS', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: _inputChips
                .map(
                  (label) => CKInputChip(
                    key: ValueKey(label),
                    label: label,
                    onRemove: () => _removeChip(label),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: s.lg),
          _label('CHIP STATES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: const [
              CKFilterChip(label: 'Default'),
              CKFilterChip(label: 'Selected', selected: true),
              CKFilterChip(label: 'Disabled', state: ChipState.disabled),
              CKFilterChip(label: 'Error', state: ChipState.error),
            ],
          ),

          SizedBox(height: s.xl),

          //  Cards
          _label('CARDS — VERTICAL', theme),
          SizedBox(height: s.sm),
          Card(
            child: Padding(
              padding: EdgeInsets.all(s.sm),
              child: Text('Material Card'),
            ),
          ),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            children: [
              SizedBox(
                width: 220,
                child: CKCard(
                  title: 'Card Title',
                  subtitle: 'Subtitle · Category · Date',
                  description:
                      'Short description of the card content goes here.',
                  action: CKButton(
                    onPressed: () {},
                    size: ButtonSize.sm,
                    child: const Text('View'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CKCard(
                  title: 'With Media',
                  subtitle: 'Category',
                  description: 'Card with a media block at the top.',
                  media: Container(
                    height: 120,
                    color: theme.colors.surfaceVariant,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  action: CKButton(
                    onPressed: () {},
                    size: ButtonSize.sm,
                    child: const Text('View'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CKCard(
                  media: BrandIcon.assetLogoWidget(
                    context,
                    BrandIcon.castlekeepMaster,
                    size: 80,
                  ),
                  mediaAlignment: ContentAlignment.center,
                  trailing: Icon(Icons.more_vert),
                  trailingAlignment: ContentAlignment.bottom,
                  title: 'Tappable Card',
                  subtitle: 'Interactive',
                  description: 'Tap anywhere on this card.',
                  onTap: () {},
                ),
              ),
            ],
          ),

          SizedBox(height: s.xl),

          _label('CARDS — HORIZONTAL', theme),
          SizedBox(height: s.sm),
          SizedBox(
            width: 360,
            child: CKCard(
              elevated: true,
              layout: CardLayout.horizontal,
              title: 'Product Name',
              subtitle: 'Category  ★★★★☆',
              description: 'media alignment: top, trailing alignment: center',
              media: BrandIcon.assetLogoWidget(
                context,
                BrandIcon.skygoLogo1,
                size: 80,
              ),
              mediaAlignment: ContentAlignment.top,
              action: CKButton(
                onPressed: () {},
                size: ButtonSize.sm,
                child: const Text('+ Add'),
              ),
            ),
          ),

          SizedBox(height: s.xl),

          _label('CARDS — TINTED', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            children: [
              SizedBox(
                width: 220,
                child: CKCard(
                  variant: CardVariant.success,
                  title: 'Success',
                  description: 'Contextual card message here.',
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Action →'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CKCard(
                  variant: CardVariant.warning,
                  title: 'Warning',
                  description: 'Contextual card message here.',
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Action →'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CKCard(
                  variant: CardVariant.error,
                  title: 'Error',
                  description: 'Contextual card message here.',
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Action →'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CKCard(
                  variant: CardVariant.info,
                  title: 'Info',
                  description: 'Contextual card message here.',
                  action: TextButton(
                    onPressed: () {},
                    child: const Text('Action →'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('ACCORDION', theme),
          SizedBox(height: s.sm),
          CKAccordion(
            initiallyExpanded: 0,
            items: const [
              CKAccordionItem(
                title: 'What is Flutter?',
                content: Text(
                  'Google\'s UI toolkit for natively compiled apps from a single codebase.',
                ),
              ),
              CKAccordionItem(
                title: 'What is shadcn_flutter?',
                content: Text(
                  'A Flutter port of the shadcn/ui component library.',
                ),
              ),
              CKAccordionItem(
                title: 'Brand theming support?',
                content: Text(
                  'Yes — ckcoreTheme resolves colors, typography, and spacing per brand.',
                ),
              ),
              CKAccordionItem(
                title: 'Accessibility?',
                content: Text(
                  'All components use semantic labels and respect system text scale.',
                ),
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('STEPPER — VERTICAL', theme),
          SizedBox(height: s.sm),
          const CKStepper(
            steps: [
              CKStep(title: 'Personal Info', status: StepStatus.completed),
              CKStep(title: 'Contact', status: StepStatus.completed),
              CKStep(title: 'Payment', status: StepStatus.inProgress),
              CKStep(title: 'Review', status: StepStatus.pending),
            ],
          ),
          SizedBox(height: s.xl),
          _label('STEPPER overriden ', theme),
          SizedBox(height: s.sm),
          const CKStepper(
            lineColor:
                Colors.green, //only overrides the color that is still pending
            steps: [
              CKStep(
                title: 'Custom Color',
                status: StepStatus.completed,
                icon: Icon(
                  Icons.heart_broken,
                  color: Colors.white,
                ), //overrides the icon of the completed step
                color: Colors.pink, //overrides the color of the completed step
              ),
              CKStep(title: 'Contact', status: StepStatus.completed),
              CKStep(title: 'Payment', status: StepStatus.inProgress),
              CKStep(title: 'Review', status: StepStatus.pending),
            ],
          ),
          SizedBox(height: s.xl),
          _label('STEPPER — HORIZONTAL', theme),
          SizedBox(height: s.sm),
          const CKStepper(
            orientation: CKStepperOrientation.horizontal,
            steps: [
              CKStep(title: 'Personal Info', status: StepStatus.completed),
              CKStep(title: 'Contact', status: StepStatus.completed),
              CKStep(title: 'Payment', status: StepStatus.inProgress),
              CKStep(title: 'Review', status: StepStatus.pending),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TIMELINE — VERTICAL', theme),
          SizedBox(height: s.sm),
          const CKTimeline(
            events: [
              CKTimelineEvent(
                title: 'Order Shipped',
                timestamp: 'Apr 7 · 2 Nov',
                status: StepStatus.completed,
              ),
              CKTimelineEvent(
                title: 'Payment OK',
                timestamp: 'Apr 6 · 2:30 PM',
                status: StepStatus.inProgress,
              ),
              CKTimelineEvent(
                title: 'Order Placed',
                timestamp: 'Apr 5 · 10:00 AM',
                status: StepStatus.pending,
              ),
              CKTimelineEvent(
                title: 'Delivery',
                timestamp: 'Apr 9 (est)',
                status: StepStatus.pending,
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TIMELINE — Overriden', theme),
          SizedBox(height: s.sm),
          const CKTimeline(
            orientation: CKTimelineOrientation.horizontal,
            dotColor: Colors.purple,
            lineColor: Colors.yellow,
            events: [
              CKTimelineEvent(
                title: 'Order Shipped',
                timestamp: 'Apr 7 · 2 Nov',
                status: StepStatus.completed,
                dotColor:
                    Colors.purple, //overrides the color of the completed step
                icon: Icon(
                  Icons.local_shipping,
                  color: Colors.red,
                ), //overrides the icon of the completed step
              ),
              CKTimelineEvent(
                title: 'Payment OK',
                timestamp: 'Apr 6 · 2:30 PM',
                status: StepStatus.inProgress,
                dotColor:
                    Colors.red, //overrides the color of the inProgress step
                icon: Icon(
                  LucideIcons.dollarSign,
                  color: Colors.green,
                ), //overrides the icon of the inProgress step
              ),
              CKTimelineEvent(
                title: 'Order Placed',
                timestamp: 'Apr 5 · 10:00 AM',
                status: StepStatus.pending,
              ),
              CKTimelineEvent(
                title: 'Delivery',
                timestamp: 'Apr 9 (est)',
                status: StepStatus.pending,
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TIMELINE — HORIZONTAL', theme),
          SizedBox(height: s.sm),
          const CKTimeline(
            orientation: CKTimelineOrientation.horizontal,
            events: [
              CKTimelineEvent(
                title: 'Order Placed',
                timestamp: 'Apr 5',
                status: StepStatus.completed,
              ),
              CKTimelineEvent(
                title: 'Payment OK',
                timestamp: 'Apr 6',
                status: StepStatus.rejected,
              ),
              CKTimelineEvent(
                title: 'Shipped',
                timestamp: 'Apr 7',
                status: StepStatus.pending,
              ),
              CKTimelineEvent(
                title: 'Delivery',
                timestamp: 'Apr 9',
                status: StepStatus.pending,
              ),
            ],
          ),
          SizedBox(height: s.xl),
          _label('CONTAINER — SURFACE', theme),
          SizedBox(height: s.sm),
          CKContainer(
            child: Text(
              'Surface container with default padding.',
              style: theme.typography.textSm.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
          SizedBox(height: s.md),
          _label('CONTAINER — MUTED', theme),
          SizedBox(height: s.sm),
          CKContainer(
            variant: ContainerVariant.muted,
            child: Text(
              'Muted container using surfaceVariant background.',
              style: theme.typography.textSm.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: s.md),
          _label('CONTAINER — OUTLINED', theme),
          SizedBox(height: s.sm),
          CKContainer(
            variant: ContainerVariant.outlined,
            child: Text(
              'Outlined container with 1dp outline border.',
              style: theme.typography.textSm.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
          SizedBox(height: s.md),
          _label('CONTAINER — ELEVATED', theme),
          SizedBox(height: s.sm),
          CKContainer(
            elevated: true,
            child: Text(
              'Elevated container with shadow.',
              style: theme.typography.textSm.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text, ckcoreThemeData theme) => Text(
    text,
    style: theme.typography.labelSm.copyWith(
      color: theme.colors.onSurfaceVariant,
    ),
  );
}
