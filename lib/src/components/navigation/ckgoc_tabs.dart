import 'package:ckgoc_core/src/components/component_enums.dart';
import 'package:ckgoc_core/src/themes/themes.dart';
import 'package:flutter/material.dart';

Widget _tabLabel(CkgocTab tab, Color fg, CkgocThemeData theme) {
  final s = theme.spacing;
  final t = theme.typography;
  final c = theme.colors;
  final r = theme.radius;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (tab.icon != null) ...[
        Icon(tab.icon, size: s.md, color: fg),
        SizedBox(width: s.xs),
      ],
      Text(tab.label, style: t.labelMd.copyWith(color: fg)),
      if (tab.badge != null) ...[
        SizedBox(width: s.xs),
        Container(
          padding: EdgeInsets.symmetric(horizontal: s.xs, vertical: s.xxs),
          decoration: BoxDecoration(
            color: c.error,
            borderRadius: BorderRadius.circular(r.full),
          ),
          child: Text(
            '${tab.badge}',
            style: t.labelSm.copyWith(color: c.onError),
          ),
        ),
      ],
    ],
  );
}

/// Tabs component supporting line, pill and card variants.
class CkgocTabs extends StatefulWidget {
  const CkgocTabs({
    required this.tabs,
    this.variant = TabVariant.line,
    this.scrollable = false,
    this.initialIndex = 0,
    this.onTabChanged,
    super.key,
  });
  final List<CkgocTab> tabs;
  final TabVariant variant;
  final bool scrollable;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<CkgocTabs> createState() => _CompanyTabsState();
}

class _CompanyTabsState extends State<CkgocTabs> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  void _select(int i) {
    setState(() => _index = i);
    widget.onTabChanged?.call(i);
  }

  @override
  Widget build(BuildContext context) {
    final bar = switch (widget.variant) {
      TabVariant.line => _LineBar(
        tabs: widget.tabs,
        index: _index,
        onTap: _select,
        scrollable: widget.scrollable,
      ),
      TabVariant.pill => _PillBar(
        tabs: widget.tabs,
        index: _index,
        onTap: _select,
        scrollable: widget.scrollable,
      ),
      TabVariant.card => _CardBar(
        tabs: widget.tabs,
        index: _index,
        onTap: _select,
        scrollable: widget.scrollable,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [bar, widget.tabs[_index].content],
    );
  }
}

class _LineBar extends StatelessWidget {
  const _LineBar({
    required this.tabs,
    required this.index,
    required this.onTap,
    required this.scrollable,
  });
  final List<CkgocTab> tabs;
  final int index;
  final ValueChanged<int> onTap;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final m = theme.motion;

    final items = List.generate(tabs.length, (i) {
      final active = i == index;
      final fg = active ? c.primary : c.onSurfaceVariant;
      Widget item = InkWell(
        onTap: () => onTap(i),
        child: AnimatedContainer(
          duration: m.fast,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? c.primary : Colors.transparent,
                width: s.xxs,
              ),
            ),
          ),
          child: _tabLabel(tabs[i], fg, theme),
        ),
      );
      return item;
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        // decide whether to stretch tabs or allow horizontal scrolling
        final perTabWidth =
            constraints.maxWidth / (tabs.isEmpty ? 1 : tabs.length);
        final shouldStretch = !scrollable && perTabWidth >= s.x5l;
        final row = shouldStretch
            ? Row(children: items.map((w) => Expanded(child: w)).toList())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: items),
              );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            row,
            Container(height: s.xxs / 2, color: c.outline),
          ],
        );
      },
    );
  }
}

class _PillBar extends StatelessWidget {
  const _PillBar({
    required this.tabs,
    required this.index,
    required this.onTap,
    required this.scrollable,
  });
  final List<CkgocTab> tabs;
  final int index;
  final ValueChanged<int> onTap;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final r = theme.radius;
    final m = theme.motion;
    final sh = theme.shadows;

    final items = List.generate(tabs.length, (i) {
      final active = i == index;
      final fg = active ? c.primary : c.onSurfaceVariant;
      Widget item = GestureDetector(
        onTap: () => onTap(i),
        child: AnimatedContainer(
          duration: m.fast,
          curve: m.decelerate,
          padding: EdgeInsets.symmetric(horizontal: s.s12, vertical: s.sm),
          decoration: BoxDecoration(
            color: active ? c.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(r.md),
            boxShadow: active ? sh.sm : null,
          ),
          child: Center(child: _tabLabel(tabs[i], fg, theme)),
        ),
      );
      return item;
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final perTabWidth =
            constraints.maxWidth / (tabs.isEmpty ? 1 : tabs.length);
        final shouldStretch = !scrollable && perTabWidth >= s.x5l;
        final content = shouldStretch
            ? Row(children: items.map((w) => Expanded(child: w)).toList())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: items),
              );

        return Container(
          padding: EdgeInsets.all(s.xxs),
          decoration: BoxDecoration(
            color: c.surfaceVariant,
            borderRadius: BorderRadius.circular(r.lg),
          ),
          child: content,
        );
      },
    );
  }
}

class _CardBar extends StatelessWidget {
  const _CardBar({
    required this.tabs,
    required this.index,
    required this.onTap,
    required this.scrollable,
  });
  final List<CkgocTab> tabs;
  final int index;
  final ValueChanged<int> onTap;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final r = theme.radius;
    final m = theme.motion;

    final items = List.generate(tabs.length, (i) {
      final active = i == index;
      final fg = active ? c.primary : c.onSurfaceVariant;
      final br = BorderRadius.only(
        topLeft: Radius.circular(r.base),
        topRight: Radius.circular(r.base),
      );
      Widget item = InkWell(
        onTap: () => onTap(i),
        borderRadius: br,
        child: AnimatedContainer(
          duration: m.fast,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: s.md, vertical: s.sm),
          decoration: BoxDecoration(
            color: active ? c.surface : c.surfaceVariant,
            borderRadius: br,
            border: active
                ? Border(
                    top: BorderSide(color: c.outline, width: s.xxs / 2),
                    left: BorderSide(color: c.outline, width: s.xxs / 2),
                    right: BorderSide(color: c.outline, width: s.xxs / 2),
                  )
                : null,
          ),
          child: _tabLabel(tabs[i], fg, theme),
        ),
      );
      return item;
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final perTabWidth =
            constraints.maxWidth / (tabs.isEmpty ? 1 : tabs.length);
        final shouldStretch = !scrollable && perTabWidth >= s.x5l;
        final content = shouldStretch
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.map((w) => Expanded(child: w)).toList(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: items,
                ),
              );

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: c.outline, width: s.xxs / 2),
            ),
          ),
          child: content,
        );
      },
    );
  }
}
