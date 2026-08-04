# ckcoreui Quick Guide

Key points
- Use the default `CKApp(...)` constructor for typical Navigator 1.0 apps.
- Use `CKApp.router(...)` when you need Navigator 2.0 features (deep links,
  declarative routing via `RouterConfig`).
- `CKApp.delegate(...)` accepts a `RouterDelegate` and `RouteInformationParser`
  for advanced router implementations.

Minimal examples

```dart
// Simple app
CKApp(
  brand: ckcoreBrand.castleKeep,
  home: HomePage(),
  title: 'My App',
)

// Router-based app
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  routerConfig: myRouterConfig,
)

// Delegate-based router (explicit delegate + parser)
CKApp.delegate(
  brand: ckcoreBrand.castleKeep,
  routerDelegate: myRouterDelegate,
  routeInformationParser: myRouteInformationParser,
  themeMode: ThemeMode.system,
)
```
      feedback/            # ckcoreProgressBar, ckcoreSlider, ckcoreLoader,
                           # ckcoreLoadingState, ckcoreAlert, ckcoreSkeleton…
      navigation/          # Nav bars, tabs, breadcrumbs, menus
      overlays/            # Modals, drawers, toasts, snackbars
    templates/             # Full-screen layout templates (auth, CRUD, dashboard…)
    extensions/            # Dart/Flutter extension helpers
    utils/                 # Internal utilities

showcase/                  # Standalone Flutter app consuming ckcoreui via path dep
  lib/
    screens/               # One screen per component category
```

---

## Access design tokens

The package provides multiple patterns for accessing design tokens, all context-aware and theme-resolved.

### Option 1: Ergonomic extension (recommended)

Shortest syntax using BuildContext extensions:

```dart
Container(
  color: context.ckColors.primary,
  padding: EdgeInsets.all(context.ckSpacing.md),
  child: Text('Hello', style: context.ckTypography.textMd),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(context.ckRadius.md),
    boxShadow: [context.ckShadows.sm],
  ),
)
```

**Available extensions:** `context.ckColors`, `context.ckSpacing`, `context.ckTypography`, `context.ckRadius`, `context.ckElevation`, `context.ckShadows`, `context.ckMotion`, `context.ckOpacity`, `context.ckBreakpoints`

### Option 2: Explicit static accessor (Flutter-style)

Mirrors Flutter's `Theme.of(context)` pattern:

```dart
Container(
  color: CKColors.of(context).primary,
  padding: EdgeInsets.all(CKSpacing.of(context).md),
  child: Text('Hello', style: CKTypography.of(context).textMd),
)
```

**Available accessors:** `CKColors.of(context)`, `CKSpacing.of(context)`, `CKTypography.of(context)`, `CKRadius.of(context)`, `CKElevation.of(context)`, `CKShadows.of(context)`, `CKMotion.of(context)`, `CKOpacity.of(context)`, `CKBreakpoints.of(context)`

### Option 3: Legacy pattern (still works)

For backward compatibility, the original pattern continues to work:

```dart
final theme = context.ckcoreTheme;
final t = theme.typography;
final s = theme.spacing;
final c = theme.colors;
final r = theme.radius;
final m = theme.motion;
final o = theme.opacity;
final e = theme.elevation;
final sh = theme.shadows;
```

**See also:** [Design Tokens Quick Access Guide](design-tokens-quick-access.md) for detailed examples and patterns.

**Golden rule — modifier order**

When using the `Text` extension helpers, apply modifier extensions (like `.bold`, `.italic`, `.lineThrough`) before typography or color helpers because those return a `Widget`. For example prefer:

```dart
Text('Hi').bold.h1
```

and not:

```dart
Text('Hi').h1.bold
```

This ensures modifiers are applied to the `Text` instance before it's wrapped by a typography or color `Widget`.

## Brand scaffolding CLI

There is a small Dart CLI that scaffolds a new brand (colors, typography, light/dark theme files) and registers it in the theme resolver. Run it from the repository root:

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

Generated files live under `lib/src/themes/brands/<brand>/`.

---

## CKApp (app bootstrap)

`CKApp` is a lightweight wrapper around `MaterialApp` that automatically
applies CKCoreUI theme resolution for a chosen `brand` and brightness.

Key points
  declarative routing via `RouterConfig`).
  for advanced router implementations.

Minimal examples

```dart
// Simple app
CKApp(
  brand: ckcoreBrand.castleKeep,
  home: HomePage(),
  title: 'My App',
)

// Router-based app
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  routerConfig: myRouterConfig,
)
// Delegate-based router (explicit delegate + parser)
```dart
CKApp.delegate(
  brand: ckcoreBrand.castleKeep,
  routerDelegate: myRouterDelegate,
  routeInformationParser: myRouteInformationParser,
  themeMode: ThemeMode.system,
)
```
```
Notes
- `CKApp` resolves light/dark theme data from the brand and exposes it via
  `context.ckcoreTheme` or ergonomic extensions like `context.ckColors`.
- The widget forwards common `MaterialApp` parameters (locales, delegates,
  navigatorObservers, shortcuts, actions) so adoption is straightforward.

# Components Quick Guide

A concise reference for the package components. For full API details see the source in `lib/src/components/` and examples in the `showcase/` app.

---
A concise reference for the package components. Below are expanded, parameter-level docs and examples for each major component.

Note: For full type signatures refer to the source files in `lib/src/components/`.

---

## Buttons

### CKButton
Button component with semantic color variants and multiple sizes.

The default appearance is **primary** (filled, high emphasis). Use named constructors for other variants:

```dart
CKButton(onPressed: () {}, child: Text('Save'))              // primary (default)
CKButton.secondary(onPressed: () {}, child: Text('Cancel'))
CKButton.outline(onPressed: () {}, child: Text('Learn More'))
CKButton.ghost(onPressed: () {}, child: Text('Skip'))
CKButton.destructive(onPressed: () {}, child: Text('Delete'))
CKButton.success(onPressed: () {}, child: Text('Approve'))
CKButton.warning(onPressed: () {}, child: Text('Caution'))
CKButton.info(onPressed: () {}, child: Text('Details'))
CKButton.link(onPressed: () {}, child: Text('Help'))
```

Common properties:
- `size` (ButtonSize): Token size. Default: `md`.
- `onPressed` (VoidCallback?): Tap callback.
- `child` (Widget?): Content (usually `Text`).
- `loading` (bool): Show spinner. Default: `false`.
- `disabled` (bool): Force disabled state. Default: `false`.
- `isFullWidth` (bool): Expand horizontally. Default: `false`.

Example
```dart
CKButton(
  size: ButtonSize.lg,
  isFullWidth: true,
  onPressed: () {},
  child: Text('Save Changes'),
)

```

### CKIconButton
Icon-only button.

Params
- `icon` (IconData): Required icon symbol.
- `onPressed` (VoidCallback?): Nullable to disable.
- `tooltip` (String?): Optional tooltip shown on hover/long-press.

Example
```dart
CKIconButton(icon: Icons.search, onPressed: () {});
```

### CKFab
Floating action button with optional `label` for extended FAB.

Params
- `icon` (IconData): Required.
- `onPressed` (VoidCallback?): Action.
- `label` (String?): When provided renders `FloatingActionButton.extended`.

Example
```dart
CKFab(icon: Icons.add, onPressed: () {}, label: 'Create');
```

---

## Inputs

### CKTextField
Full-featured text field with tokens and validation support.

Params
- `controller` (TextEditingController?): optional controller.
- `focusNode` (FocusNode?): optional external focus node.
- `label` (String?): Label shown above the field when present.
- `hint` (String?): Placeholder/hint text.
- `helperText`/`errorText`/`successText` (String?): Helper / error / success messages.
- `leading`/`trailing` (Widget?): Prefix and suffix widgets.
- `onChanged` (ValueChanged<String>?): Change callback.
- `onEditingComplete` (VoidCallback?): Editing complete callback.
- `validator` (String? Function(String?)?): Synchronous validator used for inline validation.
- `enabled` (bool): Defaults true.
- `readOnly` (bool): Defaults false.
- `maxLines` (int?): Defaults 1.
- `keyboardType` (TextInputType?): Input type.
- `obscureText` (bool): Password-style obscure.
- `textInputAction` (TextInputAction?): IME action.
- `autoFocus` (bool): Autofocus.
- `borderless` (bool): Renders without outline / background.

Example
```dart
CKTextField(
  label: 'Email',
  hint: 'you@company.com',
  keyboardType: TextInputType.emailAddress,
  validator: (v) => v?.contains('@') == true ? null : 'Invalid email',
)
```

### CKPasswordField, CKSearchField, CKOtpField
- These components wrap `CKTextField` with specialized behaviors (visibility toggle, search actions, OTP digit cells). See `lib/src/components/inputs/` for props mirroring `CKTextField` plus small extras (e.g., `onSubmitted`, `length` for OTP).

### CKCheckbox / CKRadio / CKSwitch
- Standard form controls with `value`, `onChanged`, and an optional `label` or custom child. Use theme tokens for spacing and colors.

Named constructors available for `CKRadio`: `CKRadio.success(...)` and `CKRadio.error(...)` for convenience when rendering status-colored radios.

### CKDropdown<T>
Select input.

Params (high-level)
- `value` (T?): selected value.
- `items` (List<DropdownMenuItem<T>>): options.
- `onChanged` (ValueChanged<T?>?): selection callback.
- `hint` / `label` / `helperText` / `errorText` / `successText` — text-field style props.
- `validator` (String? Function(T?)?): synchronous validator; runs after first change (when dirty).
- `menuMaxHeight` (double): max overlay height before internal scrolling. Default: `400`.
- `menuMinHeight` (double): preferred minimum space below the field before the menu flips above. Default: `144`.

Example (basic)
```dart
CKDropdown<String>(
  label: 'Role',
  hint: 'Select role',
  value: selectedRole,
  menuMaxHeight: 240,
  items: const [
    DropdownMenuItem(value: 'admin', child: Text('Admin')),
    DropdownMenuItem(value: 'editor', child: Text('Editor')),
  ],
  onChanged: (v) => setState(() => selectedRole = v),
)
```

Example (with validation)
```dart
CKDropdown<String>(
  label: 'Role',
  value: selectedRole,
  items: const [
    DropdownMenuItem(value: 'admin', child: Text('Admin')),
    DropdownMenuItem(value: 'editor', child: Text('Editor')),
  ],
  validator: (v) => v == null ? 'Please select a role' : null,
  onChanged: (v) => setState(() => selectedRole = v),
)
```

Notes
- The dropdown follows the same visual tokens as `CKTextField` (filled background, outline, focus ring).
- The menu is a custom anchored overlay rendered below the field when possible and above it when the available height below is smaller than the minimum threshold.
- `validator` runs only after the user makes a selection (dirty state). Explicit `errorText` takes precedence over `validator` result.
- Use `helperText`, `errorText`, or `successText` to show contextual messages below the control.

### CKNumberStepper
Numeric stepper input that looks like a text field and uses `-` and `+` controls to change the value.

Params (high-level)
- `value` (int?): current value.
- `onChanged` (ValueChanged<int>?): increment/decrement callback.
- `min` / `max` (int?): optional lower and upper bounds.
- `step` (int): amount added or removed per tap.
- `hint` / `label` / `helperText` / `errorText` / `enabled` — text-field style props.

Example
```dart
CKNumberStepper(
  label: 'Quantity',
  value: quantity,
  min: 1,
  max: 10,
  helperText: 'Use - and + to adjust',
  onChanged: (value) => setState(() => quantity = value),
)
```

Notes
- The component is display-first: users change the number through the controls rather than typing arbitrary text.
- Boundaries are enforced internally, so decrement and increment stop at `min` and `max`.

### CKDatePicker / CKTimePicker
- Themed pickers that open platform dialogs. Provide `initialDate`, `firstDate`, `lastDate`, and `onChanged` callbacks.

---

## Display components

### CKCard
Composable card with title, subtitle, description, optional `media`, `action`, and `trailing` widgets.

The default appearance is **neutral** (surface background). Use named constructors for semantic variants:

Params
- `title` (String): Required header title.
- `subtitle` (String?): Optional subheading.
- `description` (String?): Body text.
- `media` (Widget?): Image or media placed top or left depending on `layout`.
- `action` (Widget?): Footer action (e.g., `CKButton`).
- `trailing` (Widget?): Trailing widget in the title row.
- `layout` (CardLayout): `vertical` (default) or `horizontal`.
- `variant` (CardVariant): Defaults to neutral, or use `.success()`, `.warning()`, `.error()`, `.info()`.
- `onTap` (VoidCallback?): Makes the card tappable.

Example
```dart
CKCard(
  title: 'Card Title',
  subtitle: 'Category · Date',
  description: 'Short description',
  action: CKButton(...),
)

// Semantic variants:
CKCard.success(title: 'Complete!')
CKCard.warning(title: 'Needs Review')
CKCard.error(title: 'Failed')
```

### CKBadge
Small tokenized badges for status and semantic indicators.

The default appearance is **primary**. Use named constructors for other semantic variants:

```dart
CKBadge(label: 'New')                           // primary (default)
CKBadge.success(label: 'Approved')
CKBadge.warning(label: 'Pending')
CKBadge.error(label: 'Failed')
CKBadge.info(label: 'Info')
CKBadge.draft(label: 'Draft')
CKBadge.live(label: 'Live')
CKBadge.beta(label: 'Beta')
CKBadge.pro(label: 'Pro')
CKBadge.online(label: 'Online')
CKBadge.away(label: 'Away')
CKBadge.busy(label: 'Busy')
CKBadge.offline(label: 'Offline')
CKBadge.count(count: 7)                         // count badge
CKBadge.count(count: 99, maxCount: 99)          // with max
```


Params:
- `label` (String?): Badge text.
- `count` (int?): Display count instead of label (with `.count()`).
- `maxCount` (int?): Max before showing '+' (e.g., "99+").

Example
```dart
Row(children: [
  CKBadge.success(label: 'Approved'),
  SizedBox(width: 8),
  CKBadge.count(count: 12),
])
```

### CKFilterChip / CKInputChip, CKAvatar, CKListTile, CKDivider
- Chips: `label`, `onTap`/`onDeleted`, `selected`.
- Avatar: `image`, `initials`, `size`.
- ListTile: `title`, `subtitle`, `leading`, `trailing`, `onTap`.
- Divider: thin themed divider; no props beyond standard padding.

### CKStepper / CKTimeline
- Progress UI primitives; take a list of `steps/events` (see `component_enums.dart` for shapes) and provide `currentIndex` / `status` props.

### CKContainer
Tokenized surface container with semantic variant styling.

The default appearance is **surface** (neutral background). Use named constructors for other variants:

```dart
CKContainer(child: Text('Content'))              // surface (default)
CKContainer.muted(child: Text('Content'))
CKContainer.outlined(child: Text('Content'))
```

Params:
- `child` (Widget): Required content widget.
- `padding` (EdgeInsetsGeometry?): Override default padding.
- `elevated` (bool): Add shadow. Default: false.


### CKAccordion
- Accepts `items` (title + content) and optional `initiallyOpen` flags. See `component_enums` for `CKAccordionItem` shape.

---

## Feedback

### CKProgressBar
Progress bars with semantic color variants.

The default appearance is **primary**. Use named constructors for other semantic variants:

```dart
CKProgressBar(value: 0.5)                       // primary (default)
CKProgressBar.success(value: 1.0)
CKProgressBar.warning(value: 0.75)
CKProgressBar.error(value: 0.25)
CKProgressBar.indeterminate()                   // Animated, no value
```


Params:
- `value` (double?): Progress 0.0–1.0. Null for indeterminate.
- `maxValue` (double): Max value. Default: 1.0.
- `showValue` (bool): Display percentage text. Default: false.

### CKLoader
Spinner/loader animations with semantic variants.

The default animation type is **circular**. Use named constructors for other types:

```dart
CKLoader(size: 40)                              // circular (default)
CKLoader.ring(color: Colors.blue)
CKLoader.bar()
CKLoader.dots(size: 30)
```

Params:
- `size` (double): Loader size. Default: 40.
- `color` (Color?): Override default primary color.

### CKAlert
Inline alerts with semantic color variants.

The default appearance is **info** (informational). Use named constructors for other semantic variants:

```dart
CKAlert(message: 'Information')                 // info (default)
CKAlert.success(message: 'Success!')
CKAlert.warning(message: 'Be careful')
CKAlert.error(message: 'Error occurred')
```

Params:
- `message` (String): Required alert message.
- `title` (String?): Optional title.
- `onDismiss` (VoidCallback?): Dismiss callback.

### CKToast
Toast notifications with semantic color variants.

The default appearance is **neutral** (default colors). Use named constructors for semantic variants:

```dart
CKToast(message: 'Hello')                       // neutral (default)
CKToast.success(message: 'Done!')
CKToast.error(message: 'Failed')
CKToast.warning(message: 'Caution')
CKToast.info(message: 'FYI')
```

Use `CKSnackbar.show()` to display toasts in a scaffold context.

### CKSkeleton
- Accepts layout hints (rows, columns, shapes) and `isLoading` to render placeholder shapes.

### CKEmptyState / CKErrorState / CKLoadingState
- Standardized full-card states. Provide `title`, `subtitle`, `action` and optional illustration widget.
---

## Navigation

### CKAppBar
App bar with semantic style variants and tokenized styling.

**Use semantic named constructors:**
```dart
CKAppBar(title: Text('Home'))               // primary (default)
CKAppBar.surface(title: Text('Home'))
CKAppBar.dark(title: Text('Home'))
CKAppBar.transparent(title: Text('Home'))
```

Params:
- `title` (Widget?): App bar title.
- `leading` (Widget?): Leading widget (often back button).
- `trailing` (List<Widget>): Actions on the right.
- `largeTitle` (bool): Use large title style. Default: false.

### CKTabs
Tab navigation with semantic style variants.

**Use semantic named constructors:**
```dart
CKTabs.line(tabs: [...], onTabChanged: (i) {})
CKTabs.pill(tabs: [...], onTabChanged: (i) {})
CKTabs.card(tabs: [...], onTabChanged: (i) {})
```

Params:
- `tabs` (List<CKTab>): Required list of tab definitions.
- `initialIndex` (int): Starting tab. Default: 0.
- `scrollable` (bool): Allow horizontal scroll. Default: false.
- `onTabChanged` (ValueChanged<int>?): Selection callback.


### CKSwitch
Toggle switch with optional semantic variants.

**Use semantic named constructors:**
```dart
CKSwitch.success(value: true, onChanged: (v) {})
CKSwitch.error(value: false, onChanged: (v) {})
```

Params:
- `value` (bool): Current state.
- `onChanged` (ValueChanged<bool>?): Change callback.
- `label` (String?): Optional label.
- `color` (Color?): Override color.


### CKBottomNavigation, CKNavigationRail, CKSideNav, CKDrawer
- Navigation primitives accept a list of destinations and callbacks for selection.

Note: `CKSideNav` now supports key-based selection. Provide `itemKey` on
`CKSideNavItem` and use `selectedKey` / `onItemSelectedKey` for stable,
non-positional selection. The old `selectedIndex` / `onItemSelected` remain
supported but are deprecated and will be removed in a future release.

### CKBreadcrumb
- Accepts `items` (label + onTap) and separators.

---

## Overlays

### CKDialog
Wraps `showDialog` for brand-consistent dialogs. Provide `title`, `content`, `actions`.

There is a convenience helper for simple text-only informational dialogs:

```dart
await CKDialog.show(
  context: context,
  title: 'Info',
  content: Text('Operation completed successfully.'),
  confirmLabel: 'OK',
);
```

You can also control `maxWidth`/`maxHeight` and provide custom `confirmWidget`/`cancelWidget` instead of plain text labels.

### CKBottomSheet
Wraps `showModalBottomSheet` styling and maxHeight options.

### CKMenu
- Contextual dropdown overlay anchored to a `trigger` widget.
- Supply `items: List<CKMenuItem>` and attach per-item `onTap` handlers.
- Use `destructive: true` for high-risk actions like delete.

### CKPopover / CKTooltip
- Anchored helper overlays for richer contextual content and lightweight hints.

---

## Data Table

### CKDataTable
Powerful, stateless data table supporting sorting, pagination, selection and custom cell builders.

Key params
-- `columns` (List<CKTableColumn>): Column definitions.
- `rows` (List<Map<String, dynamic>>): Row data.
- `rowKey` (String): Field name to use as unique id.
- `title` / `subtitle` (String?): Card header.
- `totalCount` / `currentPage` / `pageSize` (int): Pagination.
- `onPageChanged` (ValueChanged<int>?): Page callback.
- `selectionMode` (TableSelectionMode): `none` / `single` / `multiple`.
- `selectedKeys` (Set): Controlled selection set.
- `onSelectionChanged` (ValueChanged<Set<dynamic>>?): Selection callback.
- `sortColumnKey` / `sortAscending` / `onSortChanged` — sorting control.
- `searchQuery` / `onSearchChanged` — optional search input.
- `isLoading`, `errorMessage`, `emptyMessage`, `emptyWidget` — state helpers.

Example
```dart
CKDataTable(
  columns: [CKTableColumn(key: 'id', label: 'ID')],
  rows: rows,
  rowKey: 'id',
  selectionMode: TableSelectionMode.multiple,
  onSelectionChanged: (s) => setState(() => _selected = s),
)
```

### CKTableColumn
Defines a single column.

Params
- `key` (String): Field key used to read row data.
- `label` (String): Column header.
-- `type` (CKColumnType): `text`, `badge`, `avatarText`, `progress`, `custom`.
- `width` (double?): Fixed pixel width.
- `flex` (int): Flex share when `width` is null.
- `minWidth` (double): Minimum width in compact mode.
- `sortable` (bool): Render sort affordance.
- `hidden` (bool): Omit column.
- `textAlign` (TextAlign): Cell alignment.
- `badgeVariantBuilder` (Function): For `badge` type mapping value→BadgeVariant.
- `cellBuilder` (Widget Function(dynamic, Map<String, dynamic>)?): Custom cell builder for `custom` type.

Helper
-- `CKTableColumn.fromStrings(List<String>)` creates basic columns from labels.

---

## Utilities & Exports
- `components.dart` aggregates exports for easy imports.
- Use `context.ckcoreTheme` to access `colors`, `typography`, `spacing`, `radius`, `motion`, `shadows`, `opacity`, `elevation`.

---
