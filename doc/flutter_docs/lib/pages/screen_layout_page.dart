import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

/// Documentation page for screen layout components.
class ScreenLayoutPage extends StatelessWidget {
  const ScreenLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Screen Layout',
      subtitle: 'Responsive layout components: CKScreenLayout with CKSideNav.',
      children: [
        DocSection(data: _screenLayoutDoc()),
        DocSection(data: _sideNavDoc()),
      ],
    );
  }
}

ComponentDocData _screenLayoutDoc() => const ComponentDocData(
      title: 'CKScreenLayout',
      summary:
          'Responsive layout container that adapts side navigation between persistent (desktop) and drawer (tablet/mobile) modes based on breakpoints.',
      demo: _ScreenLayoutDemo(),
      code: '''
CKScreenLayout(
  body: Center(child: Text('Content')),
  sections: [
    CKSideNavSection(
      label: 'Main',
      items: [
        CKSideNavItem(icon: LucideIcons.home, label: 'Dashboard'),
        CKSideNavItem(icon: LucideIcons.settings, label: 'Settings'),
      ],
    ),
  ],
  selectedIndex: 0,
  onItemSelected: (index) {},
  brandName: 'My App',
  allowSideNavCollapse: true,
)
''',
      params: [
        DocParam(
          name: 'body',
          type: 'Widget',
          description: 'Main content area.',
          requiredParam: true,
          ),
        DocParam(
          name: 'sections',
          type: 'List<CKSideNavSection>',
          description: 'Navigation sections.',
          requiredParam: true,
          ),
        DocParam(
          name: 'selectedIndex',
          type: 'int',
          description: 'Currently selected navigation item index.',
          requiredParam: true,
          ),
        DocParam(
          name: 'onItemSelected',
          type: 'Function(int)?',
          description: 'Callback when nav item is tapped.',
          requiredParam: true,
          ),
        DocParam(
          name: 'brandName',
          type: 'String?',
          description: 'Brand/app name shown in side nav header.',
        ),
        DocParam(
          name: 'version',
          type: 'String?',
          description: 'Version string shown below brand name.',
        ),
        DocParam(
          name: 'sideNavStyle',
          type: 'SideNavStyle',
          description: 'Visual style: brand or neutral.',
          defaultValue: 'SideNavStyle.surface',
          ),
        DocParam(
          name: 'allowSideNavCollapse',
          type: 'bool',
          description: 'Allow collapsing side nav on desktop.',
          defaultValue: 'true',
          ),
      ],
      faqs: [
        DocFaq(
          question: 'How does CKScreenLayout adapt to screen size?',
          answer:
              'On desktop (≥ 840px), side nav is persistent. On tablet/mobile (< 840px), it becomes a drawer triggered by a hamburger menu.',
        ),
        DocFaq(
          question: 'Can I collapse the side nav?',
          answer:
              'Yes, set allowSideNavCollapse: true. Users can toggle collapse with the collapse button.',
        ),
        DocFaq(
          question: 'How do I customize the side nav appearance?',
          answer:
              'Use sideNavStyle (brand or neutral) and style items via CKSideNavItem properties (icon, label, badge, etc.).',
        ),
      ],
      notes: [
        'Responsive breakpoint is 840px (configurable via CKApp theme).',
        'Side nav persists drawer state across navigation.',
        'All items in sections must have unique indices for proper selection.',
      ],
    );

ComponentDocData _sideNavDoc() => const ComponentDocData(
      title: 'CKSideNav & CKSideNavItem',
      summary:
          'Navigation sidebar component with section support, badges, icons, and responsive drawer behavior on mobile.',
      demo: _SideNavItemsDemo(),
      code: '''
CKSideNavSection(
  label: 'Main Navigation',
  items: [
    CKSideNavItem(
      icon: LucideIcons.home,
      label: 'Dashboard',
      badge: 3,
    ),
    CKSideNavItem(
      icon: LucideIcons.users,
      label: 'Users',
      selected: true,
    ),
  ],
)
''',
      params: [
        DocParam(
          name: 'label',
          type: 'String',
          description: 'Section title/label.',
        ),
        DocParam(
          name: 'items',
          type: 'List<CKSideNavItem>',
          description: 'Navigation items in this section.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How do I add badges to navigation items?',
          answer:
              'Pass an integer badge value to CKSideNavItem. Badges typically indicate counts or notifications.',
        ),
        DocFaq(
          question: 'Can I use custom icons?',
          answer:
              'Yes, pass any IconData to CKSideNavItem.icon. LucideIcons is recommended for consistency.',
        ),
      ],
      notes: [
        'CKSideNavItem properties: icon (IconData), label (String), badge (int?), selected (bool)',
        'Icons use LucideIcons by default.',
        'Badges display notification counts.',
        'Items are rendered with consistent spacing and hover effects.',
      ],
    );

class _ScreenLayoutDemo extends StatefulWidget {
  const _ScreenLayoutDemo();

  @override
  State<_ScreenLayoutDemo> createState() => _ScreenLayoutDemoState();
}

class _ScreenLayoutDemoState extends State<_ScreenLayoutDemo> {
  int _selectedIndex = 0;

  final List<CKSideNavSection> _sections = [
    CKSideNavSection(
      label: 'Main',
      items: [
        CKSideNavItem(
          icon: LucideIcons.home,
          label: 'Dashboard',
        ),
        CKSideNavItem(
          icon: LucideIcons.users,
          label: 'Users',
          badge: 5,
        ),
        CKSideNavItem(
          icon: LucideIcons.fileText,
          label: 'Documents',
        ),
        CKSideNavItem(
          icon: LucideIcons.settings,
          label: 'Settings',
        ),
      ],
    ),
    CKSideNavSection(
      label: 'Content',
      items: [
        CKSideNavItem(
          icon: LucideIcons.image,
          label: 'Media',
        ),
        CKSideNavItem(
          icon: LucideIcons.package,
          label: 'Products',
          badge: 12,
        ),
      ],
    ),
  ];

  Widget _buildBody(BuildContext context) {
    final theme = context.ckcoreTheme;
    final titles = [
      'Dashboard',
      'Users',
      'Documents',
      'Settings',
      'Media',
      'Products',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[_selectedIndex],
                    style: theme.typography.displaySm,
                  ),
                  SizedBox(height: theme.spacing.md),
                  Text(
                    'Content for ${titles[_selectedIndex]}',
                    style: theme.typography.textLg.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: theme.spacing.xl),
                  CKCard(
                    title: 'Responsive Layout',
                    subtitle: 'CKScreenLayout automatically adapts',
                    description:
                        'On desktop (≥ 840px), the side nav is persistent with optional collapse. '
                        'On tablet/mobile (< 840px), a hamburger menu shows the nav as an overlay drawer. '
                        'Try resizing the window to see the responsive behavior.',
                    elevated: true,
                  ),
                  SizedBox(height: theme.spacing.md),
                  Wrap(
                    spacing: theme.spacing.md,
                    runSpacing: theme.spacing.md,
                    children: [
                      CKCard(
                        title: 'Feature 1',
                        description: 'Example content card',
                        elevated: true,
                      ),
                      CKCard(
                        title: 'Feature 2',
                        description: 'Another example card',
                        elevated: true,
                      ),
                      CKCard(
                        title: 'Feature 3',
                        description: 'More example content',
                        elevated: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: CKScreenLayout(
        body: _buildBody(context),
        sections: _sections,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        brandName: 'ckcoreui Docs',
        version: '1.0.0',
        sideNavStyle: SideNavStyle.brand,
        allowSideNavCollapse: true,
      ),
    );
  }
}

class _SideNavItemsDemo extends StatelessWidget {
  const _SideNavItemsDemo();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return CKContainer(
      elevated: true,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Side Navigation Section', style: theme.typography.labelXl),
            const VSpace(height: 12),
            Text('Main Navigation', style: theme.typography.labelMd),
            const VSpace(height: 8),
            Text('• Dashboard', style: theme.typography.textMd),
            Text('• Users (5)', style: theme.typography.textMd),
            Text('• Documents', style: theme.typography.textMd),
            Text('• Settings', style: theme.typography.textMd),
            const VSpace(height: 16),
            Text('Content', style: theme.typography.labelMd),
            const VSpace(height: 8),
            Text('• Media', style: theme.typography.textMd),
            Text('• Products (12)', style: theme.typography.textMd),
          ],
        ),
      ),
    );
  }
}
