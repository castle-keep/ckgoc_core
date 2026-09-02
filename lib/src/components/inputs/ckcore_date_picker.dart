import 'dart:math' as math;

import 'package:ckcoreui/src/components/component_enums.dart';
import 'package:ckcoreui/src/components/inputs/ckcore_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';

// Date picker trigger + field.
/// Date picker trigger and display field.
///
/// Presents a tappable field that invokes a date picker and reports the
/// selected date via [onChanged]. If [label] is provided it will be used as
/// an accessible label for the control.
///
/// Supports three selection modes:
/// - [DatePickerMode.month]: Select month and year only
/// - [DatePickerMode.date]: Select month, day, and year
/// - [DatePickerMode.fullDate]: Select full date
/// - [DatePickerMode.range]: Select a date range
class CKDatePicker extends StatefulWidget {
  const CKDatePicker({
    this.value,
    this.range,
    this.onChanged,
    this.onRangeChanged,
    this.label,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.isRequired = false,
    this.mode = CKDatePickerMode.fullDate,
    this.helperText,
    this.errorText,
    this.successText,
    this.enabled = true,
    this.focusNode,
    super.key,
  });

  final DateTime? value;
  final DateTimeRange? range;
  final ValueChanged<DateTime?>? onChanged;
  final ValueChanged<DateTimeRange?>? onRangeChanged;
  final String? label;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(DateTime?)? validator;
  final bool isRequired;
  final CKDatePickerMode mode;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final bool enabled;
  final FocusNode? focusNode;

  @override
  State<CKDatePicker> createState() => _CKDatePickerState();
}

class _CKDatePickerState extends State<CKDatePicker> {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _showAbove = false;
  double _fieldWidth = 320;
  double _fieldHeight = 40;
  String? _validationError;
  late DateTime _displayedMonth;
  DateTime? _internalValue;
  DateTimeRange? _internalRange;

  DateTimeRange? get _effectiveRange => widget.range ?? _internalRange;

  DateTime? get _effectiveValue => widget.value ?? _internalValue;
  bool _showMonthMenu = false;
  bool _showYearMenu = false;

  @override
  void initState() {
    super.initState();
    _internalValue = widget.value;
    _internalRange = widget.range;
    _displayedMonth = _internalValue ?? DateTime.now();
  }

  @override
  void didUpdateWidget(CKDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep internal value in sync when controlled externally
    if (widget.value != oldWidget.value) {
      _internalValue = widget.value;
      _displayedMonth = _internalValue ?? _displayedMonth;
      _overlayEntry?.markNeedsBuild();
    }
    if (widget.range != oldWidget.range) {
      _internalRange = widget.range;
      _displayedMonth = _internalRange?.start ?? _displayedMonth;
      _overlayEntry?.markNeedsBuild();
    }
    if (!widget.enabled && _isOpen) {
      _closeCalendar();
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _handleDateChange(DateTime? date) {
    if (widget.mode == CKDatePickerMode.range) {
      // route to range selection handler
      _handleRangeSelection(date!);
      return;
    }

    setState(() {
      if (date == null) {
        if (widget.isRequired) {
          _validationError = 'This field is required';
        } else {
          _validationError = null;
        }
      } else if (widget.validator != null) {
        _validationError = widget.validator!(date);
      } else {
        _validationError = null;
      }
    });
    // Update internal value so the picker shows immediately even if parent
    // does not re-render with a new `value` prop.
    _internalValue = date;
    widget.onChanged?.call(date);
    _closeCalendar();
  }

  void _handleRangeSelection(DateTime date) {
    setState(() {
      // simple required handling: if null not allowed - ignored here
    });

    final current = _effectiveRange;
    if (current == null) {
      _internalRange = DateTimeRange(start: date, end: date);
      // don't close yet; wait for end selection
      _overlayEntry?.markNeedsBuild();
      return;
    }

    // If start == end we are choosing the end; finalize range
    if (current.start == current.end) {
      DateTimeRange newRange;
      if (date.isBefore(current.start)) {
        newRange = DateTimeRange(start: date, end: current.start);
      } else {
        newRange = DateTimeRange(start: current.start, end: date);
      }
      _internalRange = newRange;
      widget.onRangeChanged?.call(newRange);
      _closeCalendar();
      return;
    }

    // Otherwise start a new selection
    _internalRange = DateTimeRange(start: date, end: date);
    _overlayEntry?.markNeedsBuild();
  }

  void _toggleCalendar() {
    if (_isOpen) {
      _closeCalendar();
    } else {
      _openCalendar();
    }
  }

  void _openCalendar() {
    if (!widget.enabled) return;

    final overlay = Overlay.of(context);
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final theme = context.ckcoreTheme;
    final mediaQuery = MediaQuery.of(context);
    final spacing = theme.spacing;
    final fieldOffset = renderBox.localToGlobal(Offset.zero);
    final fieldSize = renderBox.size;

    const calendarMinHeight = 280.0;

    final availableAbove = math.max(
      0.0,
      fieldOffset.dy - mediaQuery.padding.top - spacing.xs,
    );
    final availableBelow = math.max(
      0.0,
      mediaQuery.size.height -
          mediaQuery.viewInsets.bottom -
          mediaQuery.padding.bottom -
          fieldOffset.dy -
          fieldSize.height -
          spacing.xs,
    );

    var showAbove = availableBelow < calendarMinHeight && availableAbove > 0;

    setState(() {
      _isOpen = true;
      _showAbove = showAbove;
      _fieldWidth = fieldSize.width;
      _fieldHeight = fieldSize.height;
      _displayedMonth = _effectiveValue ?? DateTime.now();
    });

    _overlayEntry = OverlayEntry(builder: (_) => _buildCalendarOverlay());
    overlay.insert(_overlayEntry!);
  }

  void _closeCalendar() {
    if (_isOpen) {
      setState(() => _isOpen = false);
    }
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  DateTime _adjustDateByMode(DateTime date) {
    switch (widget.mode) {
      case CKDatePickerMode.month:
        return DateTime(date.year, date.month, 1);
      case CKDatePickerMode.range:
        return DateTime(date.year, date.month, date.day);
      case CKDatePickerMode.date:
      case CKDatePickerMode.fullDate:
        return DateTime(date.year, date.month, date.day);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    switch (widget.mode) {
      case CKDatePickerMode.month:
        return _monthYearFormat(date);
      case CKDatePickerMode.range:
        return _fullDateFormat(date);
      case CKDatePickerMode.date:
      case CKDatePickerMode.fullDate:
        return _fullDateFormat(date);
    }
  }

  String _formatRange(DateTimeRange range) {
    return '${_fullDateFormat(range.start)} — ${_fullDateFormat(range.end)}';
  }

  String _monthYearFormat(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _fullDateFormat(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildCalendarOverlay() {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;

    const calendarHeight = 340.0;

    final offset = Offset(
      0,
      _showAbove ? -calendarHeight - spacing.xs : _fieldHeight + spacing.xs,
    );

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeCalendar,
          ),
        ),
        CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: _fieldWidth > 320 ? _fieldWidth : 320,
              height: calendarHeight,

              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(radius.base),
                border: Border.all(color: colors.outline),
                boxShadow: [
                  BoxShadow(
                    color: colors.onSurface.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Stack(
                    children: [
                      _buildCalendarContent(),
                      if (_showMonthMenu)
                        Positioned(
                          top: spacing.md + 36,
                          left: 24,
                          child: _buildMonthMenu(),
                        ),
                      if (_showYearMenu)
                        Positioned(
                          top: spacing.md + 36,
                          right: 24,
                          child: _buildYearMenu(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarContent() {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;

    return Column(
      children: [
        // Header: Month/Year navigation with dropdowns
        Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month - 1,
                    );
                  });
                  _overlayEntry?.markNeedsBuild();
                },
                child: Icon(
                  LucideIcons.chevronLeft,
                  color: colors.onSurface,
                  size: 20,
                ),
              ),

              // Month and year dropdowns
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Month button (shows in-overlay menu)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showMonthMenu = !_showMonthMenu;
                        _showYearMenu = false;
                      });
                      _overlayEntry?.markNeedsBuild();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.s12,
                        vertical: spacing.xs,
                      ),
                      // decoration: BoxDecoration(
                      //   color: colors.surface,
                      //   borderRadius: BorderRadius.circular(radius.base),
                      //   border: Border.all(color: colors.outline),
                      // ),
                      child: Row(
                        children: [
                          Text(
                            _monthYearFormat(_displayedMonth).split(' ').first,
                            style: typography.textSm.copyWith(
                              color: colors.onSurface,
                            ),
                          ),
                          SizedBox(width: spacing.xs),
                          Icon(
                            LucideIcons.chevronDown,
                            size: 14,
                            color: colors.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spacing.sm),
                  // Year button (shows in-overlay menu)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showYearMenu = !_showYearMenu;
                        _showMonthMenu = false;
                      });
                      _overlayEntry?.markNeedsBuild();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.s12,
                        vertical: spacing.xs,
                      ),
                      // decoration: BoxDecoration(
                      //   color: colors.transparent,
                      //   borderRadius: BorderRadius.circular(radius.base),
                      //   border: Border.all(color: colors.outline),
                      // ),
                      child: Row(
                        children: [
                          Text(
                            '${_displayedMonth.year}',
                            style: typography.textSm.copyWith(
                              color: colors.onSurface,
                            ),
                          ),
                          SizedBox(width: spacing.xs),
                          Icon(
                            LucideIcons.chevronDown,
                            size: 14,
                            color: colors.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month + 1,
                    );
                  });
                  _overlayEntry?.markNeedsBuild();
                },
                child: Icon(
                  LucideIcons.chevronRight,
                  color: colors.onSurface,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        // Weekday headers
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map(
                  (day) => SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        day,
                        style: typography.labelSm.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // Calendar grid
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing.md),
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: spacing.xs,
              crossAxisSpacing: spacing.xs,
              children: _buildCalendarDays(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCalendarDays() {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final typography = theme.typography;

    final firstDay = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDay = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + 1,
      0,
    );
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday % 7; // 0 = Sunday

    final firstDate = widget.firstDate;
    final lastDate = widget.lastDate;

    final days = <Widget>[];

    // Empty cells before first day
    for (int i = 0; i < firstWeekday; i++) {
      days.add(const SizedBox());
    }

    // Days of month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_displayedMonth.year, _displayedMonth.month, day);
      final isToday =
          date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;
      final isDisabled =
          (firstDate != null && date.isBefore(firstDate)) ||
          (lastDate != null && date.isAfter(lastDate));

      // range selection flags
      final range = _effectiveRange;
      final isRangeStart =
          range != null &&
          date.year == range.start.year &&
          date.month == range.start.month &&
          date.day == range.start.day;
      final isRangeEnd =
          range != null &&
          date.year == range.end.year &&
          date.month == range.end.month &&
          date.day == range.end.day;
      final isInRange =
          range != null &&
          (date.isAfter(range.start) && date.isBefore(range.end));

      // single selection
      final isSelected =
          _effectiveValue != null &&
          date.year == _effectiveValue!.year &&
          date.month == _effectiveValue!.month &&
          date.day == _effectiveValue!.day;

      days.add(
        GestureDetector(
          onTap: isDisabled
              ? null
              : () {
                  if (widget.mode == CKDatePickerMode.range) {
                    _handleRangeSelection(date);
                  } else {
                    final result = _adjustDateByMode(date);
                    _handleDateChange(result);
                  }
                },
          child: Container(
            decoration: BoxDecoration(
              color: (isSelected || isRangeStart || isRangeEnd)
                  ? colors.primary
                  : (isInRange ? colors.primary.withValues(alpha: 0.12) : null),
              border: isToday && !(isSelected || isRangeStart || isRangeEnd)
                  ? Border.all(color: colors.primary, width: 1)
                  : null,
              shape: (isInRange) ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isInRange ? BorderRadius.circular(6) : null,
            ),
            child: Center(
              child: Text(
                '$day',
                style: typography.textSm.copyWith(
                  color: (isSelected || isRangeStart || isRangeEnd)
                      ? colors.onPrimary
                      : isDisabled
                      ? colors.onSurfaceVariant
                      : colors.onSurface,
                  fontWeight: (isSelected || isRangeStart || isRangeEnd)
                      ? FontWeight.w600
                      : null,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return days;
  }

  Widget _buildMonthMenu() {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final typography = theme.typography;

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Material(
      elevation: 4,
      color: colors.surface,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 160, maxHeight: 240),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(12, (i) {
              final m = i + 1;
              return InkWell(
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(_displayedMonth.year, m);
                    _showMonthMenu = false;
                  });
                  _overlayEntry?.markNeedsBuild();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Text(
                    months[i],
                    style: typography.textSm.copyWith(color: colors.onSurface),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildYearMenu() {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final typography = theme.typography;

    final start = widget.firstDate?.year ?? DateTime.now().year - 100;
    final end = widget.lastDate?.year ?? DateTime.now().year + 20;

    return Material(
      elevation: 4,
      color: colors.surface,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 120, maxHeight: 240),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(end - start + 1, (i) {
              final y = start + i;
              return InkWell(
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(y, _displayedMonth.month);
                    _showYearMenu = false;
                  });
                  _overlayEntry?.markNeedsBuild();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Text(
                    '$y',
                    style: typography.textSm.copyWith(color: colors.onSurface),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  String get _displayValue => widget.mode == CKDatePickerMode.range
      ? (_effectiveRange != null ? _formatRange(_effectiveRange!) : '')
      : (_effectiveValue != null ? _formatDate(_effectiveValue) : '');

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CKTextField(
        key: _fieldKey,
        value: _displayValue,
        readOnly: true,
        onTap: _toggleCalendar,
        label: widget.label,
        hint: widget.mode == CKDatePickerMode.range
            ? 'Pick a range'
            : 'Pick a date',
        helperText: widget.helperText,
        errorText: widget.errorText ?? _validationError,
        successText: widget.successText,
        isRequired: widget.isRequired,
        enabled: widget.enabled,
        trailing: Icon(LucideIcons.calendar, size: 20),
      ),
    );
  }
}

/// Deprecated: Use [CKDatePicker] instead.
@Deprecated('Use CKDatePicker instead')
typedef ckcoredatePicker = CKDatePicker;
