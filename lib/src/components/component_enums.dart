/// Component enums and lightweight value objects used throughout components.
library;

import 'package:flutter/material.dart';

// Button

/// Variants for `CkgocButton` styling.
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

/// Size options for buttons.
enum ButtonSize { xs, sm, md, lg, xl }

// Badge

/// Variants for badge appearance.
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

/// State for chips.
enum ChipState { defaultState, selected, disabled, error }

// Avatar

/// Avatar size options.
enum AvatarSize { xs, sm, md, lg, xl, x2l, x3l }

/// Presence/status for avatars.
enum AvatarStatus { online, away, busy, offline }

// Switch

/// Variants for styled switches.
enum SwitchVariant { success, error }

// Toast

/// Variants for toast notifications.
enum ToastVariant { defaultToast, info, success, warning, error }

// Progress

/// Variants for progress indicators.
enum ProgressVariant { primary, success, warning, error, indeterminate }

// Loader

/// Types of loader widgets supported.
enum LoaderType { circular, dots, bar, ring }

// Card

/// Variants for card styling.
enum CardVariant { defaultCard, success, warning, error, info }

/// Layout orientations for cards.
enum CardLayout { vertical, horizontal }

// Container

/// Variants for container surfaces.
enum ContainerVariant { surface, muted, outlined }

// Data Table

/// Column data types used by the table component.
enum CkgocColumnType { text, badge, avatarText, progress, custom }

/// Selection modes for tables.
enum TableSelectionMode { none, single, multiple }

/// Width behavior for table columns.
enum TableWidthBehavior { stretch, compact }

// Alert

/// Variants for alert messages.
enum AlertVariant { info, success, warning, error }

// Accordion

/// Item model for `CkgocAccordion`.
class CkgocAccordionItem {
  const CkgocAccordionItem({required this.title, required this.content});
  final String title;
  final Widget content;
}

// Stepper

/// Status for a step in a stepper.
enum StepStatus { completed, inProgress, pending }

/// Orientation for the stepper widget.
enum CkgocStepperOrientation { vertical, horizontal }

/// Small model representing a single step.
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

/// Orientation for timeline layouts.
enum CkgocTimelineOrientation { vertical, horizontal }

/// Event model for `CkgocTimeline`.
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

/// Styles for app bars.
enum AppBarStyle { primary, surface, dark, transparent }

/// Variants for tabs.
enum TabVariant { line, pill, card }

/// Model for a navigation item.
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

/// Model for a tab entry.
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

/// Breadcrumb item model.
class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

// Side navigation

/// Style variants for side navigation.
enum SideNavStyle { surface, brand }

/// Model for side navigation item.
class CkgocSideNavItem {
  const CkgocSideNavItem({required this.icon, required this.label, this.badge});
  final IconData icon;
  final String label;
  final int? badge;
}

/// Section container for side navigation items.
class CkgocSideNavSection {
  const CkgocSideNavSection({required this.items, this.label});
  final String? label;
  final List<CkgocSideNavItem> items;
}

// Menu

/// Model for items in a menu.
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
