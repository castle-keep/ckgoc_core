import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class EnumsPage extends StatelessWidget {
  const EnumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'Enums Reference',
      subtitle:
          'Every enum exported through component APIs. Visual enums are demoed on their component pages; this page gives a complete case-by-case reference for all of them.',
      children: [
        EnumCasesCard(title: 'ButtonVariant', cases: _buttonVariants),
        EnumCasesCard(title: 'ButtonSize', cases: _buttonSizes),
        EnumCasesCard(title: 'BadgeVariant', cases: _badgeVariants),
        EnumCasesCard(title: 'ChipState', cases: _chipStates),
        EnumCasesCard(title: 'AvatarSize', cases: _avatarSizes),
        EnumCasesCard(title: 'AvatarStatus', cases: _avatarStatuses),
        EnumCasesCard(title: 'SwitchVariant', cases: _switchVariants),
        EnumCasesCard(title: 'ToastVariant', cases: _toastVariants),
        EnumCasesCard(title: 'ProgressVariant', cases: _progressVariants),
        EnumCasesCard(title: 'LoaderType', cases: _loaderTypes),
        EnumCasesCard(title: 'CardVariant', cases: _cardVariants),
        EnumCasesCard(title: 'CardLayout', cases: _cardLayouts),
        EnumCasesCard(title: 'ContainerVariant', cases: _containerVariants),
        EnumCasesCard(title: 'CkgocColumnType', cases: _columnTypes),
        EnumCasesCard(title: 'TableSelectionMode', cases: _selectionModes),
        EnumCasesCard(title: 'TableWidthBehavior', cases: _widthBehaviors),
        EnumCasesCard(title: 'AlertVariant', cases: _alertVariants),
        EnumCasesCard(title: 'StepStatus', cases: _stepStatuses),
        EnumCasesCard(
          title: 'CkgocStepperOrientation',
          cases: _stepperOrientations,
        ),
        EnumCasesCard(
          title: 'CkgocTimelineOrientation',
          cases: _timelineOrientations,
        ),
        EnumCasesCard(title: 'AppBarStyle', cases: _appBarStyles),
        EnumCasesCard(title: 'TabVariant', cases: _tabVariants),
        EnumCasesCard(title: 'SideNavStyle', cases: _sideNavStyles),
        EnumCasesCard(title: 'BrandIconVariant', cases: _brandIconVariants),
      ],
    );
  }
}

const _buttonVariants = [
  EnumCaseDoc(name: 'primary', description: 'Primary action emphasis.'),
  EnumCaseDoc(name: 'secondary', description: 'Secondary filled action.'),
  EnumCaseDoc(name: 'outline', description: 'Bordered emphasis without fill.'),
  EnumCaseDoc(name: 'ghost', description: 'Minimal text-first button.'),
  EnumCaseDoc(name: 'accent', description: 'Accent color emphasis.'),
  EnumCaseDoc(name: 'destructive', description: 'Dangerous action state.'),
  EnumCaseDoc(name: 'success', description: 'Success-toned action.'),
  EnumCaseDoc(name: 'warning', description: 'Warning-toned action.'),
  EnumCaseDoc(name: 'info', description: 'Info-toned action.'),
  EnumCaseDoc(name: 'link', description: 'Link-style textual action.'),
];

const _buttonSizes = [
  EnumCaseDoc(name: 'xs', description: 'Extra small height.'),
  EnumCaseDoc(name: 'sm', description: 'Small height.'),
  EnumCaseDoc(name: 'md', description: 'Default height.'),
  EnumCaseDoc(name: 'lg', description: 'Large height.'),
  EnumCaseDoc(name: 'xl', description: 'Extra large height.'),
];

const _badgeVariants = [
  EnumCaseDoc(name: 'defaultFill', description: 'Neutral filled badge.'),
  EnumCaseDoc(name: 'primary', description: 'Primary brand badge.'),
  EnumCaseDoc(name: 'success', description: 'Success badge.'),
  EnumCaseDoc(name: 'warning', description: 'Warning badge.'),
  EnumCaseDoc(name: 'error', description: 'Error badge.'),
  EnumCaseDoc(name: 'info', description: 'Info badge.'),
  EnumCaseDoc(name: 'live', description: 'Live-stream or realtime badge.'),
  EnumCaseDoc(name: 'newBadge', description: 'New item badge.'),
  EnumCaseDoc(name: 'beta', description: 'Beta feature badge.'),
  EnumCaseDoc(name: 'pro', description: 'Pro tier badge.'),
  EnumCaseDoc(name: 'outline', description: 'Outlined neutral badge.'),
  EnumCaseDoc(name: 'outlineSuccess', description: 'Outlined success badge.'),
  EnumCaseDoc(name: 'outlineError', description: 'Outlined error badge.'),
  EnumCaseDoc(name: 'online', description: 'Online presence badge.'),
  EnumCaseDoc(name: 'away', description: 'Away presence badge.'),
  EnumCaseDoc(name: 'busy', description: 'Busy presence badge.'),
  EnumCaseDoc(name: 'offline', description: 'Offline presence badge.'),
];

const _chipStates = [
  EnumCaseDoc(name: 'defaultState', description: 'Default chip styling.'),
  EnumCaseDoc(name: 'selected', description: 'Selected styling.'),
  EnumCaseDoc(name: 'disabled', description: 'Disabled styling.'),
  EnumCaseDoc(name: 'error', description: 'Error styling.'),
];

const _avatarSizes = [
  EnumCaseDoc(name: 'xs', description: '24dp avatar.'),
  EnumCaseDoc(name: 'sm', description: '32dp avatar.'),
  EnumCaseDoc(name: 'md', description: '40dp avatar.'),
  EnumCaseDoc(name: 'lg', description: '48dp avatar.'),
  EnumCaseDoc(name: 'xl', description: '56dp avatar.'),
  EnumCaseDoc(name: 'x2l', description: '64dp avatar.'),
  EnumCaseDoc(name: 'x3l', description: '80dp avatar.'),
];

const _avatarStatuses = [
  EnumCaseDoc(name: 'online', description: 'User is online.'),
  EnumCaseDoc(name: 'away', description: 'User is away.'),
  EnumCaseDoc(name: 'busy', description: 'User is busy.'),
  EnumCaseDoc(name: 'offline', description: 'User is offline.'),
];

const _switchVariants = [
  EnumCaseDoc(name: 'success', description: 'Success accent.'),
  EnumCaseDoc(name: 'error', description: 'Error accent.'),
];

const _toastVariants = [
  EnumCaseDoc(
    name: 'defaultToast',
    description: 'Neutral inverse-surface toast.',
  ),
  EnumCaseDoc(name: 'info', description: 'Informational toast.'),
  EnumCaseDoc(name: 'success', description: 'Success toast.'),
  EnumCaseDoc(name: 'warning', description: 'Warning toast.'),
  EnumCaseDoc(name: 'error', description: 'Error toast.'),
];

const _progressVariants = [
  EnumCaseDoc(name: 'primary', description: 'Primary progress color.'),
  EnumCaseDoc(name: 'success', description: 'Success progress color.'),
  EnumCaseDoc(name: 'warning', description: 'Warning progress color.'),
  EnumCaseDoc(name: 'error', description: 'Error progress color.'),
  EnumCaseDoc(
    name: 'indeterminate',
    description: 'Animated indeterminate progress.',
  ),
];

const _loaderTypes = [
  EnumCaseDoc(name: 'circular', description: 'Circular spinner.'),
  EnumCaseDoc(name: 'dots', description: 'Animated dot trio.'),
  EnumCaseDoc(name: 'bar', description: 'Linear progress style.'),
  EnumCaseDoc(name: 'ring', description: 'Thicker circular ring.'),
];

const _cardVariants = [
  EnumCaseDoc(name: 'defaultCard', description: 'Default neutral card.'),
  EnumCaseDoc(name: 'success', description: 'Success-tinted card.'),
  EnumCaseDoc(name: 'warning', description: 'Warning-tinted card.'),
  EnumCaseDoc(name: 'error', description: 'Error-tinted card.'),
  EnumCaseDoc(name: 'info', description: 'Info-tinted card.'),
];

const _cardLayouts = [
  EnumCaseDoc(name: 'vertical', description: 'Media above content.'),
  EnumCaseDoc(name: 'horizontal', description: 'Media beside content.'),
];

const _containerVariants = [
  EnumCaseDoc(name: 'surface', description: 'Standard surface.'),
  EnumCaseDoc(name: 'muted', description: 'Muted surface variant.'),
  EnumCaseDoc(name: 'outlined', description: 'Bordered surface.'),
];

const _columnTypes = [
  EnumCaseDoc(name: 'text', description: 'Plain text cell.'),
  EnumCaseDoc(name: 'badge', description: 'Badge-rendered cell.'),
  EnumCaseDoc(name: 'avatarText', description: 'Avatar plus text cell.'),
  EnumCaseDoc(name: 'progress', description: 'Progress-rendered cell.'),
  EnumCaseDoc(name: 'custom', description: 'Custom cellBuilder-driven cell.'),
];

const _selectionModes = [
  EnumCaseDoc(name: 'none', description: 'No row selection.'),
  EnumCaseDoc(name: 'single', description: 'One selected row at a time.'),
  EnumCaseDoc(name: 'multiple', description: 'Multiple selected rows.'),
];

const _widthBehaviors = [
  EnumCaseDoc(
    name: 'stretch',
    description: 'Stretch columns across available width.',
  ),
  EnumCaseDoc(
    name: 'compact',
    description: 'Respect content widths and allow horizontal scroll.',
  ),
];

const _alertVariants = [
  EnumCaseDoc(name: 'info', description: 'Informational alert.'),
  EnumCaseDoc(name: 'success', description: 'Success alert.'),
  EnumCaseDoc(name: 'warning', description: 'Warning alert.'),
  EnumCaseDoc(name: 'error', description: 'Error alert.'),
];

const _stepStatuses = [
  EnumCaseDoc(name: 'completed', description: 'Step already completed.'),
  EnumCaseDoc(name: 'inProgress', description: 'Current active step.'),
  EnumCaseDoc(name: 'pending', description: 'Future step.'),
];

const _stepperOrientations = [
  EnumCaseDoc(name: 'vertical', description: 'Vertical stepper layout.'),
  EnumCaseDoc(name: 'horizontal', description: 'Horizontal stepper layout.'),
];

const _timelineOrientations = [
  EnumCaseDoc(name: 'vertical', description: 'Vertical timeline layout.'),
  EnumCaseDoc(name: 'horizontal', description: 'Horizontal timeline layout.'),
];

const _appBarStyles = [
  EnumCaseDoc(name: 'primary', description: 'Primary brand background.'),
  EnumCaseDoc(name: 'surface', description: 'Neutral surface background.'),
  EnumCaseDoc(name: 'dark', description: 'Inverse / dark surface background.'),
  EnumCaseDoc(name: 'transparent', description: 'Transparent background.'),
];

const _tabVariants = [
  EnumCaseDoc(name: 'line', description: 'Underline-style tabs.'),
  EnumCaseDoc(name: 'pill', description: 'Segmented pill-style tabs.'),
  EnumCaseDoc(name: 'card', description: 'Card-edged tabs.'),
];

const _sideNavStyles = [
  EnumCaseDoc(name: 'surface', description: 'Neutral side nav chrome.'),
  EnumCaseDoc(name: 'brand', description: 'Brand-colored side nav chrome.'),
];

const _brandIconVariants = [
  EnumCaseDoc(name: 'master', description: 'Full master logo lockup.'),
  EnumCaseDoc(name: 'logo', description: 'Symbol-only logo variant.'),
  EnumCaseDoc(name: 'name', description: 'Wordmark-only variant.'),
];
