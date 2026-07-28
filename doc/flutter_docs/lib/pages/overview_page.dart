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
                  '• Themes and assets: ckcoreBrand, BrandIcon, BrandIconVariant, all packaged logo assets',
                ),
                Text('• App wrapper: ckcoreApp'),
                Text(
                  '• Foundation tokens: colors, typography, spacing, radius, elevation, shadows, motion, opacity, breakpoints',
                ),
                Text(
                  '• Templates: auth, CRUD, dashboard, loading/error/empty/offline exports',
                ),
                Text(
                  '• Empty folders confirmed: extensions/ and utils/ currently have no files to document',
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
