import 'package:ckgoc_core/src/foundation/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ckgoc_core/src/themes/themes.dart';
import 'package:ckgoc_core/src/components/components.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

typedef _P = CkgocPrimitiveColors;

// Deterministic palette — named primitive pairs, no raw hex literals.
const _palette = <(Color, Color)>[
  (_P.info, _P.neutral0),
  (_P.success, _P.neutral0),
  (_P.warning, _P.neutral0),
  (_P.error, _P.neutral0),
  (_P.violet, _P.neutral0),
  (_P.cyan, _P.neutral0),
  (_P.orange, _P.neutral0),
  (_P.blue, _P.neutral0),
];

double _dp(AvatarSize s, CkgocSpacing spacing) => switch (s) {
  AvatarSize.xs => spacing.lg, // 24
  AvatarSize.sm => spacing.xl, // 32
  AvatarSize.md => spacing.s40, // 40
  AvatarSize.lg => spacing.x2l, // 48
  AvatarSize.xl => spacing.x2l + spacing.sm, // 56
  AvatarSize.x2l => spacing.x3l, // 64
  AvatarSize.x3l => spacing.s80, // 80
};

// Font size is 37.5% of avatar diameter — derived from size token, not arbitrary.
double _fontSize(AvatarSize s, CkgocSpacing spacing) =>
    (_dp(s, spacing) * 0.375).roundToDouble();

// Dot is 25% of diameter, clamped sm–s12.
double _dotSize(AvatarSize s, CkgocSpacing spacing) =>
    (_dp(s, spacing) * 0.25).clamp(spacing.sm, spacing.s12).roundToDouble();

/// Circular (or square) avatar widget supporting initials, images and status.
class CkgocAvatar extends StatelessWidget {
  const CkgocAvatar({
    this.initials,
    this.image,
    this.size = AvatarSize.md,
    this.status,
    this.backgroundColor,
    this.square = false,
    super.key,
  });
  final String? initials;
  final ImageProvider? image;
  final AvatarSize size;
  final AvatarStatus? status;
  final Color? backgroundColor;
  final bool square;

  (Color bg, Color fg) _resolveColors(CkgocColors colors) {
    if (backgroundColor != null) return (backgroundColor!, _P.neutral0);
    final text = (initials ?? '').trim();
    if (text.isEmpty) return (colors.surfaceVariant, colors.onSurfaceVariant);
    return _palette[text.toUpperCase().hashCode.abs() % _palette.length];
  }

  Color _statusColor(CkgocColors colors) => switch (status!) {
    AvatarStatus.online => colors.success,
    AvatarStatus.away => colors.warning,
    AvatarStatus.busy => colors.error,
    AvatarStatus.offline => colors.neutral,
  };

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final dp = _dp(size, spacing);
    final fs = _fontSize(size, spacing);
    final text = (initials ?? '').toUpperCase().trim();
    final display = text.length > 2 ? text.substring(0, 2) : text;
    final (bg, fg) = _resolveColors(colors);

    final shape = square
        ? BorderRadius.circular(theme.radius.md)
        : BorderRadius.circular(dp / 2);

    final avatar = Container(
      width: dp,
      height: dp,
      decoration: BoxDecoration(
        color: image == null ? bg : colors.surfaceVariant,
        borderRadius: shape,
        image: image != null
            ? DecorationImage(image: image!, fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: image == null
          ? (display.isNotEmpty
                ? Text(
                    display,
                    style: TextStyle(
                      fontSize: fs,
                      fontWeight: FontWeight.w600,
                      color: fg,
                      height: 1,
                    ),
                  )
                : Icon(LucideIcons.user, size: fs * 1.2, color: fg))
          : null,
    );

    if (status == null) return avatar;

    final dot = _dotSize(size, spacing);
    return SizedBox(
      width: dp,
      height: dp,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dot + spacing.xs,
              height: dot + spacing.xs,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Container(
                width: dot,
                height: dot,
                decoration: BoxDecoration(
                  color: _statusColor(colors),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact avatar group that shows overlapping `CkgocAvatar` instances.
class CkgocAvatarGroup extends StatelessWidget {
  const CkgocAvatarGroup({
    required this.avatars,
    this.maxVisible = 4,
    this.size = AvatarSize.md,
    super.key,
  });
  final List<CkgocAvatar> avatars;
  final int maxVisible;
  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckgocTheme;
    final colors = theme.colors;
    final spacing = theme.spacing;
    final dp = _dp(size, spacing);
    final ring = spacing.xxs;
    final offset = dp * 0.75;

    final visible = avatars.take(maxVisible).toList();
    final overflow = avatars.length - maxVisible;
    final total = visible.length + (overflow > 0 ? 1 : 0);
    final totalWidth = dp + ring * 2 + (total - 1) * offset;

    return SizedBox(
      width: totalWidth,
      height: dp + ring * 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * offset,
              top: 0,
              child: _ringed(visible[i], dp, ring, colors),
            ),
          if (overflow > 0)
            Positioned(
              left: visible.length * offset,
              top: 0,
              child: _overflowBadge(overflow, dp, ring, colors, spacing),
            ),
        ],
      ),
    );
  }

  Widget _ringed(
    CkgocAvatar avatar,
    double dp,
    double ring,
    CkgocColors colors,
  ) {
    return Container(
      width: dp + ring * 2,
      height: dp + ring * 2,
      decoration: BoxDecoration(color: colors.surface, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: avatar,
    );
  }

  Widget _overflowBadge(
    int count,
    double dp,
    double ring,
    CkgocColors colors,
    CkgocSpacing spacing,
  ) {
    return Container(
      width: dp + ring * 2,
      height: dp + ring * 2,
      decoration: BoxDecoration(color: colors.surface, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Container(
        width: dp,
        height: dp,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '+$count',
          style: TextStyle(
            fontSize: _fontSize(size, spacing) * 0.9,
            fontWeight: FontWeight.w600,
            color: colors.onSurfaceVariant,
            height: 1,
          ),
        ),
      ),
    );
  }
}
