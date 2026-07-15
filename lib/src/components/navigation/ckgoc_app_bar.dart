import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/foundation/foundation.dart';

import 'package:ckgoc_core/src/themes/ckgoc_theme.dart';
import 'package:ckgoc_core/src/components/component_enums.dart';

/// App bar used across the design system.
///
/// Provides consistent spacing, typography and colors for app headers.
class CkgocAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CkgocAppBar({
    this.title,
    this.leading,
    this.trailing = const [],
    this.style = AppBarStyle.surface,
    this.largeTitle = false,
    super.key,
  });
  final Widget? title;
  final Widget? leading;
  final List<Widget> trailing;
  final AppBarStyle style;
  final bool largeTitle;

  @override
  Size get preferredSize => Size.fromHeight(
    largeTitle ? const CkgocSpacing().s80 : const CkgocSpacing().x3l,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
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
