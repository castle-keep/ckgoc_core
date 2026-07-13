import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

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
    final theme = context.ckgocTheme;
    final s = theme.spacing;

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('AVATAR — SIZES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              CkgocAvatar(initials: 'JD', size: AvatarSize.xs),
              CkgocAvatar(initials: 'MS', size: AvatarSize.sm),
              CkgocAvatar(initials: 'AB', size: AvatarSize.md),
              CkgocAvatar(initials: 'RK', size: AvatarSize.lg),
              CkgocAvatar(initials: 'TL', size: AvatarSize.xl),
              CkgocAvatar(initials: 'PQ', size: AvatarSize.x2l),
              CkgocAvatar(initials: 'WX', size: AvatarSize.x3l),
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
              CkgocAvatar(
                initials: 'JD',
                size: AvatarSize.lg,
                status: AvatarStatus.online,
              ),
              CkgocAvatar(
                initials: 'MS',
                size: AvatarSize.lg,
                status: AvatarStatus.away,
              ),
              CkgocAvatar(
                initials: 'AB',
                size: AvatarSize.lg,
                status: AvatarStatus.busy,
              ),
              CkgocAvatar(
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
              CkgocAvatar(initials: 'JD', size: AvatarSize.sm, square: true),
              CkgocAvatar(initials: 'MS', size: AvatarSize.md, square: true),
              CkgocAvatar(initials: 'AB', size: AvatarSize.lg, square: true),
              CkgocAvatar(initials: 'RK', size: AvatarSize.xl, square: true),
              CkgocAvatar(initials: 'TL', size: AvatarSize.x2l, square: true),
            ],
          ),
          SizedBox(height: s.lg),
          _label('AVATAR — GROUP', theme),
          SizedBox(height: s.sm),
          const CkgocAvatarGroup(
            size: AvatarSize.md,
            maxVisible: 4,
            avatars: [
              CkgocAvatar(initials: 'JD'),
              CkgocAvatar(initials: 'AB'),
              CkgocAvatar(initials: 'RK'),
              CkgocAvatar(initials: 'TL'),
              CkgocAvatar(initials: 'MS'),
              CkgocAvatar(initials: 'PQ'),
              CkgocAvatar(initials: 'WX'),
            ],
          ),
          SizedBox(height: s.xl),
          _label('FILLED BADGES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: const [
              CkgocBadge(label: 'Default', variant: BadgeVariant.defaultFill),
              CkgocBadge(label: 'Primary', variant: BadgeVariant.primary),
              CkgocBadge(label: 'Success', variant: BadgeVariant.success),
              CkgocBadge(label: 'Warning', variant: BadgeVariant.warning),
              CkgocBadge(label: 'Error', variant: BadgeVariant.error),
              CkgocBadge(label: 'Info', variant: BadgeVariant.info),
              CkgocBadge(label: 'NEW', variant: BadgeVariant.newBadge),
              CkgocBadge(label: 'LIVE', variant: BadgeVariant.live),
              CkgocBadge(label: 'Beta', variant: BadgeVariant.beta),
              CkgocBadge(label: 'PRO', variant: BadgeVariant.pro),
              CkgocBadge.count(count: 5),
              CkgocBadge.count(count: 120),
            ],
          ),
          SizedBox(height: s.lg),
          _label('STATUS & OUTLINE BADGES', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: const [
              CkgocBadge(label: 'Online', variant: BadgeVariant.online),
              CkgocBadge(label: 'Away', variant: BadgeVariant.away),
              CkgocBadge(label: 'Busy', variant: BadgeVariant.busy),
              CkgocBadge(label: 'Offline', variant: BadgeVariant.offline),
              CkgocBadge(label: 'Outline', variant: BadgeVariant.outline),
              CkgocBadge(
                label: 'Success',
                variant: BadgeVariant.outlineSuccess,
              ),
              CkgocBadge(label: 'Error', variant: BadgeVariant.outlineError),
            ],
          ),
          SizedBox(height: s.xl),
          _label('FILTER CHIPS', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: ['All', 'Travel', 'Hotels', 'Food', 'Shopping', 'Tech']
                .map(
                  (label) => CkgocFilterChip(
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
                  (label) => CkgocInputChip(
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
              CkgocFilterChip(label: 'Default'),
              CkgocFilterChip(label: 'Selected', selected: true),
              CkgocFilterChip(label: 'Disabled', state: ChipState.disabled),
              CkgocFilterChip(label: 'Error', state: ChipState.error),
            ],
          ),

          SizedBox(height: s.xl),

          // ── Cards ───────────────────────────────────────────────────────
          _label('CARDS — VERTICAL', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.md,
            runSpacing: s.md,
            children: [
              SizedBox(
                width: 220,
                child: CkgocCard(
                  title: 'Card Title',
                  subtitle: 'Subtitle · Category · Date',
                  description:
                      'Short description of the card content goes here.',
                  action: CkgocButton(
                    onPressed: () {},
                    size: ButtonSize.sm,
                    child: const Text('View'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CkgocCard(
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
                  action: CkgocButton(
                    onPressed: () {},
                    size: ButtonSize.sm,
                    child: const Text('View'),
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: CkgocCard(
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
            child: CkgocCard(
              layout: CardLayout.horizontal,
              title: 'Product Name',
              subtitle: 'Category  ★★★★☆',
              description: '₱1,299',
              media: Container(
                width: 90,
                height: 90,
                color: theme.colors.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 36,
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
              action: CkgocButton(
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
                child: CkgocCard(
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
                child: CkgocCard(
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
                child: CkgocCard(
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
                child: CkgocCard(
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
          const CkgocAccordion(
            initiallyExpanded: 0,
            items: [
              CkgocAccordionItem(
                title: 'What is Flutter?',
                content: Text(
                  'Google\'s UI toolkit for natively compiled apps from a single codebase.',
                ),
              ),
              CkgocAccordionItem(
                title: 'What is shadcn_flutter?',
                content: Text(
                  'A Flutter port of the shadcn/ui component library.',
                ),
              ),
              CkgocAccordionItem(
                title: 'Brand theming support?',
                content: Text(
                  'Yes — CkgocTheme resolves colors, typography, and spacing per brand.',
                ),
              ),
              CkgocAccordionItem(
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
          const CkgocStepper(
            steps: [
              CkgocStep(title: 'Personal Info', status: StepStatus.completed),
              CkgocStep(title: 'Contact', status: StepStatus.completed),
              CkgocStep(title: 'Payment', status: StepStatus.inProgress),
              CkgocStep(title: 'Review', status: StepStatus.pending),
            ],
          ),
          SizedBox(height: s.xl),
          _label('STEPPER — HORIZONTAL', theme),
          SizedBox(height: s.sm),
          const CkgocStepper(
            orientation: CkgocStepperOrientation.horizontal,
            steps: [
              CkgocStep(title: 'Personal Info', status: StepStatus.completed),
              CkgocStep(title: 'Contact', status: StepStatus.completed),
              CkgocStep(title: 'Payment', status: StepStatus.inProgress),
              CkgocStep(title: 'Review', status: StepStatus.pending),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TIMELINE — VERTICAL', theme),
          SizedBox(height: s.sm),
          const CkgocTimeline(
            events: [
              CkgocTimelineEvent(
                title: 'Order Shipped',
                timestamp: 'Apr 7 · 2 Nov',
              ),
              CkgocTimelineEvent(
                title: 'Payment OK',
                timestamp: 'Apr 6 · 2:30 PM',
              ),
              CkgocTimelineEvent(
                title: 'Order Placed',
                timestamp: 'Apr 5 · 10:00 AM',
              ),
              CkgocTimelineEvent(title: 'Delivery', timestamp: 'Apr 9 (est)'),
            ],
          ),
          SizedBox(height: s.xl),
          _label('TIMELINE — HORIZONTAL', theme),
          SizedBox(height: s.sm),
          const CkgocTimeline(
            orientation: CkgocTimelineOrientation.horizontal,
            events: [
              CkgocTimelineEvent(title: 'Order Placed', timestamp: 'Apr 5'),
              CkgocTimelineEvent(title: 'Payment OK', timestamp: 'Apr 6'),
              CkgocTimelineEvent(title: 'Shipped', timestamp: 'Apr 7'),
              CkgocTimelineEvent(title: 'Delivery', timestamp: 'Apr 9'),
            ],
          ),
          SizedBox(height: s.xl),
          _label('CONTAINER — SURFACE', theme),
          SizedBox(height: s.sm),
          CkgocContainer(
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
          CkgocContainer(
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
          CkgocContainer(
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
          CkgocContainer(
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

  Widget _label(String text, CkgocThemeData theme) => Text(
    text,
    style: theme.typography.labelSm.copyWith(
      color: theme.colors.onSurfaceVariant,
    ),
  );
}
