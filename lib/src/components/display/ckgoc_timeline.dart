import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

Color _timelineDotColor({
  required CkgocTimelineEvent event,
  required Color completedColor,
  required Color primaryColor,
  required Color pendingColor,
}) {
  return event.dotColor ??
      (event.status == StepStatus.inProgress
          ? primaryColor
          : event.status == StepStatus.pending
          ? pendingColor
          : completedColor);
}

Color _timelineConnectorColor({
  required CkgocTimelineEvent current,
  required CkgocTimelineEvent next,
  required Color defaultCompletedColor,
  required Color primaryColor,
  required Color pendingColor,
}) {
  if (current.status == StepStatus.pending ||
      next.status == StepStatus.pending) {
    return pendingColor;
  }

  if (current.status == StepStatus.completed &&
      next.status == StepStatus.completed) {
    return current.dotColor ?? next.dotColor ?? defaultCompletedColor;
  }

  return primaryColor;
}

class CkgocTimeline extends StatelessWidget {
  const CkgocTimeline({
    required this.events,
    this.orientation = CkgocTimelineOrientation.vertical,
    this.lineColor,
    this.dotColor,
    super.key,
  });
  final List<CkgocTimelineEvent> events;
  final CkgocTimelineOrientation orientation;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return orientation == CkgocTimelineOrientation.vertical
        ? _VerticalTimeline(
            events: events,
            lineColor: lineColor,
            dotColor: dotColor,
          )
        : _HorizontalTimeline(
            events: events,
            lineColor: lineColor,
            dotColor: dotColor,
          );
  }
}

class _VerticalTimeline extends StatelessWidget {
  const _VerticalTimeline({
    required this.events,
    this.lineColor,
    this.dotColor,
  });
  final List<CkgocTimelineEvent> events;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final resolvedLine = lineColor ?? colors.outlineVariant;
    final resolvedDot = dotColor ?? colors.success;
    final dotSize = spacing.s12; // 12dp dot
    final dotBorder = spacing.xxs; // 2dp border

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < events.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dot + connector column
                SizedBox(
                  width: dotSize + dotBorder * 2,
                  child: Column(
                    children: [
                      // compute dot color based on status or explicit override
                      _buildDot(
                        events[i],
                        _timelineDotColor(
                          event: events[i],
                          completedColor: resolvedDot,
                          primaryColor: colors.primary,
                          pendingColor: colors.onSurfaceVariant,
                        ),
                        dotSize,
                        dotBorder,
                      ),
                      if (i < events.length - 1)
                        Expanded(
                          child: Center(
                            child: Container(
                              width: spacing.xxs,
                              color: _timelineConnectorColor(
                                current: events[i],
                                next: events[i + 1],
                                defaultCompletedColor: resolvedDot,
                                primaryColor: colors.primary,
                                pendingColor: resolvedLine,
                              ),
                            ),
                          ),
                        ),
                      if (i == events.length - 1) SizedBox(height: spacing.md),
                    ],
                  ),
                ),
                // Timestamp + title stacked
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: spacing.sm,
                      bottom: i < events.length - 1 ? spacing.lg : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          events[i].title,
                          style: typography.labelMd.copyWith(
                            color: colors.onSurface,
                          ),
                        ),
                        if (events[i].timestamp != null)
                          Text(
                            events[i].timestamp!,
                            style: typography.textXs.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDot(
    CkgocTimelineEvent event,
    Color defaultColor,
    double size,
    double border,
  ) {
    if (event.icon != null) return event.icon!;
    final color = event.dotColor ?? defaultColor;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: border),
      ),
      child: event.status == StepStatus.completed
          ? Center(
              child: Icon(Icons.check, size: size * 0.75, color: Colors.white),
            )
          : null,
    );
  }
}

class _HorizontalTimeline extends StatelessWidget {
  const _HorizontalTimeline({
    required this.events,
    this.lineColor,
    this.dotColor,
  });
  final List<CkgocTimelineEvent> events;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final resolvedLine = lineColor ?? colors.outlineVariant;
    final resolvedDot = dotColor ?? colors.success;
    final dotSize = spacing.s12; // 12dp dot

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < events.length; i++)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (i > 0)
                      Expanded(
                        child: Container(
                          height: spacing.xxs,
                          color: _timelineConnectorColor(
                            current: events[i - 1],
                            next: events[i],
                            defaultCompletedColor: resolvedDot,
                            primaryColor: colors.primary,
                            pendingColor: resolvedLine,
                          ),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                    _buildDot(
                      events[i],
                      _timelineDotColor(
                        event: events[i],
                        completedColor: resolvedDot,
                        primaryColor: colors.primary,
                        pendingColor: colors.onSurfaceVariant,
                      ),
                      dotSize,
                    ),
                    if (i < events.length - 1)
                      Expanded(
                        child: Container(
                          height: spacing.xxs,
                          color: _timelineConnectorColor(
                            current: events[i],
                            next: events[i + 1],
                            defaultCompletedColor: resolvedDot,
                            primaryColor: colors.primary,
                            pendingColor: resolvedLine,
                          ),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(height: spacing.sm),
                Text(
                  events[i].title,
                  style: typography.labelMd.copyWith(color: colors.onSurface),
                  textAlign: TextAlign.center,
                ),
                if (events[i].timestamp != null)
                  Text(
                    events[i].timestamp!,
                    style: typography.textXs.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDot(CkgocTimelineEvent event, Color defaultColor, double size) {
    if (event.icon != null) return event.icon!;
    final color = event.dotColor ?? defaultColor;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: event.status == StepStatus.completed
          ? Center(
              child: Icon(Icons.check, size: size * 0.75, color: Colors.white),
            )
          : null,
    );
  }
}
