// Ignore deprecated member uses introduced by newer Flutter SDKs (textScaleFactor)
// We keep these to preserve backward-compatible behavior across Flutter versions.
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ckcoreui/src/themes/ckcore_theme.dart';
import 'package:ckcoreui/src/themes/ckcore_theme_data.dart';

/// Extension methods on [Text] for applying design system text styles.
extension TextStyleExtensions on Text {
  /// Wraps this text in a blockquote style with left border and padding.
  Widget get blockQuote {
    return Builder(
      builder: (context) {
        final theme = context.ckcoreTheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: theme.colors.primary, width: 4),
            ),
          ),
          child: DefaultTextStyle.merge(
            // ignore: prefer_const_constructors
            style: TextStyle(fontStyle: FontStyle.italic),
            child: this,
          ),
        );
      },
    );
  }

  // Internal: recreate this Text with fewer repeated constructor args.
  Text _recreateText({String? newData, TextStyle? newStyle}) {
    return Text(
      newData ?? data ?? '',
      key: key,
      style: newStyle ?? style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  // Typography Styles - Returns Widget to access theme context
  Widget _withTypography(TextStyle Function(CkcoreuiThemeData) getStyle) {
    return Builder(
      builder: (context) {
        final newStyle = getStyle(context.ckcoreTheme);
        return Text(
          data ?? '',
          key: key,
          style: (style ?? const TextStyle()).merge(newStyle),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );
      },
    );
  }

  // Typography Styles
  Widget get display2xl =>
      _withTypography((theme) => theme.typography.display2xl);

  Widget get displayXl =>
      _withTypography((theme) => theme.typography.displayXl);

  Widget get displayLg =>
      _withTypography((theme) => theme.typography.displayLg);

  Widget get displayMd =>
      _withTypography((theme) => theme.typography.displayMd);

  Widget get displaySm =>
      _withTypography((theme) => theme.typography.displaySm);

  Widget get textXl => _withTypography((theme) => theme.typography.textXl);

  Widget get textLg => _withTypography((theme) => theme.typography.textLg);

  Widget get textMd => _withTypography((theme) => theme.typography.textMd);

  Widget get textSm => _withTypography((theme) => theme.typography.textSm);

  Widget get textXs => _withTypography((theme) => theme.typography.textXs);

  Widget get labelXl => _withTypography((theme) => theme.typography.labelXl);

  Widget get labelLg => _withTypography((theme) => theme.typography.labelLg);

  Widget get labelMd => _withTypography((theme) => theme.typography.labelMd);

  Widget get labelSm => _withTypography((theme) => theme.typography.labelSm);

  Widget get codeMd => _withTypography((theme) => theme.typography.codeMd);

  // Semantic HTML Heading Shortcuts
  /// Applies h1 style (display2xl - 32px, Bold)
  Widget get h1 => _withTypography((theme) => theme.typography.display2xl);

  /// Applies h2 style (displayXl - 28px, Bold)
  Widget get h2 => _withTypography((theme) => theme.typography.displayXl);

  /// Applies h3 style (displayLg - 24px, Bold)
  Widget get h3 => _withTypography((theme) => theme.typography.displayLg);

  /// Applies h4 style (displayMd - 20px, Bold)
  Widget get h4 => _withTypography((theme) => theme.typography.displayMd);

  /// Applies h5 style (displaySm - 18px, Medium)
  Widget get h5 => _withTypography((theme) => theme.typography.displaySm);

  /// Applies h6 style (textXl - 20px, Regular)
  Widget get h6 => _withTypography((theme) => theme.typography.textXl);
  // Text Modifiers
  // NOTE: Modifiers (like `.bold`, `.italic`, `.lineThrough`) should be
  // applied before typography or color helpers because those return
  // a `Widget` (e.g. use `Text('Hi').bold.h1`, not `Text('Hi').h1.bold`).
  Text get bold => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.bold,
    ),
  );

  Text get italic => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      fontStyle: FontStyle.italic,
    ),
  );

  Text get underline => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.underline,
    ),
  );

  Text get lineThrough => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
    ),
  );

  Text get regular => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w400,
    ),
  );

  Text get medium => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w500,
    ),
  );

  Text get semibold => _recreateText(
    newStyle: (style ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w600,
    ),
  );

  Text get uppercase => _recreateText(newData: (data ?? '').toUpperCase());

  Text get lowercase => _recreateText(newData: (data ?? '').toLowerCase());

  // Color Styles - Returns Widget to access theme context
  Widget _withColor(Color Function(CkcoreuiThemeData) getColor) {
    return _withTypography((theme) => TextStyle(color: getColor(theme)));
  }

  // Public semantic color helpers (kept intentionally small).
  Widget get primary => _withColor((theme) => theme.colors.primary);
  Widget get secondary => _withColor((theme) => theme.colors.secondary);
  Widget get success => _withColor((theme) => theme.colors.success);
  Widget get warning => _withColor((theme) => theme.colors.warning);
  Widget get error => _withColor((theme) => theme.colors.error);
  Widget get info => _withColor((theme) => theme.colors.info);
  Widget get surface => _withColor((theme) => theme.colors.surface);
  Widget get onSurface => _withColor((theme) => theme.colors.onSurface);
  Widget get outline => _withColor((theme) => theme.colors.outline);
  Widget get muted => _withColor((theme) => theme.colors.muted);
}
