import 'package:flutter/material.dart';
import 'package:ckcoreui/src/foundation/foundation.dart';

import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/components/component_enums.dart';

/// App bar used across the design system.
///
/// The default appearance uses the surface background. Provides consistent spacing,
/// typography and colors for app headers.
///
/// Use named constructors for alternative styles:
/// ```dart
/// CKAppBar(title: Text('Home'))          // surface (default)
/// CKAppBar.primary(title: Text('Home'))  // brand color
/// CKAppBar.dark(title: Text('Home'))     // dark background
/// ```
class CKAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Surface style app bar (default, neutral appearance).
  const CKAppBar({
    this.title,
    this.leading,
    this.trailing = const [],
    this.style = AppBarStyle.surface,
    this.largeTitle = false,
    super.key,
  });

  /// Primary style app bar (brand color background).
  const CKAppBar.primary({
    this.title,
    this.leading,
    this.trailing = const [],
    this.largeTitle = false,
    super.key,
  }) : style = AppBarStyle.primary;

  /// Surface style app bar (surface color background).
  const CKAppBar.surface({
    this.title,
    this.leading,
    this.trailing = const [],
    this.largeTitle = false,
    super.key,
  }) : style = AppBarStyle.surface;

  /// Dark style app bar (dark background).
  const CKAppBar.dark({
    this.title,
    this.leading,
    this.trailing = const [],
    this.largeTitle = false,
    super.key,
  }) : style = AppBarStyle.dark;

  /// Transparent style app bar (no background).
  const CKAppBar.transparent({
    this.title,
    this.leading,
    this.trailing = const [],
    this.largeTitle = false,
    super.key,
  }) : style = AppBarStyle.transparent;
  final Widget? title;
  final Widget? leading;
  final List<Widget> trailing;
  final AppBarStyle style;
  final bool largeTitle;

  @override
  Size get preferredSize => Size.fromHeight(
    largeTitle ? const ckcoreSpacing().s80 : const ckcoreSpacing().x3l,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final s = theme.spacing;
    final c = theme.colors;
    final t = theme.typography;

    final (bg, fg) = switch (style) {
      AppBarStyle.primary => (c.primary, c.onPrimary),
      AppBarStyle.surface => (c.surface, c.onSurface),
      AppBarStyle.dark => (c.inverseSurface, c.onInverseSurface),
      AppBarStyle.transparent => (Colors.transparent, c.onSurface),
    };

    final titleStyle = (largeTitle ? t.displaySm : t.labelLg).copyWith(
      color: fg,
      overflow: TextOverflow.ellipsis,
    );

    return Container(
      color: bg,
      height: preferredSize.height,
      child: IconTheme(
        data: IconThemeData(color: fg, size: s.lg),
        child: DefaultTextStyle(
          style: t.labelLg.copyWith(color: fg),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s.sm),
            child: Row(
              children: [
                if (leading != null) leading!,
                if (title != null)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: s.xs),
                      child: DefaultTextStyle(style: titleStyle, child: title!),
                    ),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
                ...trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Backwards-compatible alias for the old `CkgocAppBar` widget name.
typedef CkgocAppBar = CKAppBar;
