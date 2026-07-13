The color system defines every token used across both Castlekeep and Skygo. 

---

## Castlekeep Brand Colors

| Token | Hex | Usage |
| --- | --- | --- |
| `primary` | `#02372E` | Primary actions, backgrounds |
| `primaryLight` | `#054D40` | Hover states, lighter backgrounds |
| `primaryDark` | `#011E19` | Pressed states, dark surfaces |
| `accent` | `#E9BB43` | Active state highlights, CTAs |
| `accentLight` | `#F2D07A` | Lighter accent tints |
| `accentDark` | `#C49A1E` | Darker accent for contrast |

## Skygo Brand Colors

| Token | Hex | Usage |
| --- | --- | --- |
| `primary` | `#0070DE` | Primary actions, links, buttons |
| `primaryLight` | `#3394F5` | Hover states |
| `primaryDark` | `#004DA0` | Active/pressed states |
| `accent` | `#F4FCFF` | Light accent surfaces |
| `accentLight` | `#FFFFFF` | White surfaces |
| `accentDark` | `#D0EEFF` | Subtle tinted surfaces |

---

## Neutral Scale

| Token | Hex | Usage |
| --- | --- | --- |
| `neutral-0` | `#FFFFFF` | White / pure backgrounds |
| `neutral-50` | `#F8F9FA` | Page background |
| `neutral-100` | `#F1F3F5` | Subtle surface |
| `neutral-200` | `#E9ECEF` | Borders (light) |
| `neutral-300` | `#DEE2E6` | Input borders |
| `neutral-400` | `#CED4DA` | Disabled borders |
| `neutral-500` | `#ADB5BD` | Placeholder text |
| `neutral-600` | `#868E96` | Muted text / labels |
| `neutral-700` | `#495057` | Body text |
| `neutral-800` | `#343A40` | Strong body text |
| `neutral-900` | `#212529` | Headings |
| `neutral-950` | `#0D1117` | Dark backgrounds |
| `neutral-1000` | `#000000` | Pure black |

---

## Semantic Colors

| Semantic | DEFAULT | Light | Dark | Surface |
| --- | --- | --- | --- | --- |
| Success | `#16A34A` | `#86EFAC` | `#14532D` | `#F0FDF4` |
| Warning | `#D97706` | `#FCD34D` | `#92400E` | `#FFFBEB` |
| Error | `#DC2626` | `#FCA5A5` | `#991B1B` | `#FEF2F2` |
| Info | `#2563EB` | `#93C5FD` | `#1E3A8A` | `#EFF6FF` |

---

## Flutter Implementation

```dart
// lib/theme/app_colors.dart
import 'package:flutter/material.dart';

class CastlekeepColors {
  static const primary      = Color(0xFF02372E);
  static const primaryLight = Color(0xFF054D40);
  static const primaryDark  = Color(0xFF011E19);
  static const accent       = Color(0xFFE9BB43);
  static const accentLight  = Color(0xFFF2D07A);
  static const accentDark   = Color(0xFFC49A1E);
}

class SkygoColors {
  static const primary      = Color(0xFF0070DE);
  static const primaryLight = Color(0xFF3394F5);
  static const primaryDark  = Color(0xFF004DA0);
  static const accent       = Color(0xFFF4FCFF);
  static const accentLight  = Color(0xFFFFFFFF);
  static const accentDark   = Color(0xFFD0EEFF);
}

class AppColors {
  // Neutrals
  static const neutral0    = Color(0xFFFFFFFF);
  static const neutral50   = Color(0xFFF8F9FA);
  static const neutral100  = Color(0xFFF1F3F5);
  static const neutral200  = Color(0xFFE9ECEF);
  static const neutral300  = Color(0xFFDEE2E6);
  static const neutral500  = Color(0xFFADB5BD);
  static const neutral600  = Color(0xFF868E96);
  static const neutral700  = Color(0xFF495057);
  static const neutral900  = Color(0xFF212529);
  static const neutral950  = Color(0xFF0D1117);

  // Semantic
  static const success  = Color(0xFF16A34A);
  static const warning  = Color(0xFFD97706);
  static const error    = Color(0xFFDC2626);
  static const info     = Color(0xFF2563EB);
}
```

> **Rule:** Always use token names in Flutter. Never hardcode raw hex values in widget files.
