import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

class CkgocStepper extends StatelessWidget {
  const CkgocStepper({
    required this.steps,
    this.orientation = CkgocStepperOrientation.vertical,
    this.checkColor,
    this.lineColor,
    super.key,
  });
  final List<CkgocStep> steps;
  final CkgocStepperOrientation orientation;
  final Color? checkColor;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    return orientation == CkgocStepperOrientation.vertical
        ? _VerticalStepper(
            steps: steps,
            checkColor: checkColor,
            lineColor: lineColor,
          )
        : _HorizontalStepper(
            steps: steps,
            checkColor: checkColor,
            lineColor: lineColor,
          );
  }
}

Widget _buildCircle(
  BuildContext context,
  CkgocStep step,
  int index,
  Color? checkColor,
) {
  final theme = context.ckgocTheme;
  final colors = theme.colors;
  final spacing = theme.spacing;
  final typography = theme.typography;

  final primary = colors.primary;
  final muted = colors.onSurfaceVariant;
  final stepColor = step.color ?? primary;
  final circleSize = spacing.xl; // 32

  final isCompleted = step.status == StepStatus.completed;
  final isInProgress = step.status == StepStatus.inProgress;
  final isPending = step.status == StepStatus.pending;

  final bgColor = isCompleted
      ? stepColor
      : isInProgress
      ? colors.surface
      : colors.surfaceVariant;
  final borderColor = isPending ? colors.outlineVariant : stepColor;
  final fgColor = isCompleted
      ? (checkColor ?? colors.onPrimary)
      : isInProgress
      ? stepColor
      : muted;

  Widget inner;
  if (step.icon != null) {
    inner = step.icon!;
  } else if (isCompleted) {
    inner = Icon(LucideIcons.check, size: spacing.md, color: fgColor);
  } else {
    inner = Text(
      '${index + 1}',
      style: typography.labelSm.copyWith(color: fgColor),
    );
  }

  return Container(
    width: circleSize,
    height: circleSize,
    decoration: BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
      border: Border.all(
        color: borderColor,
        width: isInProgress ? spacing.xxs : 1.5,
      ),
    ),
    child: Center(child: inner),
  );
}

String _statusLabel(StepStatus status) => switch (status) {
  StepStatus.completed => 'Completed',
  StepStatus.inProgress => 'In Progress',
  StepStatus.pending => 'Pending',
};

class _VerticalStepper extends StatelessWidget {
  const _VerticalStepper({
    required this.steps,
    this.checkColor,
    this.lineColor,
  });
  final List<CkgocStep> steps;
  final Color? checkColor;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final connectorColor = lineColor ?? colors.outlineVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildCircle(context, steps[i], i, checkColor),
                  if (i < steps.length - 1)
                    Container(
                      width: spacing.xxs,
                      height: spacing.xl,
                      color: connectorColor,
                    ),
                ],
              ),
              SizedBox(width: spacing.sm),
              Padding(
                padding: EdgeInsets.only(top: spacing.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i].title,
                      style: typography.labelMd.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    Text(
                      _statusLabel(steps[i].status),
                      style: typography.textSm.copyWith(
                        color: steps[i].status == StepStatus.pending
                            ? colors.onSurfaceVariant
                            : steps[i].color ?? colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _HorizontalStepper extends StatelessWidget {
  const _HorizontalStepper({
    required this.steps,
    this.checkColor,
    this.lineColor,
  });
  final List<CkgocStep> steps;
  final Color? checkColor;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final connectorColor = lineColor ?? colors.outlineVariant;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (i > 0)
                      Expanded(
                        child: Container(
                          height: spacing.xxs,
                          color: connectorColor,
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                    _buildCircle(context, steps[i], i, checkColor),
                    if (i < steps.length - 1)
                      Expanded(
                        child: Container(
                          height: spacing.xxs,
                          color: connectorColor,
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(height: spacing.xs),
                Text(
                  steps[i].title,
                  style: typography.labelSm.copyWith(color: colors.onSurface),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _statusLabel(steps[i].status),
                  style: typography.textXs.copyWith(
                    color: steps[i].status == StepStatus.pending
                        ? colors.onSurfaceVariant
                        : steps[i].color ?? colors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
