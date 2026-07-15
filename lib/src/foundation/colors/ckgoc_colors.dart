import 'package:flutter/material.dart';

/// Semantic color tokens.
@immutable
class CkgocColors {
  const CkgocColors({
    required this.primary,
    required this.primaryHover,
    required this.primaryActive,
    required this.primaryDisabled,
    required this.onPrimary,
    required this.secondary,
    required this.secondaryHover,
    required this.secondaryActive,
    required this.onSecondary,
    required this.accent,
    required this.onAccent,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceElevated,
    required this.inverseSurface,
    required this.onBackground,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onInverseSurface,
    required this.outline,
    required this.outlineVariant,
    required this.error,
    required this.errorContainer,
    required this.onError,
    required this.onErrorContainer,
    required this.success,
    required this.successContainer,
    required this.onSuccess,
    required this.onSuccessContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarning,
    required this.onWarningContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfo,
    required this.onInfoContainer,
    required this.neutral,
    required this.neutralVariant,
    required this.shadow,
    required this.scrim,
    required this.ring,
    required this.muted,
    required this.onMuted,
    required this.tagLive,
    required this.onTagLive,
    required this.tagNew,
    required this.onTagNew,
    required this.tagBeta,
    required this.onTagBeta,
    required this.tagProStart,
    required this.tagProEnd,
    required this.onTagPro,
  });
  // Primary
  final Color primary;
  final Color primaryHover;
  final Color primaryActive;
  final Color primaryDisabled;
  final Color onPrimary;

  // Secondary
  final Color secondary;
  final Color secondaryHover;
  final Color secondaryActive;
  final Color onSecondary;

  // Accent
  final Color accent;
  final Color onAccent;

  // Background / Surface
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceElevated;
  final Color inverseSurface;
  final Color onBackground;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color onInverseSurface;

  // Outline
  final Color outline;
  final Color outlineVariant;

  // Feedback
  final Color error;
  final Color errorContainer;
  final Color onError;
  final Color onErrorContainer;

  final Color success;
  final Color successContainer;
  final Color onSuccess;
  final Color onSuccessContainer;

  final Color warning;
  final Color warningContainer;
  final Color onWarning;
  final Color onWarningContainer;

  final Color info;
  final Color infoContainer;
  final Color onInfo;
  final Color onInfoContainer;

  // Neutral
  final Color neutral;
  final Color neutralVariant;

  // Shadow
  final Color shadow;
  final Color scrim;
  final Color ring;
  final Color muted;
  final Color onMuted;

  // Badge / Tag
  final Color tagLive;
  final Color onTagLive;
  final Color tagNew;
  final Color onTagNew;
  final Color tagBeta;
  final Color onTagBeta;
  final Color tagProStart;
  final Color tagProEnd;
  final Color onTagPro;

  /// Creates a copy of this [CkgocColors] with the given fields replaced.
  CkgocColors copyWith({
    Color? primary,
    Color? primaryHover,
    Color? primaryActive,
    Color? primaryDisabled,
    Color? onPrimary,
    Color? secondary,
    Color? secondaryHover,
    Color? secondaryActive,
    Color? onSecondary,
    Color? accent,
    Color? onAccent,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceElevated,
    Color? inverseSurface,
    Color? onBackground,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? onInverseSurface,
    Color? outline,
    Color? outlineVariant,
    Color? error,
    Color? errorContainer,
    Color? onError,
    Color? onErrorContainer,
    Color? success,
    Color? successContainer,
    Color? onSuccess,
    Color? onSuccessContainer,
    Color? warning,
    Color? warningContainer,
    Color? onWarning,
    Color? onWarningContainer,
    Color? info,
    Color? infoContainer,
    Color? onInfo,
    Color? onInfoContainer,
    Color? neutral,
    Color? neutralVariant,
    Color? shadow,
    Color? scrim,
    Color? ring,
    Color? muted,
    Color? onMuted,
    Color? tagLive,
    Color? onTagLive,
    Color? tagNew,
    Color? onTagNew,
    Color? tagBeta,
    Color? onTagBeta,
    Color? tagProStart,
    Color? tagProEnd,
    Color? onTagPro,
  }) {
    return CkgocColors(
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryActive: primaryActive ?? this.primaryActive,
      primaryDisabled: primaryDisabled ?? this.primaryDisabled,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      secondaryHover: secondaryHover ?? this.secondaryHover,
      secondaryActive: secondaryActive ?? this.secondaryActive,
      onSecondary: onSecondary ?? this.onSecondary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      onError: onError ?? this.onError,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      onSuccess: onSuccess ?? this.onSuccess,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarning: onWarning ?? this.onWarning,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfo: onInfo ?? this.onInfo,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      neutral: neutral ?? this.neutral,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      ring: ring ?? this.ring,
      muted: muted ?? this.muted,
      onMuted: onMuted ?? this.onMuted,
      tagLive: tagLive ?? this.tagLive,
      onTagLive: onTagLive ?? this.onTagLive,
      tagNew: tagNew ?? this.tagNew,
      onTagNew: onTagNew ?? this.onTagNew,
      tagBeta: tagBeta ?? this.tagBeta,
      onTagBeta: onTagBeta ?? this.onTagBeta,
      tagProStart: tagProStart ?? this.tagProStart,
      tagProEnd: tagProEnd ?? this.tagProEnd,
      onTagPro: onTagPro ?? this.onTagPro,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CkgocColors &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          background == other.background &&
          surface == other.surface;

  @override
  int get hashCode => Object.hash(primary, background, surface);
}
