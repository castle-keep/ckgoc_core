// Component enums.
library;

import 'package:flutter/material.dart';

// Button

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  accent,
  destructive,
  success,
  warning,
  info,
  link,
}

enum ButtonSize { xs, sm, md, lg, xl }

// Badge

enum BadgeVariant {
  defaultFill,
  primary,
  success,
  warning,
  error,
  info,
  live,
  newBadge,
  beta,
  pro,
  outline,
  outlineSuccess,
  outlineError,
  online,
  away,
  busy,
  offline,
}

// Chip

enum ChipState { defaultState, selected, disabled, error }

// Avatar

enum AvatarSize { xs, sm, md, lg, xl, x2l, x3l }

enum AvatarStatus { online, away, busy, offline }

// Switch

enum SwitchVariant { success, error }

// Toast

enum ToastVariant { defaultToast, info, success, warning, error }

// Progress

enum ProgressVariant { primary, success, warning, error, indeterminate }

// Loader

enum LoaderType { circular, dots, bar, ring }

// Card
enum CardVariant { defaultCard, success, warning, error, info }

enum CardLayout { vertical, horizontal }

// Container
enum ContainerVariant { surface, muted, outlined }

// Data Table
enum CkgocColumnType { text, badge, avatarText, progress, custom }

enum TableSelectionMode { none, single, multiple }

enum TableWidthBehavior { stretch, compact }

// Alert

enum AlertVariant { info, success, warning, error }

// Accordion

class CkgocAccordionItem {
  const CkgocAccordionItem({required this.title, required this.content});
  final String title;
  final Widget content;
}

// Stepper

enum StepStatus { completed, inProgress, pending }

enum CkgocStepperOrientation { vertical, horizontal }

class CkgocStep {
  const CkgocStep({
    required this.title,
    required this.status,
    this.icon,
    this.color,
  });
  final String title;
  final StepStatus status;
  final Widget? icon;
  final Color? color;
}

// Timeline

enum CkgocTimelineOrientation { vertical, horizontal }

class CkgocTimelineEvent {
  const CkgocTimelineEvent({
    required this.title,
    this.timestamp,
    this.icon,
    this.dotColor,
  });
  final String title;
  final String? timestamp;
  final Widget? icon;
  final Color? dotColor;
}

// Navigation

enum AppBarStyle { primary, surface, dark, transparent }

enum TabVariant { line, pill, card }

class CkgocNavItem {
  const CkgocNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

class CkgocTab {
  const CkgocTab({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
  });
  final String label;
  final IconData? icon;
  final int? badge;
  final Widget content;
}

// Breadcrumb

class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

// Side navigation

enum SideNavStyle { surface, brand }

class CkgocSideNavItem {
  const CkgocSideNavItem({required this.icon, required this.label, this.badge});
  final IconData icon;
  final String label;
  final int? badge;
}

class CkgocSideNavSection {
  const CkgocSideNavSection({required this.items, this.label});
  final String? label;
  final List<CkgocSideNavItem> items;
}

// Menu

class CkgocMenuItem {
  const CkgocMenuItem({
    required this.label,
    this.icon,
    this.onTap,
    this.destructive = false,
  });
  final IconData? icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;
}
