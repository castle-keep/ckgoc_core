import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ckcore_docs_app/docs_navigation.dart';

const _expandedWidth = 272.0;
const _collapsedWidth = 72.0;

/// Below this window width the sidebar collapses to an icon rail.
const _autoCollapseWidth = 960.0;

/// One page in the docs.
class DocsNavItem {
  const DocsNavItem({
    required this.title,
    required this.route,
    required this.icon,
    this.keywords = '',
  });
  final String title;
  final String route;
  final IconData icon;

  /// Extra search terms (component names that live on this page).
  final String keywords;

  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return title.toLowerCase().contains(q) ||
        keywords.toLowerCase().contains(q);
  }
}

class DocsNavGroup {
  const DocsNavGroup(this.title, this.items);
  final String title;
  final List<DocsNavItem> items;
}

const docsNavGroups = <DocsNavGroup>[
  DocsNavGroup('Start', [
    DocsNavItem(
      title: 'Get Started',
      route: '/',
      icon: Icons.rocket_launch_outlined,
      keywords: 'install setup quick start tutorial',
    ),
    DocsNavItem(
      title: 'Overview',
      route: '/overview',
      icon: Icons.home_outlined,
      keywords: 'coverage index',
    ),
    DocsNavItem(
      title: 'AI Tools',
      route: '/ai-tools',
      icon: Icons.auto_awesome_outlined,
      keywords: 'mcp skills copilot claude cursor assistant',
    ),
  ]),
  DocsNavGroup('Foundations', [
    DocsNavItem(
      title: 'Foundation',
      route: '/foundation',
      icon: Icons.foundation_outlined,
      keywords:
          'tokens colors typography spacing radius elevation shadows motion opacity breakpoints',
    ),
    DocsNavItem(
      title: 'Themes',
      route: '/themes',
      icon: Icons.palette_outlined,
      keywords: 'brand dark light mode resolver castlekeep skygo',
    ),
    DocsNavItem(
      title: 'Brand Icons',
      route: '/brand-icons',
      icon: Icons.image_outlined,
      keywords: 'logo logos assets',
    ),
    DocsNavItem(
      title: 'Enums',
      route: '/enums',
      icon: Icons.list_alt_outlined,
      keywords: 'variant size status',
    ),
  ]),
  DocsNavGroup('Components', [
    DocsNavItem(
      title: 'Buttons',
      route: '/buttons',
      icon: Icons.smart_button_outlined,
      keywords: 'button icon button fab hover loading',
    ),
    DocsNavItem(
      title: 'Inputs',
      route: '/inputs',
      icon: Icons.keyboard_outlined,
      keywords:
          'text field password search dropdown number stepper checkbox radio switch otp date time picker',
    ),
    DocsNavItem(
      title: 'Display',
      route: '/display',
      icon: Icons.slideshow_outlined,
      keywords:
          'accordion avatar badge card chip container divider list tile stepper timeline',
    ),
    DocsNavItem(
      title: 'Feedback',
      route: '/feedback',
      icon: Icons.info_outline,
      keywords:
          'alert loader progress slider snackbar toast skeleton empty error loading state',
    ),
    DocsNavItem(
      title: 'Navigation',
      route: '/navigation',
      icon: Icons.route_outlined,
      keywords:
          'app bar tabs bottom navigation breadcrumb drawer rail side nav',
    ),
    DocsNavItem(
      title: 'Overlays',
      route: '/overlays',
      icon: Icons.layers_outlined,
      keywords: 'dialog bottom sheet menu popover tooltip modal',
    ),
    DocsNavItem(
      title: 'Data Table',
      route: '/data-table',
      icon: Icons.table_chart_outlined,
      keywords: 'table sort filter pagination selection editable cells',
    ),
    DocsNavItem(
      title: 'Animation',
      route: '/animate',
      icon: Icons.animation_outlined,
      keywords: 'animate ckanimate stagger fade slide scale motion',
    ),
  ]),
  DocsNavGroup('App structure', [
    DocsNavItem(
      title: 'App',
      route: '/app',
      icon: Icons.web_asset_outlined,
      keywords: 'ckapp wrapper material app',
    ),
    DocsNavItem(
      title: 'Router',
      route: '/router',
      icon: Icons.router_outlined,
      keywords: 'navigator go_router delegate',
    ),
    DocsNavItem(
      title: 'Screen Layout',
      route: '/screen-layout',
      icon: Icons.view_sidebar_outlined,
      keywords: 'ckscreenlayout side nav shell responsive',
    ),
  ]),
];

/// Focus node of the sidebar search field. Shared so a keyboard shortcut can
/// focus it from anywhere in the docs.
final docsSearchFocus = FocusNode(debugLabel: 'docs search');

/// Left navigation of the docs app.
///
/// Grouped, searchable, and collapsible to an icon rail (automatically on
/// narrow windows). Lives above the pages so its scroll position, search text
/// and collapsed state survive navigation.
class DocsSidebar extends StatefulWidget {
  const DocsSidebar({super.key});

  @override
  State<DocsSidebar> createState() => _DocsSidebarState();
}

class _DocsSidebarState extends State<DocsSidebar> {
  final _search = TextEditingController();
  final _scroll = ScrollController();
  bool _userCollapsed = false;

  @override
  void dispose() {
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _open(String route) {
    currentRoute.value = route;
    FocusManager.instance.primaryFocus?.unfocus();
  }

  List<DocsNavItem> get _matches => [
        for (final g in docsNavGroups)
          for (final i in g.items)
            if (i.matches(_search.text)) i,
      ];

  void _expandAndSearch() {
    setState(() => _userCollapsed = false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => docsSearchFocus.requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final autoCollapsed = MediaQuery.sizeOf(context).width < _autoCollapseWidth;
    final collapsed = _userCollapsed || autoCollapsed;

    // The sidebar sits beside the pages rather than inside one, so it needs
    // its own Material for text fields and ink.
    return Material(
      color: colors.surface,
      child: AnimatedContainer(
        duration: theme.motion.normal,
        curve: Curves.easeOutCubic,
        width: collapsed ? _collapsedWidth : _expandedWidth,
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(right: BorderSide(color: colors.outline)),
        ),
        child: ClipRect(
          // Lay the content out at its final width and let the animating
          // container clip it, so nothing overflows mid-transition.
          child: OverflowBox(
            alignment: Alignment.topLeft,
            minWidth: collapsed ? _collapsedWidth : _expandedWidth,
            maxWidth: collapsed ? _collapsedWidth : _expandedWidth,
            child: Column(
              children: [
                if (collapsed)
                  _CollapsedSearchButton(onTap: _expandAndSearch)
                else
                  _SearchField(
                    controller: _search,
                    onChanged: (_) => setState(() {}),
                    onSubmitted: () {
                      final first = _matches;
                      if (first.isNotEmpty) _open(first.first.route);
                    },
                    onClear: () => setState(_search.clear),
                  ),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: currentRoute,
                    builder: (context, route, _) => Scrollbar(
                      controller: _scroll,
                      child: ListView(
                        controller: _scroll,
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.sm,
                          vertical: theme.spacing.xs,
                        ),
                        children: _buildGroups(theme, route, collapsed),
                      ),
                    ),
                  ),
                ),
                if (!autoCollapsed)
                  _CollapseToggle(
                    collapsed: _userCollapsed,
                    onTap: () =>
                        setState(() => _userCollapsed = !_userCollapsed),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGroups(
    CkcoreuiThemeData theme,
    String route,
    bool collapsed,
  ) {
    final widgets = <Widget>[];
    final searching = _search.text.trim().isNotEmpty;

    for (final group in docsNavGroups) {
      final items = [
        for (final i in group.items)
          if (i.matches(_search.text)) i,
      ];
      if (items.isEmpty) continue;

      if (collapsed) {
        if (widgets.isNotEmpty) {
          widgets.add(Divider(
            height: theme.spacing.md * 2,
            color: theme.colors.outlineVariant,
          ));
        }
      } else {
        widgets.add(Padding(
          padding: EdgeInsets.fromLTRB(
            theme.spacing.s12,
            widgets.isEmpty ? theme.spacing.xs : theme.spacing.md,
            theme.spacing.s12,
            theme.spacing.xs,
          ),
          child: Text(
            group.title.toUpperCase(),
            style: theme.typography.labelSm.copyWith(
              color: theme.colors.onSurfaceVariant,
              letterSpacing: 0.8,
            ),
          ),
        ));
      }

      for (final item in items) {
        widgets.add(_NavTile(
          item: item,
          selected: item.route == route,
          collapsed: collapsed,
          onTap: () => _open(item.route),
        ));
      }
    }

    if (widgets.isEmpty) {
      widgets.add(Padding(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Text(
          searching ? 'No pages match "${_search.text.trim()}"' : '',
          style: theme.typography.textSm.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ));
    }
    return widgets;
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final isMac = Theme.of(context).platform == TargetPlatform.macOS;

    return Padding(
      padding: EdgeInsets.all(spacing.sm),
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () {
            if (controller.text.isNotEmpty) onClear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
        },
        child: TextField(
          controller: controller,
          focusNode: docsSearchFocus,
          onChanged: onChanged,
          onSubmitted: (_) => onSubmitted(),
          textInputAction: TextInputAction.go,
          style: theme.typography.textMd,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search docs',
            hintStyle: theme.typography.textMd.copyWith(
              color: colors.onSurfaceVariant,
            ),
            prefixIcon:
                Icon(Icons.search, size: 18, color: colors.onSurfaceVariant),
            prefixIconConstraints: const BoxConstraints(minWidth: 36),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (_, value, __) => value.text.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: spacing.sm),
                      child: Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Text(
                          isMac ? '⌘K' : 'Ctrl K',
                          style: theme.typography.labelSm.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      tooltip: 'Clear search',
                      icon: const Icon(Icons.close, size: 16),
                      onPressed: onClear,
                    ),
            ),
            filled: true,
            fillColor: colors.surfaceVariant,
            contentPadding: EdgeInsets.symmetric(vertical: spacing.s12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radius.md),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(theme.radius.md),
              borderSide: BorderSide(color: colors.primary, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}

class _CollapsedSearchButton extends StatelessWidget {
  const _CollapsedSearchButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Padding(
      padding: EdgeInsets.all(theme.spacing.sm),
      child: Tooltip(
        message: 'Search docs',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.radius.md),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: theme.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(theme.radius.md),
            ),
            child: Icon(Icons.search,
                size: 20, color: theme.colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

class _CollapseToggle extends StatelessWidget {
  const _CollapseToggle({required this.collapsed, required this.onTap});
  final bool collapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      padding: EdgeInsets.all(theme.spacing.sm),
      child: Tooltip(
        message: collapsed ? 'Expand sidebar' : 'Collapse sidebar',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.radius.md),
          child: SizedBox(
            height: 36,
            child: Row(
              mainAxisAlignment: collapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                SizedBox(width: collapsed ? 0 : theme.spacing.s12),
                Icon(
                  collapsed
                      ? Icons.keyboard_double_arrow_right
                      : Icons.keyboard_double_arrow_left,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
                if (!collapsed) ...[
                  SizedBox(width: theme.spacing.sm),
                  Text(
                    'Collapse',
                    style: theme.typography.textSm.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatefulWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.collapsed,
    required this.onTap,
  });

  final DocsNavItem item;
  final bool selected;
  final bool collapsed;
  final VoidCallback onTap;

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final selected = widget.selected;

    final background = selected
        ? colors.primary.withValues(alpha: 0.10)
        : _hovered
            ? colors.surfaceVariant
            : Colors.transparent;
    final iconColor = selected ? colors.primary : colors.onSurfaceVariant;
    final radius = BorderRadius.circular(theme.radius.md);

    final row = Row(
      mainAxisAlignment:
          widget.collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        // Left accent bar for the active page.
        AnimatedContainer(
          duration: theme.motion.normal,
          curve: Curves.easeOutCubic,
          width: 3,
          height: selected ? 20 : 0,
          margin:
              EdgeInsets.only(right: widget.collapsed ? 0 : spacing.s12 - 3),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Icon(widget.item.icon, size: 20, color: iconColor),
        if (!widget.collapsed) ...[
          SizedBox(width: spacing.s12),
          Expanded(
            child: Text(
              widget.item.title,
              overflow: TextOverflow.ellipsis,
              style: theme.typography.textMd.copyWith(
                color: selected ? colors.onSurface : colors.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );

    Widget tile = Semantics(
      button: true,
      selected: selected,
      label: widget.item.title,
      excludeSemantics: true,
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: radius,
              child: AnimatedContainer(
                duration: theme.motion.fast,
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.collapsed ? 0 : spacing.xs,
                ),
                decoration:
                    BoxDecoration(color: background, borderRadius: radius),
                child: row,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.collapsed) {
      tile = Tooltip(
        message: widget.item.title,
        preferBelow: false,
        waitDuration: const Duration(milliseconds: 300),
        child: tile,
      );
    }
    return tile;
  }
}
