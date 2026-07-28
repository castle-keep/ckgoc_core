import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

/// Demo page showing CKScreenLayout with responsive behavior.
class ScreenLayoutDemoPage extends StatefulWidget {
  const ScreenLayoutDemoPage({super.key});

  @override
  State<ScreenLayoutDemoPage> createState() => _ScreenLayoutDemoPageState();
}

class _ScreenLayoutDemoPageState extends State<ScreenLayoutDemoPage> {
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

    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return CKScreenLayout(
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
    );
  }
}
