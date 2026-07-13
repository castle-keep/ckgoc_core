import 'package:flutter/material.dart';
import 'package:ckgoc_core/ckgoc_core.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool _showProgressValues = false;
  double _sliderValue = 65;
  bool _showSliderValue = true;

  final _alertVariants = [
    (
      AlertVariant.info,
      'Info',
      'This is an informational message for the user.',
    ),
    (
      AlertVariant.success,
      'Success',
      'Operation completed successfully. All changes saved.',
    ),
    (
      AlertVariant.warning,
      'Warning',
      'Please review before proceeding. This is irreversible.',
    ),
    (AlertVariant.error, 'Error', 'An error occurred. Please try again.'),
  ];

  final Set<AlertVariant> _dismissedAlerts = {};

  void _showSnackbar(BuildContext ctx, ToastVariant variant, String message) {
    CkgocSnackbar.show(ctx, message, variant: variant);
  }

  Widget _label(String text, CkgocThemeData theme) => Text(
    text,
    style: theme.typography.labelSm.copyWith(
      color: theme.colors.onSurfaceVariant,
      letterSpacing: 0.8,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;

    final progressVariants = [
      (ProgressVariant.primary, 'Primary', 0.72),
      (ProgressVariant.success, 'Success', 0.68),
      (ProgressVariant.warning, 'Warning', 0.45),
      (ProgressVariant.error, 'Error', 0.23),
      (ProgressVariant.indeterminate, 'Indeterminate', null),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(s.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Inline Alerts
          _label('INLINE ALERTS', theme),
          SizedBox(height: s.sm),
          ...(_alertVariants
              .where((e) => !_dismissedAlerts.contains(e.$1))
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(bottom: s.sm),
                  child: CkgocAlert(
                    variant: e.$1,
                    title: e.$2,
                    message: e.$3,
                    onDismiss: () => setState(() => _dismissedAlerts.add(e.$1)),
                  ),
                ),
              )),
          if (_dismissedAlerts.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _dismissedAlerts.clear()),
              child: const Text('Reset alerts'),
            ),

          SizedBox(height: s.xl),

          //  Toast / Snackbar
          _label('TOAST / SNACKBAR', theme),
          SizedBox(height: s.sm),
          Wrap(
            spacing: s.sm,
            runSpacing: s.sm,
            children: [
              CkgocButton(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _showSnackbar(
                  context,
                  ToastVariant.defaultToast,
                  'Default notification message here',
                ),
                child: const Text('Default'),
              ),
              CkgocButton(
                size: ButtonSize.sm,
                variant: ButtonVariant.success,
                onPressed: () => _showSnackbar(
                  context,
                  ToastVariant.success,
                  'Success notification message here',
                ),
                child: const Text('Success'),
              ),
              CkgocButton(
                size: ButtonSize.sm,
                variant: ButtonVariant.destructive,
                onPressed: () => _showSnackbar(
                  context,
                  ToastVariant.error,
                  'Error notification message here',
                ),
                child: const Text('Error'),
              ),
              CkgocButton(
                size: ButtonSize.sm,
                variant: ButtonVariant.warning,
                onPressed: () => _showSnackbar(
                  context,
                  ToastVariant.warning,
                  'Warning notification message here',
                ),
                child: const Text('Warning'),
              ),
              CkgocButton(
                size: ButtonSize.sm,
                variant: ButtonVariant.info,
                onPressed: () => _showSnackbar(
                  context,
                  ToastVariant.info,
                  'Info notification message here',
                ),
                child: const Text('Info'),
              ),
            ],
          ),

          SizedBox(height: s.xl),

          //  Progress Bars
          Row(
            children: [
              _label('PROGRESS BARS — LINEAR', theme),
              const Spacer(),
              Text(
                'Show values',
                style: theme.typography.textSm.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              SizedBox(width: s.xs),
              CkgocSwitch(
                value: _showProgressValues,
                onChanged: (v) => setState(() => _showProgressValues = v),
              ),
            ],
          ),
          SizedBox(height: s.md),
          ...progressVariants.map(
            (entry) => Padding(
              padding: EdgeInsets.only(bottom: s.sm),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      entry.$2,
                      style: theme.typography.textSm.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CkgocProgressBar(
                      value: entry.$3,
                      variant: entry.$1,
                      showValue: _showProgressValues,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: s.xl),

          // Slider
          Row(
            children: [
              _label('SLIDER', theme),
              const Spacer(),
              Text(
                'Show value',
                style: theme.typography.textSm.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              SizedBox(width: s.xs),
              CkgocSwitch(
                value: _showSliderValue,
                onChanged: (v) => setState(() => _showSliderValue = v),
              ),
            ],
          ),
          SizedBox(height: s.sm),
          CkgocSlider(
            value: _sliderValue,
            min: 0,
            max: 100,
            showValue: _showSliderValue,
            onChanged: (v) => setState(() => _sliderValue = v),
          ),

          SizedBox(height: s.xl),

          //  Spinners / Loaders
          _label('SPINNERS / LOADERS', theme),
          SizedBox(height: s.md),
          Wrap(
            spacing: s.xl,
            runSpacing: s.xl,
            children: [
              _loaderTile(LoaderType.circular, 'Circular', theme),
              _loaderTile(LoaderType.bar, 'Bar', theme),
              _loaderTile(LoaderType.dots, 'Dots', theme),
              _loaderTile(LoaderType.ring, 'Ring', theme),
            ],
          ),

          SizedBox(height: s.xl),

          _label('LOADER SIZES — CIRCULAR', theme),
          SizedBox(height: s.md),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: s.lg,
            runSpacing: s.md,
            children: [24.0, 32.0, 40.0, 56.0, 72.0]
                .map((sz) => CkgocLoader(type: LoaderType.circular, size: sz))
                .toList(),
          ),

          SizedBox(height: s.xl),

          _label('LOADER COLORS', theme),
          SizedBox(height: s.md),
          Wrap(
            spacing: s.lg,
            runSpacing: s.md,
            children: [
              CkgocLoader(type: LoaderType.circular),
              CkgocLoader(
                type: LoaderType.circular,
                color: theme.colors.success,
              ),
              CkgocLoader(
                type: LoaderType.circular,
                color: theme.colors.warning,
              ),
              CkgocLoader(type: LoaderType.circular, color: theme.colors.error),
              CkgocLoader(type: LoaderType.circular, color: theme.colors.info),
            ],
          ),

          SizedBox(height: s.xl),
        ],
      ),
    );
  }

  Widget _loaderTile(LoaderType type, String label, CkgocThemeData theme) {
    final s = theme.spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: Center(child: CkgocLoader(type: type)),
        ),
        SizedBox(height: s.xs),
        Text(
          label,
          style: theme.typography.textSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
