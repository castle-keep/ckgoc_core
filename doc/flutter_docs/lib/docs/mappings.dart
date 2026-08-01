import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';

// Helper mappings to render widgets from enum values using the new
// semantic named constructors. These keep docs concise and avoid
// repeating long switch expressions across pages.

Widget buttonForVariant(
  ButtonVariant variant, {
  ButtonSize size = ButtonSize.md,
  VoidCallback? onPressed,
  Widget? child,
}) {
  return switch (variant) {
    ButtonVariant.primary =>
      CKButton(size: size, onPressed: onPressed, child: child),
    ButtonVariant.secondary =>
      CKButton.secondary(size: size, onPressed: onPressed, child: child),
    ButtonVariant.outline =>
      CKButton.outline(size: size, onPressed: onPressed, child: child),
    ButtonVariant.ghost =>
      CKButton.ghost(size: size, onPressed: onPressed, child: child),
    ButtonVariant.accent =>
      CKButton.accent(size: size, onPressed: onPressed, child: child),
    ButtonVariant.destructive =>
      CKButton.destructive(size: size, onPressed: onPressed, child: child),
    ButtonVariant.success =>
      CKButton.success(size: size, onPressed: onPressed, child: child),
    ButtonVariant.warning =>
      CKButton.warning(size: size, onPressed: onPressed, child: child),
    ButtonVariant.info =>
      CKButton.info(size: size, onPressed: onPressed, child: child),
    ButtonVariant.link =>
      CKButton.link(size: size, onPressed: onPressed, child: child),
  };
}

Widget badgeForVariant(BadgeVariant variant, String label) {
  return switch (variant) {
    BadgeVariant.defaultFill => CKBadge(label: label),
    BadgeVariant.primary => CKBadge(label: label),
    BadgeVariant.success => CKBadge.success(label: label),
    BadgeVariant.warning => CKBadge.warning(label: label),
    BadgeVariant.error => CKBadge.error(label: label),
    BadgeVariant.info => CKBadge.info(label: label),
    BadgeVariant.draft => CKBadge.draft(label: label),
    BadgeVariant.live => CKBadge.live(label: label),
    BadgeVariant.newBadge => CKBadge.newBadge(label: label),
    BadgeVariant.beta => CKBadge.beta(label: label),
    BadgeVariant.pro => CKBadge.pro(label: label),
    BadgeVariant.outline => CKBadge.outline(label: label),
    BadgeVariant.outlineSuccess => CKBadge.outlineSuccess(label: label),
    BadgeVariant.outlineError => CKBadge.outlineError(label: label),
    BadgeVariant.online => CKBadge.online(label: label),
    BadgeVariant.away => CKBadge.away(label: label),
    BadgeVariant.busy => CKBadge.busy(label: label),
    BadgeVariant.offline => CKBadge.offline(label: label),
  };
}

Widget cardForVariant(CardVariant variant,
    {required String title,
    String? subtitle,
    String? description,
    Widget? action}) {
  return switch (variant) {
    CardVariant.defaultCard => CKCard(
        title: title,
        subtitle: subtitle,
        description: description,
        action: action),
    CardVariant.success => CKCard.success(
        title: title,
        subtitle: subtitle,
        description: description,
        action: action),
    CardVariant.warning => CKCard.warning(
        title: title,
        subtitle: subtitle,
        description: description,
        action: action),
    CardVariant.error => CKCard.error(
        title: title,
        subtitle: subtitle,
        description: description,
        action: action),
    CardVariant.info => CKCard.info(
        title: title,
        subtitle: subtitle,
        description: description,
        action: action),
  };
}

Widget containerForVariant(ContainerVariant variant,
    {required Widget child,
    bool elevated = false,
    EdgeInsetsGeometry? padding}) {
  return switch (variant) {
    ContainerVariant.surface =>
      CKContainer(child: child, elevated: elevated, padding: padding),
    ContainerVariant.muted =>
      CKContainer.muted(child: child, elevated: elevated, padding: padding),
    ContainerVariant.outlined =>
      CKContainer.outlined(child: child, elevated: elevated, padding: padding),
  };
}

Widget loaderFor(LoaderType type, {double size = 40}) {
  return switch (type) {
    LoaderType.circular => CKLoader(size: size),
    LoaderType.ring => CKLoader.ring(size: size),
    LoaderType.bar => CKLoader.bar(size: size),
    LoaderType.dots => CKLoader.dots(size: size),
  };
}

Widget progressBarFor(ProgressVariant variant,
    {double? value, double maxValue = 1.0, bool showValue = false}) {
  return switch (variant) {
    ProgressVariant.primary =>
      CKProgressBar(value: value, maxValue: maxValue, showValue: showValue),
    ProgressVariant.success => CKProgressBar.success(
        value: value, maxValue: maxValue, showValue: showValue),
    ProgressVariant.warning => CKProgressBar.warning(
        value: value, maxValue: maxValue, showValue: showValue),
    ProgressVariant.error => CKProgressBar.error(
        value: value, maxValue: maxValue, showValue: showValue),
    ProgressVariant.indeterminate =>
      CKProgressBar.indeterminate(maxValue: maxValue, showValue: showValue),
  };
}

Widget toastFor(ToastVariant variant, String message,
    {VoidCallback? onDismiss}) {
  return switch (variant) {
    ToastVariant.defaultToast =>
      CKToast(message: message, onDismiss: onDismiss),
    ToastVariant.success =>
      CKToast.success(message: message, onDismiss: onDismiss),
    ToastVariant.error => CKToast.error(message: message, onDismiss: onDismiss),
    ToastVariant.warning =>
      CKToast.warning(message: message, onDismiss: onDismiss),
    ToastVariant.info => CKToast.info(message: message, onDismiss: onDismiss),
  };
}

Widget tabsForVariant(TabVariant variant,
    {required List<CKTab> tabs,
    bool scrollable = false,
    int initialIndex = 0,
    ValueChanged<int>? onTabChanged}) {
  return switch (variant) {
    TabVariant.line => CKTabs(
        tabs: tabs,
        scrollable: scrollable,
        initialIndex: initialIndex,
        onTabChanged: onTabChanged),
    TabVariant.pill => CKTabs.pill(
        tabs: tabs,
        scrollable: scrollable,
        initialIndex: initialIndex,
        onTabChanged: onTabChanged),
    TabVariant.card => CKTabs.card(
        tabs: tabs,
        scrollable: scrollable,
        initialIndex: initialIndex,
        onTabChanged: onTabChanged),
  };
}
