import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

Color _timelineDotColor({
  required CKTimelineEvent event,
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
  required CKTimelineEvent current,
  required CKTimelineEvent next,
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

class CKTimeline extends StatelessWidget {
  const CKTimeline({
    required this.events,
    this.orientation = CKTimelineOrientation.vertical,
    this.lineColor,
    this.dotColor,
    super.key,
  });
  final List<CKTimelineEvent> events;
  final CKTimelineOrientation orientation;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return orientation == CKTimelineOrientation.vertical
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
  final List<CKTimelineEvent> events;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final resolvedLine = lineColor ?? colors.outlineVariant;
    final resolvedDot = dotColor ?? colors.success;
    final dotSize = spacing.s20; // 20dp dot
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
                        context,
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
    BuildContext context,
    CKTimelineEvent event,
    Color defaultColor,
    double size,
    double border,
  ) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;

    // Determine color, honoring explicit dotColor first, then status-based
    // defaults. Rejected events show the theme's `error` color.
    final color =
        event.dotColor ??
        (event.status == StepStatus.rejected ? colors.error : defaultColor);

    // If caller provided a custom icon widget, size and center it to the
    // expected dot size so it never overflows or gets clipped awkwardly.
    if (event.icon != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: border),
        ),
        child: Center(child: event.icon),
      );
    }

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
          : event.status == StepStatus.rejected
          ? Center(
              child: Icon(Icons.close, size: size * 0.75, color: Colors.white),
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
  final List<CKTimelineEvent> events;
  final Color? lineColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    final resolvedLine = lineColor ?? colors.outlineVariant;
    final resolvedDot = dotColor ?? colors.success;
    final dotSize = spacing.s20; // 20dp dot

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
                      context,
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

  Widget _buildDot(
    BuildContext context,
    CKTimelineEvent event,
    Color defaultColor,
    double size,
  ) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;

    final color =
        event.dotColor ??
        (event.status == StepStatus.rejected ? colors.error : defaultColor);

    if (event.icon != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: SizedBox(
            width: size * 0.75,
            height: size * 0.75,
            child: FittedBox(fit: BoxFit.contain, child: event.icon),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: event.status == StepStatus.completed
          ? Center(
              child: Icon(Icons.check, size: size * 0.75, color: Colors.white),
            )
          : event.status == StepStatus.rejected
          ? Center(
              child: Icon(Icons.close, size: size * 0.75, color: Colors.white),
            )
          : null,
    );
  }
}

/// Deprecated: Use [CKTimeline] instead.
@Deprecated('Use CKTimeline instead')
typedef ckcoretimeline = CKTimeline;
