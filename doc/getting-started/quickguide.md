# ckgoc_core Quick Guide

## Package structure

```
lib/
  ckgoc_core.dart          # single public barrel — import only this
  src/
    app/                   # CkgocApp — wraps MaterialApp with brand + theme
    foundation/            # Design tokens (colors, type, spacing, radius…)
      colors/              # CkgocPrimitiveColors + CkgocColors (semantic)
      typography/          # CkgocTypography (15 text styles)
      spacing/             # CkgocSpacing (4dp base grid)
      radius/              # CkgocRadius (none → full)
      elevation/           # CkgocElevation (0–16)
      shadows/             # CkgocShadows (light + dark BoxShadow lists)
      motion/              # CkgocMotion (durations + curves)
      opacity/             # CkgocOpacity (disabled, hover, scrim…)
      breakpoints/         # CkgocBreakpoints (xs → x2l width thresholds)
    themes/                # Theme resolution + brand files
      brands/
        castlekeep/        # CK colors, typography, light + dark theme data
        skygo/             # SkyGo colors, typography, light + dark theme data
      ckgoc_theme.dart   # InheritedWidget — context.ckgocTheme
      ckgoc_theme_data.dart  # Immutable data holder
      ckgoc_theme_resolver.dart  # Picks the right theme for brand + brightness
    components/            # All UI components
      buttons/             # CkgocButton, CkgocIconButton
      display/             # CkgocBadge, CkgocChip, CkgocAvatar, CkgocCard
      inputs/              # CkgocTextField, CkgocPasswordField, CkgocSearchField,
               # CkgocDropdown, CkgocNumberStepper, CkgocSwitch, CkgocOtpField,
               # CkgocCheckbox, CkgocRadio…
      feedback/            # CkgocProgressBar, CkgocSlider, CkgocLoader,
                           # CkgocLoadingState, CkgocAlert, CkgocSkeleton…
      navigation/          # Nav bars, tabs, breadcrumbs, menus
      overlays/            # Modals, drawers, toasts, snackbars
    templates/             # Full-screen layout templates (auth, CRUD, dashboard…)
    extensions/            # Dart/Flutter extension helpers
    utils/                 # Internal utilities

showcase/                  # Standalone Flutter app consuming ckgoc_core via path dep
  lib/
    screens/               # One screen per component category
```

---

## Access all tokens via `context.ckgocTheme`

```dart
final theme = context.ckgocTheme;
final t = theme.typography;
final s = theme.spacing;
final c = theme.colors;
final r = theme.radius;
final m = theme.motion;
final o = theme.opacity;
final e = theme.elevation;
final sh = theme.shadows;
```

## Brand scaffolding CLI

There is a small Dart CLI that scaffolds a new brand (colors, typography, light/dark theme files) and registers it in the theme resolver. Run it from the repository root:

```bash
dart run bin/ckgoc.dart add brand "Acme"
```

Generated files live under `lib/src/themes/brands/<brand>/`.
# Components Quick Guide

A concise reference for the package components. For full API details see the source in `lib/src/components/` and examples in the `showcase/` app.

---
A concise reference for the package components. Below are expanded, parameter-level docs and examples for each major component.

Note: For full type signatures refer to the source files in `lib/src/components/`.

---

## Buttons

### CkgocButton
Primary button with multiple variants and sizes.

Constructor params
- `variant` (ButtonVariant): Visual variant. Default: `primary`.
- `size` (ButtonSize): Size token (`xs, sm, md, lg, xl`). Default: `md`.
- `onPressed` (VoidCallback?): Tap callback; nullable to disable.
- `child` (Widget?): Content of the button (usually `Text`).
- `loading` (bool): Show a spinner instead of `child`.
- `disabled` (bool): Forces disabled state (`onPressed` null also disables).
- `isFullWidth` (bool): Expand to full width.

Example
```dart
CkgocButton(
  variant: ButtonVariant.primary,
  size: ButtonSize.md,
  onPressed: () {},
  child: Text('Save'),
)
```

Notes
- Use `isFullWidth` inside forms or footers for full-width actions.
- `loading` renders a progress indicator sized from spacing tokens.

### CkgocIconButton
Icon-only button.

Params
- `icon` (IconData): Required icon symbol.
- `onPressed` (VoidCallback?): Nullable to disable.
- `tooltip` (String?): Optional tooltip shown on hover/long-press.

Example
```dart
CkgocIconButton(icon: Icons.search, onPressed: () {});
```

### CkgocFab
Floating action button with optional `label` for extended FAB.

Params
- `icon` (IconData): Required.
- `onPressed` (VoidCallback?): Action.
- `label` (String?): When provided renders `FloatingActionButton.extended`.

Example
```dart
CkgocFab(icon: Icons.add, onPressed: () {}, label: 'Create');
```

---

## Inputs

### CkgocTextField
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
CkgocTextField(
  label: 'Email',
  hint: 'you@company.com',
  keyboardType: TextInputType.emailAddress,
  validator: (v) => v?.contains('@') == true ? null : 'Invalid email',
)
```

### CkgocPasswordField, CkgocSearchField, CkgocOtpField
- These components wrap `CkgocTextField` with specialized behaviors (visibility toggle, search actions, OTP digit cells). See `lib/src/components/inputs/` for props mirroring `CkgocTextField` plus small extras (e.g., `onSubmitted`, `length` for OTP).

### CkgocCheckbox / CkgocRadio / CkgocSwitch
- Standard form controls with `value`, `onChanged`, and an optional `label` or custom child. Use theme tokens for spacing and colors.

### CkgocDropdown<T>
Select input.

Params (high-level)
- `value` (T?): selected value.
- `items` (List<DropdownMenuItem<T>>): options.
- `onChanged` (ValueChanged<T?>?): selection callback.
- `hint` / `label` / `helperText` / `errorText` / `successText` — text-field style props.
- `menuMaxHeight` (double): max overlay height before internal scrolling. Default: `400`.
- `menuMinHeight` (double): preferred minimum space below the field before the menu flips above. Default: `144`.

Example
```dart
CkgocDropdown<String>(
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

Notes
- The dropdown follows the same visual tokens as `CkgocTextField` (filled background, outline, focus ring).
- The menu is a custom anchored overlay rendered below the field when possible and above it when the available height below is smaller than the minimum threshold.
- Use `helperText`, `errorText`, or `successText` to show contextual messages below the control.

### CkgocNumberStepper
Numeric stepper input that looks like a text field and uses `-` and `+` controls to change the value.

Params (high-level)
- `value` (int?): current value.
- `onChanged` (ValueChanged<int>?): increment/decrement callback.
- `min` / `max` (int?): optional lower and upper bounds.
- `step` (int): amount added or removed per tap.
- `hint` / `label` / `helperText` / `errorText` / `enabled` — text-field style props.

Example
```dart
CkgocNumberStepper(
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

### CkgocDatePicker / CkgocTimePicker
- Themed pickers that open platform dialogs. Provide `initialDate`, `firstDate`, `lastDate`, and `onChanged` callbacks.

---

## Display components

### CkgocCard
Composable card with title, subtitle, description, optional `media`, `action`, and `trailing` widgets.

Params
- `title` (String): Required header title.
- `subtitle` (String?): Optional subheading.
- `description` (String?): Body text.
- `media` (Widget?): Image or media placed top or left depending on `layout`.
- `action` (Widget?): Footer action (e.g., `CkgocButton`).
- `trailing` (Widget?): Trailing widget in the title row.
- `layout` (CardLayout): `vertical` (default) or `horizontal`.
- `variant` (CardVariant): `defaultCard`, `success`, `warning`, `error`, `info`.
- `onTap` (VoidCallback?): Makes the card tappable.

Example
```dart
CkgocCard(
  title: 'Card Title',
  subtitle: 'Category · Date',
  description: 'Short description',
  action: CkgocButton(...),
)
```

### CkgocBadge
Small tokenized badges for status or counts.

Params
- `label` (String): Visible text (or use `.count` constructor).
- `variant` (BadgeVariant): Visual variant (status, outline, pro, etc.).
- `count`/`maxCount` (int?): Count overload to render numeric badges.

Example
```dart
CkgocBadge(label: 'New', variant: BadgeVariant.primary);
CkgocBadge.count(count: 7);
```

### CkgocChip, CkgocAvatar, CkgocListTile, CkgocDivider
- Chips: `label`, `onTap`/`onDeleted`, `selected`.
- Avatar: `image`, `initials`, `size`.
- ListTile: `title`, `subtitle`, `leading`, `trailing`, `onTap`.
- Divider: thin themed divider; no props beyond standard padding.

### CkgocStepper / CkgocTimeline
- Progress UI primitives; take a list of `steps/events` (see `component_enums.dart` for shapes) and provide `currentIndex` / `status` props.

### CkgocContainer
- Utility wrapper accepting `child`, `padding`, `radius`, `elevationVariant`, and `background` overrides — use to compose tokenized panels.

### CkgocAccordion
- Accepts `items` (title + content) and optional `initiallyOpen` flags. See `component_enums` for `CkgocAccordionItem` shape.

---

## Feedback

### CkgocProgress / CkgocLoader
- Progress components accept `value` (0.0–1.0) or `null` for indeterminate, `variant` for color.

### CkgocSkeleton
- Accepts layout hints (rows, columns, shapes) and `isLoading` to render placeholder shapes.

### CkgocToast / CkgocSnackbar
- Lightweight transient messages with `message`, `variant`, and action callback.

### CkgocAlert
- Inline alert with `title`, `message`, `variant`, and `dismissible`.

### CkgocEmptyState / CkgocErrorState / CkgocLoadingState
- Standardized full-card states. Provide `title`, `subtitle`, `action` and optional illustration widget.

---

## Navigation

### CkgocAppBar
App bar with tokenized title, leading, actions and optional `elevation`.

Params
- `title` (Widget/ String), `leading` (Widget?), `actions` (List<Widget>?).

### CkgocBottomNavigation, CkgocNavigationRail, CkgocSideNav, CkgocDrawer
- Navigation primitives accept a list of destinations (see `CkgocSideNavItem` and related shapes in `component_enums.dart`) and callbacks for selection.

### CkgocTabs
- Accepts `tabs` and `controller` or `onTap`.

### CkgocBreadcrumb
- Accepts `items` (label + onTap) and separators.

---

## Overlays

### CkgocDialog
Wraps `showDialog` for brand-consistent dialogs. Provide `title`, `content`, `actions`.

### CkgocBottomSheet
Wraps `showModalBottomSheet` styling and maxHeight options.

### CkgocMenu
- Contextual dropdown overlay anchored to a `trigger` widget.
- Supply `items: List<CkgocMenuItem>` and attach per-item `onTap` handlers.
- Use `destructive: true` for high-risk actions like delete.

### CkgocPopover / CkgocTooltip
- Anchored helper overlays for richer contextual content and lightweight hints.

---

## Data Table

### CkgocDataTable
Powerful, stateless data table supporting sorting, pagination, selection and custom cell builders.

Key params
- `columns` (List<CkgocTableColumn>): Column definitions.
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
CkgocDataTable(
  columns: [CkgocTableColumn(key: 'id', label: 'ID')],
  rows: rows,
  rowKey: 'id',
  selectionMode: TableSelectionMode.multiple,
  onSelectionChanged: (s) => setState(() => _selected = s),
)
```

### CkgocTableColumn
Defines a single column.

Params
- `key` (String): Field key used to read row data.
- `label` (String): Column header.
- `type` (CkgocColumnType): `text`, `badge`, `avatarText`, `progress`, `custom`.
- `width` (double?): Fixed pixel width.
- `flex` (int): Flex share when `width` is null.
- `minWidth` (double): Minimum width in compact mode.
- `sortable` (bool): Render sort affordance.
- `hidden` (bool): Omit column.
- `textAlign` (TextAlign): Cell alignment.
- `badgeVariantBuilder` (Function): For `badge` type mapping value→BadgeVariant.
- `cellBuilder` (Widget Function(dynamic, Map<String, dynamic>)?): Custom cell builder for `custom` type.

Helper
- `CkgocTableColumn.fromStrings(List<String>)` creates basic columns from labels.

---

## Utilities & Exports
- `components.dart` aggregates exports for easy imports.
- Use `context.ckgocTheme` to access `colors`, `typography`, `spacing`, `radius`, `motion`, `shadows`, `opacity`, `elevation`.

---
