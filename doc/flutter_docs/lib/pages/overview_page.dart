import 'package:flutter/material.dart';
import 'package:ckcoreui/ckcore_core.dart';

import 'package:ckcore_docs_app/docs/doc_widgets.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'ckcoreui Core Documentation',
      subtitle:
          'Flutter docs app generated for every public component area under lib/src/components, plus enums and brand icon usage. Each page includes a live demo, copy-pasteable code, parameter explanations, and FAQs.',
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Coverage'),
                VSpace(height: 12),
                Text('• Buttons: CKButton, CKIconButton, CKFab'),
                Text(
                  '• Display: Accordion, Avatar, AvatarGroup, Badge, Card, Filter/Input chips, Container, Divider, ListTile, Stepper, Timeline',
                ),
                Text(
                  '• Inputs: TextField, PasswordField, SearchField, Dropdown, NumberStepper, Checkbox, Radio, Switch, OTP, DatePicker, TimePicker',
                ),
                Text(
                  '• Feedback: Alert, Loader, ProgressBar, Slider, Snackbar, Toast, Skeleton, EmptyState, LoadingState, ErrorState',
                ),
                Text(
                  '• Navigation: AppBar, Tabs, BottomNavigation, Breadcrumb, Drawer, NavigationRail, SideNav',
                ),
                Text('• Overlays: Dialog, BottomSheet, Menu, Popover, Tooltip'),
                Text(
                  '• Data table: CKDataTable, CKTableColumn, selection and width enums',
                ),
                Text(
                  '• Screen layout: CKScreenLayout with responsive CKSideNav',
                ),
                Text(
                  '• Themes and assets: ckcoreBrand, BrandIcon, BrandIconVariant, all packaged logo assets',
                ),
                Text(
                  '• App wrapper: ckcoreApp with CKApp.router for Navigator 2.0',
                ),
                Text(
                  '• Foundation tokens: colors, typography, spacing, radius, elevation, shadows, motion, opacity, breakpoints',
                ),
                Text(
                  '• Text extensions: semantic heading shortcuts (.h1–.h6), typography styles, color modifiers, text transforms',
                ),
                Text(
                  '• Templates: auth, CRUD, dashboard, loading/error/empty/offline exports',
                ),
              ],
            ),
          ),
        ),
        VSpace(height: 24),
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Getting Started with CKApp').h3,
                VSpace(height: 12),
                Text(
                  'CKApp automatically wraps your app with theme context. Any descendant widget can access the design system via context.ckcoreTheme.',
                  style: context.ckcoreTheme.typography.textMd,
                ),
                VSpace(height: 12),
                SelectableText(
                  '''CKApp(
  brand: ckcoreBrand.castleKeep,
  home: MyHomePage(),
)

// Now use theme anywhere in the tree:
Text('Hello').h1.primary // Heading with primary color
''',
                  style: context.ckcoreTheme.typography.codeMd,
                ),
                VSpace(height: 12),
                Text(
                  'For Navigator 2.0 routing, use CKApp.router with a RouterConfig. Theme context is automatically available to all routes.',
                  style: context.ckcoreTheme.typography.textSm.copyWith(
                    fontStyle: FontStyle.italic,
                    color: context.ckcoreTheme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        VSpace(height: 24),
        Text('Text Extensions').blockQuote,
        VSpace(height: 12),
        const Text(
          'Use extension methods for cleaner, more readable text styling throughout your app.',
        ),
      ],
    );
  }
}
