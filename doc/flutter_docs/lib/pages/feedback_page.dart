import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

import 'package:ckcore_docs_app/docs/doc_models.dart';
import 'package:ckcore_docs_app/docs/doc_widgets.dart';
import '../docs/mappings.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Feedback Components',
      subtitle: 'Documentation for every file in lib/src/components/feedback.',
      children: [
        DocSection(data: _alertDoc()),
        DocSection(data: _loaderDoc()),
        DocSection(data: _progressDoc()),
        DocSection(data: _snackbarDoc()),
        DocSection(data: _toastDoc()),
        DocSection(data: _skeletonDoc()),
        DocSection(data: _emptyStateDoc()),
        DocSection(data: _loadingStateDoc()),
        DocSection(data: _errorStateDoc()),
      ],
    );
  }
}

ComponentDocData _alertDoc() => const ComponentDocData(
      title: 'CKAlert',
      summary:
          'Inline message banner for info, success, warning, and error states.',
      demo: _AlertDemo(),
      code: '''
// Default constructor for info (informational, default variant)
CKAlert(
  title: 'Information',
  message: 'This is an informational message.',
)

// Named constructors for other variants
CKAlert.success(
  title: 'Settings saved',
  message: 'Your preferences were updated successfully.',
)
CKAlert.warning(...)
CKAlert.error(...)
''',
      params: [
        DocParam(
          name: 'message',
          type: 'String',
          description: 'Body message content.',
          requiredParam: true,
        ),
        DocParam(
          name: 'title',
          type: 'String?',
          description: 'Optional headline.',
        ),
        DocParam(
          name: 'variant',
          type: 'AlertVariant',
          description: 'Severity / meaning.',
          defaultValue: 'AlertVariant.info',
        ),
        DocParam(
          name: 'onDismiss',
          type: 'VoidCallback?',
          description: 'Optional dismiss action.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use alert instead of snackbar?',
          answer:
              'Use alerts when the message belongs inside page content and should persist with the layout. Use snackbar for temporary transient feedback.',
        ),
        DocFaq(
          question: 'Can it be dismissible?',
          answer: 'Yes. Pass onDismiss to render the dismiss affordance.',
        ),
      ],
      notes: [
        'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
        'Enum demo coverage: all AlertVariant values are rendered.',
      ],
    );

ComponentDocData _loaderDoc() => const ComponentDocData(
      title: 'CKLoader',
      summary:
          'Token-based loading indicators. The live demo renders every LoaderType value.',
      demo: _LoaderDemo(),
      code: '''
// Default constructor for circular (most common loader type)
CKLoader(size: 32)

// Named constructors for other types
Wrap(
  spacing: 16,
  children: [
    CKLoader(size: 32),          // circular
    CKLoader.ring(size: 32),
    CKLoader.bar(size: 32),
    CKLoader.dots(size: 32),
  ],
)
''',
      params: [
        DocParam(
          name: 'type',
          type: 'LoaderType',
          description: 'Loader visual style.',
          defaultValue: 'LoaderType.circular',
        ),
        DocParam(
          name: 'color',
          type: 'Color?',
          description: 'Optional explicit color override.',
        ),
        DocParam(
          name: 'size',
          type: 'double',
          description: 'Base visual size.',
          defaultValue: '40',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Which loader should I use for inline states?',
          answer:
              'Use circular or dots for compact inline work. Use bar for width-based progress regions.',
        ),
        DocFaq(
          question: 'Does size affect every loader the same way?',
          answer:
              'It is treated as the base measurement, but each loader maps that size to its own geometry.',
        ),
      ],
      notes: [
        'Enum demo coverage: all LoaderType values are rendered.',
        'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
      ],
    );

ComponentDocData _progressDoc() => const ComponentDocData(
      title: 'CKProgressBar and CKSlider',
      summary:
          'Determinate and indeterminate progress plus value selection. The demo renders every ProgressVariant and a live slider.',
      demo: _ProgressDemo(),
      code: '''
// Default constructor for primary (most common progress bar)
CKProgressBar(value: 0.64, maxValue: 1.0, showValue: true)

// Named constructors for semantic variants
CKProgressBar.success(value: 1.0)
CKProgressBar.warning(value: 0.75)
CKProgressBar.error(value: 0.25)
    ''',
      params: [
        DocParam(
          name: 'value',
          type: 'double?',
          description:
              'Current progress value. Null plus indeterminate variant yields animated mode.',
        ),
        DocParam(
          name: 'maxValue',
          type: 'double',
          description: 'Upper bound used for normalization.',
        ),
        DocParam(
          name: 'variant',
          type: 'ProgressVariant',
          description: 'Color and indeterminate behavior.',
        ),
        DocParam(
          name: 'showValue',
          type: 'bool',
          description: 'Displays numeric percentage for determinate progress.',
        ),
        DocParam(
          name: 'onChanged',
          type: 'ValueChanged<double>',
          description: 'Slider-only callback.',
        ),
        DocParam(
          name: 'min',
          type: 'double',
          description: 'Slider-only minimum.',
        ),
        DocParam(
          name: 'max',
          type: 'double',
          description: 'Slider-only maximum.',
        ),
        DocParam(
          name: 'color',
          type: 'Color?',
          description: 'Slider-only active color override.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'How do I show indeterminate progress?',
          answer: 'Use ProgressVariant.indeterminate and leave value null.',
        ),
        DocFaq(
          question: 'Why is the slider documented together?',
          answer:
              'Both are implemented in the same source file and often used together in demos and settings panels.',
        ),
      ],
      notes: [
        'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
        'Enum demo coverage: all ProgressVariant values are rendered.',
      ],
    );

ComponentDocData _snackbarDoc() => const ComponentDocData(
      title: 'CKSnackbar',
      summary: 'Static helper that shows a SnackBar with CKToast content.',
      demo: _SnackbarDemo(),
      code: '''
CKSnackbar.show(
  context,
  'Profile updated',
  variant: ToastVariant.success,
)
''',
      params: [
        DocParam(
          name: 'context',
          type: 'BuildContext',
          description: 'Context used to resolve ScaffoldMessenger.',
        ),
        DocParam(
          name: 'message',
          type: 'String',
          description: 'Displayed message.',
        ),
        DocParam(
          name: 'variant',
          type: 'ToastVariant',
          description: 'Toast styling variant.',
        ),
        DocParam(
          name: 'duration',
          type: 'Duration',
          description: 'SnackBar visibility duration.',
        ),
        DocParam(
          name: 'onDismiss',
          type: 'VoidCallback?',
          description: 'Custom dismiss action.',
        ),
        DocParam(
          name: 'position',
          type: 'CKSnackbarPosition',
          description: 'SnackBar vertical position.',
        ),
      ],
      faqs: [
        DocFaq(
          question:
              'Why does it use ToastVariant instead of a separate snackbar enum?',
          answer: 'It reuses the toast visuals as the snackbar content.',
        ),
        DocFaq(
          question: 'Can I stack multiple snackbars?',
          answer:
              'The helper hides the current snackbar before showing the next one.',
        ),
      ],
    );

ComponentDocData _toastDoc() => const ComponentDocData(
      title: 'CKToast',
      summary: 'Transient toast surface used directly or as snackbar content.',
      demo: _ToastDemo(),
      code: '''
    // Default constructor for neutral (default, most general use)
    CKToast(message: 'Changes saved', onDismiss: () {})
    
    // Named constructors for semantic variants
    CKToast.success(message: 'Saved!')
    CKToast.error(message: 'Failed')
    CKToast.warning(message: 'Caution')
    CKToast.info(message: 'FYI')
    ''',
      params: [
        DocParam(
          name: 'message',
          type: 'String',
          description: 'Toast body text.',
          requiredParam: true,
        ),
        DocParam(
          name: 'variant',
          type: 'ToastVariant',
          description: 'Toast styling variant.',
          defaultValue: 'ToastVariant.defaultToast',
        ),
        DocParam(
          name: 'onDismiss',
          type: 'VoidCallback?',
          description: 'Optional close affordance handler.',
        ),
      ],
      notes: [
        'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
        'Enum demo coverage: all ToastVariant values are rendered.',
      ],
      faqs: [
        DocFaq(
          question: 'Should I place it directly in page content?',
          answer:
              'Usually no. It is primarily intended for transient surfaces like snackbars, overlays, or custom toast hosts.',
        ),
        DocFaq(
          question: 'When is the default variant useful?',
          answer:
              'Use it for neutral system updates that do not need success, warning, info, or error semantics.',
        ),
      ],
    );

ComponentDocData _skeletonDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CKSkeleton',
      summary:
          'Loading placeholder API surface. The current package implementation is a placeholder widget body.',
      demo: _SkeletonDemo(),
      code: '''
CKSkeleton(
  width: 240,
  height: 20,
  borderRadius: 12,
)
''',
      params: [
        DocParam(
          name: 'width',
          type: 'double',
          description: 'Skeleton width.',
          requiredParam: true,
        ),
        DocParam(
          name: 'height',
          type: 'double',
          description: 'Skeleton height.',
          requiredParam: true,
        ),
        DocParam(
          name: 'borderRadius',
          type: 'double?',
          description: 'Optional rounding radius.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'What should I document while it is incomplete?',
          answer:
              'Document expected width, height, and intended loading use cases so adopters know the contract before visuals land.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _emptyStateDoc() => const ComponentDocData(
      comingSoon: true,
      title: 'CKEmptyState',
      summary:
          'Empty state API surface for no-results and no-data scenarios. Current implementation is a placeholder widget body.',
      demo: _EmptyStateDemo(),
      code: '''
    // Recommended: semantic named constructors
    CKEmptyState(
      title: 'No projects yet',
      description: 'Create your first project to get started.',
      action: CKButton(onPressed: () {}, child: Text('Create project')),
    )
    ''',
      params: [
        DocParam(
          name: 'title',
          type: 'String',
          description: 'Primary empty-state heading.',
          requiredParam: true,
        ),
        DocParam(
          name: 'description',
          type: 'String?',
          description: 'Supporting explanation.',
        ),
        DocParam(
          name: 'illustration',
          type: 'Widget?',
          description: 'Optional visual asset.',
        ),
        DocParam(
          name: 'action',
          type: 'Widget?',
          description: 'Call-to-action widget.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'What content belongs here?',
          answer:
              'Use a clear title, a short explanation, and one focused action that helps the user leave the empty state.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

ComponentDocData _loadingStateDoc() => const ComponentDocData(
      title: 'CKLoadingState',
      summary:
          'Centered loader plus optional message for full-screen or card-level loading experiences.',
      demo: _LoadingStateDemo(),
      code: '''
CKLoadingState(
  message: 'Loading team members...',
  loaderSize: 40,
  variant: LoaderType.circular,
)
''',
      params: [
        DocParam(
          name: 'message',
          type: 'String?',
          description: 'Optional loading caption.',
        ),
        DocParam(
          name: 'loaderSize',
          type: 'double?',
          description: 'Explicit size override for the inner loader.',
        ),
        DocParam(
          name: 'variant',
          type: 'LoaderType',
          description: 'Selects which loader visual is rendered.',
          defaultValue: 'LoaderType.circular',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I use this instead of CKLoader?',
          answer:
              'Use this composite widget when you want layout and copy bundled together instead of composing them manually.',
        ),
        DocFaq(
          question: 'Can I place it in cards?',
          answer: 'Yes. It centers correctly inside any constrained parent.',
        ),
      ],
      notes: [
        'The loader type is forwarded to the internal CKLoader via the variant property.',
        'Roadmap: The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.',
      ],
    );

ComponentDocData _errorStateDoc() => const ComponentDocData(
      title: 'CKErrorState',
      comingSoon: true,
      summary:
          'Error state API surface for failed page or module loads. Current implementation is a placeholder widget body.',
      demo: _ErrorStateDemo(),
      code: '''
CKErrorState(
  title: 'Could not load projects',
  description: 'Check your connection and try again.',
  onRetry: () {},
)
''',
      params: [
        DocParam(
          name: 'title',
          type: 'String',
          description: 'Primary error heading.',
          requiredParam: true,
        ),
        DocParam(
          name: 'description',
          type: 'String?',
          description: 'Supporting explanation.',
        ),
        DocParam(
          name: 'onRetry',
          type: 'VoidCallback?',
          description: 'Retry action handler.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why is the live output blank?',
          answer:
              'This component is still a placeholder in the package implementation and currently returns SizedBox.shrink().',
        ),
        DocFaq(
          question: 'What should retry do?',
          answer:
              'Retry should re-run the failed network or state action rather than just dismissing the error.',
        ),
      ],
      notes: [
        'Implementation status: placeholder widget body in the package source.',
      ],
    );

class _AlertDemo extends StatelessWidget {
  const _AlertDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final variant in AlertVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: switch (variant) {
              AlertVariant.info => CKAlert(
                  title: variant.name,
                  message:
                      'This alert demonstrates the ${variant.name} state.'),
              AlertVariant.success => CKAlert.success(
                  title: variant.name,
                  message:
                      'This alert demonstrates the ${variant.name} state.'),
              AlertVariant.warning => CKAlert.warning(
                  title: variant.name,
                  message:
                      'This alert demonstrates the ${variant.name} state.'),
              AlertVariant.error => CKAlert.error(
                  title: variant.name,
                  message:
                      'This alert demonstrates the ${variant.name} state.'),
            },
          ),
      ],
    );
  }
}

class _LoaderDemo extends StatelessWidget {
  const _LoaderDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        for (final type in LoaderType.values)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              loaderFor(type, size: 32),
              const SizedBox(height: 8),
              Text(type.name),
            ],
          ),
      ],
    );
  }
}

class _ProgressDemo extends StatefulWidget {
  const _ProgressDemo();

  @override
  State<_ProgressDemo> createState() => _ProgressDemoState();
}

class _ProgressDemoState extends State<_ProgressDemo> {
  double value = 64;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final variant in ProgressVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: progressBarFor(
              variant,
              value: variant == ProgressVariant.indeterminate ? null : value,
              maxValue: 100,
              showValue: variant != ProgressVariant.indeterminate,
            ),
          ),
        const SizedBox(height: 12),
        CKSlider(
          value: value,
          showValue: true,
          onChanged: (next) => setState(() => value = next),
        ),
      ],
    );
  }
}

class _SnackbarDemo extends StatelessWidget {
  const _SnackbarDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final variant in ToastVariant.values)
          CKButton(
            onPressed: () => CKSnackbar.show(
              context,
              'Snackbar: ${variant.name}',
              variant: variant,
            ),
            child: Text(variant.name),
          ),
      ],
    );
  }
}

class _ToastDemo extends StatelessWidget {
  const _ToastDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final variant in ToastVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: 420,
              child: toastFor(variant, 'Toast variant: ${variant.name}'),
            ),
          ),
      ],
    );
  }
}

class _SkeletonDemo extends StatelessWidget {
  const _SkeletonDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        SizedBox(height: 12),
        CKSkeleton(width: 240, height: 18, borderRadius: 12),
      ],
    );
  }
}

class _EmptyStateDemo extends StatelessWidget {
  const _EmptyStateDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Current implementation returns an empty widget.'),
        const SizedBox(height: 12),
        CKEmptyState(
          title: 'No projects yet',
          description: 'Create your first project to get started.',
          action: CKButton(
            onPressed: () {},
            child: const Text('Create project'),
          ),
        ),
      ],
    );
  }
}

class _LoadingStateDemo extends StatelessWidget {
  const _LoadingStateDemo();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 180,
      child: Column(
        children: [
          Expanded(
            child: CKLoadingState(
              message: 'Loading dashboard data...',
              loaderSize: 40,
              variant: LoaderType.circular,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: CKLoadingState(
              message: 'Preparing analytics...',
              loaderSize: 28,
              variant: LoaderType.dots,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorStateDemo extends StatelessWidget {
  const _ErrorStateDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current implementation returns an empty widget.'),
        SizedBox(height: 12),
        CKErrorState(
          title: 'Could not load projects',
          description: 'Check your connection and try again.',
        ),
      ],
    );
  }
}
