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
  Text get bold => Text(
    data ?? '',
    key: key,
    style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.bold),
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

  Text get italic => Text(
    data ?? '',
    key: key,
    style: (style ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic),
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

  Text get underline => Text(
    data ?? '',
    key: key,
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.underline,
    ),
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

  Text get strikethrough => Text(
    data ?? '',
    key: key,
    style: (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
    ),
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

  Text get uppercase => Text(
    (data ?? '').toUpperCase(),
    key: key,
    style: style,
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

  Text get lowercase => Text(
    (data ?? '').toLowerCase(),
    key: key,
    style: style,
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

  // Color Styles - Returns Widget to access theme context
  Widget _withColor(Color Function(CkcoreuiThemeData) getColor) {
    return Builder(
      builder: (context) {
        final color = getColor(context.ckcoreTheme);
        return Text(
          data ?? '',
          key: key,
          style: (style ?? const TextStyle()).copyWith(color: color),
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

  // Primary Colors
  Widget get primary => _withColor((theme) => theme.colors.primary);

  Widget get primaryHover => _withColor((theme) => theme.colors.primaryHover);

  Widget get primaryActive => _withColor((theme) => theme.colors.primaryActive);

  Widget get primaryDisabled =>
      _withColor((theme) => theme.colors.primaryDisabled);

  Widget get onPrimary => _withColor((theme) => theme.colors.onPrimary);

  // Secondary Colors
  Widget get secondary => _withColor((theme) => theme.colors.secondary);

  Widget get secondaryHover =>
      _withColor((theme) => theme.colors.secondaryHover);

  Widget get secondaryActive =>
      _withColor((theme) => theme.colors.secondaryActive);

  Widget get onSecondary => _withColor((theme) => theme.colors.onSecondary);

  // Accent Colors
  Widget get accent => _withColor((theme) => theme.colors.accent);

  Widget get onAccent => _withColor((theme) => theme.colors.onAccent);

  // Surface Colors
  Widget get surface => _withColor((theme) => theme.colors.surface);

  Widget get surfaceVariant =>
      _withColor((theme) => theme.colors.surfaceVariant);

  Widget get surfaceElevated =>
      _withColor((theme) => theme.colors.surfaceElevated);

  Widget get inverseSurface =>
      _withColor((theme) => theme.colors.inverseSurface);

  Widget get onSurface => _withColor((theme) => theme.colors.onSurface);

  Widget get onSurfaceVariant =>
      _withColor((theme) => theme.colors.onSurfaceVariant);

  Widget get onInverseSurface =>
      _withColor((theme) => theme.colors.onInverseSurface);

  // Background Colors
  Widget get background => _withColor((theme) => theme.colors.background);

  Widget get onBackground => _withColor((theme) => theme.colors.onBackground);

  // Semantic Colors - Error
  Widget get error => _withColor((theme) => theme.colors.error);

  Widget get errorContainer =>
      _withColor((theme) => theme.colors.errorContainer);

  Widget get onError => _withColor((theme) => theme.colors.onError);

  Widget get onErrorContainer =>
      _withColor((theme) => theme.colors.onErrorContainer);

  // Semantic Colors - Success
  Widget get success => _withColor((theme) => theme.colors.success);

  Widget get successContainer =>
      _withColor((theme) => theme.colors.successContainer);

  Widget get onSuccess => _withColor((theme) => theme.colors.onSuccess);

  Widget get onSuccessContainer =>
      _withColor((theme) => theme.colors.onSuccessContainer);

  // Semantic Colors - Warning
  Widget get warning => _withColor((theme) => theme.colors.warning);

  Widget get warningContainer =>
      _withColor((theme) => theme.colors.warningContainer);

  Widget get onWarning => _withColor((theme) => theme.colors.onWarning);

  Widget get onWarningContainer =>
      _withColor((theme) => theme.colors.onWarningContainer);

  // Semantic Colors - Info
  Widget get info => _withColor((theme) => theme.colors.info);

  Widget get infoContainer => _withColor((theme) => theme.colors.infoContainer);

  Widget get onInfo => _withColor((theme) => theme.colors.onInfo);

  Widget get onInfoContainer =>
      _withColor((theme) => theme.colors.onInfoContainer);

  // Additional Colors
  Widget get outline => _withColor((theme) => theme.colors.outline);

  Widget get outlineVariant =>
      _withColor((theme) => theme.colors.outlineVariant);

  Widget get neutral => _withColor((theme) => theme.colors.neutral);

  Widget get neutralVariant =>
      _withColor((theme) => theme.colors.neutralVariant);

  Widget get muted => _withColor((theme) => theme.colors.muted);

  Widget get onMuted => _withColor((theme) => theme.colors.onMuted);

  Widget get shadow => _withColor((theme) => theme.colors.shadow);

  Widget get scrim => _withColor((theme) => theme.colors.scrim);

  Widget get ring => _withColor((theme) => theme.colors.ring);
}
