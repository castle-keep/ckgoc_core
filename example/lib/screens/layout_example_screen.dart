import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

/// Example screen demonstrating CKScreenLayout usage.
///
/// This layout automatically handles:
/// - Desktop (>= 840px): Persistent side nav with optional collapse
/// - Tablet/Mobile (< 840px): Hamburger menu with overlay drawer
class LayoutExampleScreen extends StatefulWidget {
  const LayoutExampleScreen({super.key});

  @override
  State<LayoutExampleScreen> createState() => _LayoutExampleScreenState();
}

class _LayoutExampleScreenState extends State<LayoutExampleScreen> {
  int _selectedIndex = 0;

  // Define your navigation sections
  final List<CKSideNavSection> _sections = [
    CKSideNavSection(
      label: 'Main',
      items: [
        CKSideNavItem(icon: LucideIcons.home, label: 'Dashboard'),
        CKSideNavItem(icon: LucideIcons.users, label: 'Users', badge: 5),
        CKSideNavItem(icon: LucideIcons.settings, label: 'Settings'),
      ],
    ),
    CKSideNavSection(
      label: 'Content',
      items: [
        CKSideNavItem(icon: LucideIcons.fileText, label: 'Documents'),
        CKSideNavItem(icon: LucideIcons.image, label: 'Media'),
      ],
    ),
  ];

  // Content for each nav item
  Widget _buildBody() {
    final titles = ['Dashboard', 'Users', 'Settings', 'Documents', 'Media'];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titles[_selectedIndex],
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Content for ${titles[_selectedIndex]} goes here.'),
          const SizedBox(height: 24),
          const CKCard(
            title: 'Example Card',
            subtitle: 'This is the main content area',
            description:
                'The layout automatically adapts to screen size. '
                'Try resizing the window to see the responsive behavior.',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CKScreenLayout(
      // Required: main content widget
      body: _buildBody(),

      // Required: navigation sections
      sections: _sections,

      // Required: currently selected nav item index
      selectedIndex: _selectedIndex,

      // Required: callback when nav item is tapped
      onItemSelected: (index) {
        setState(() => _selectedIndex = index);
      },

      // Optional: brand name in header
      brandName: 'My App',

      // Optional: version string in footer
      version: '1.0.0',

      // Optional: side nav style (surface or brand)
      sideNavStyle: SideNavStyle.surface,

      // Optional: allow collapsing on desktop
      allowSideNavCollapse: true,

      profileName: 'John Doe',
      profilePosition: 'Professional Procasinator',
      profileAuthProvider: 'PeopleCore',
      onLogout: () {},
    );
  }
}
