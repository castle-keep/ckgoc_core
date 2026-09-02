# CKCoreUI Workshop Presentation

---

# Slide 1: Welcome

## Slide
- **CKCoreUI** — shared Flutter UI library
- Covers: theming, tokens, and ready-to-use components
- Goal: consistent UI across products without reinventing each widget
- We'll go through setup, the theme system, and every component

## Speaker Notes
- This is a hands-on walkthrough — I'll show everything live on the docs site
- The library is in active use; some stubs exist and are called out explicitly
- Ask questions as we go

---

# Slide 2: What is CKCoreUI?

## Slide
- A Flutter package (`ckcoreui`) that provides:
  - A multi-brand theme engine
  - Design tokens (colors, spacing, typography, radius, elevation, motion, shadows, opacity, breakpoints)
  - ~40 production components across 6 categories
- Two active brands: **CastleKeep** and **SkyGo**
- Light and dark mode support per brand

## Speaker Notes
- Each brand has its own color palette and typography scale
- All components read from the theme automatically — you never hardcode colors
- Adding a new brand requires only a new theme file + one resolver entry

---

# Slide 3: Package Structure

## Slide
```
lib/
├── ckcoreui.dart             ← main barrel export
├── ckcore_core.dart          ← alternate barrel
└── src/
    ├── app/                  ← CKApp (MaterialApp wrapper)
    ├── foundation/           ← design tokens
    │   ├── colors/
    │   ├── typography/
    │   ├── spacing/
    │   ├── radius/
    │   ├── elevation/
    │   ├── shadows/
    │   ├── motion/
    │   ├── opacity/
    │   └── breakpoints/
    ├── themes/               ← brand definitions
    │   └── brands/
    │       ├── castlekeep/
    │       └── skygo/
    └── components/           ← UI widgets
        ├── buttons/
        ├── inputs/
        ├── display/
        ├── feedback/
        ├── navigation/
        ├── overlays/
        └── data_table/
```

## Speaker Notes
- Everything is exported from the top-level barrels — you only need one import
- The `foundation/` folder holds pure data classes, no widgets
- `component_enums.dart` holds all shared enums and lightweight model classes
- Do NOT import individual source files; always import the package

---

# Slide 4: Adding CKCoreUI to a Project

## Slide
**pubspec.yaml**
```yaml
dependencies:
  ckcoreui: ^0.4.2
```

**Import**
```dart
import 'package:ckcoreui/ckcoreui.dart';
```

## Speaker Notes
- One import covers everything: components, tokens, theme
- Check pubspec for the current version/path

---

# Slide 5: The Theme System

## Slide
- All tokens live in `CkcoreuiThemeData`
- Tokens bundled into families:
  - `colors`, `typography`, `spacing`, `radius`
  - `elevation`, `shadows`, `motion`, `opacity`, `breakpoints`
- Brand + brightness → resolved automatically by `ckcoreThemeResolver`
- Theme is provided to the tree via `CkcoreuiTheme` (InheritedWidget)

## Speaker Notes
- You never construct `CkcoreuiThemeData` manually in app code
- `CKApp` handles resolution end-to-end
- `context.ckcoreTheme` gives you the active theme anywhere below `CKApp`

---

# Slide 6: Accessing Tokens

## Slide
```dart
// Recommended — context extensions
context.ckColors.primary
context.ckSpacing.md
context.ckTypography.textMd
context.ckRadius.lg

// Static accessors (same result)
CKColors.of(context).primary
CKSpacing.of(context).md

// Full theme object
context.ckcoreTheme.colors.primary
context.ckcoreTheme.spacing.md
```

## Speaker Notes
- The extension form is the cleanest and is preferred in component code
- Static accessors (`CKColors.of`) are useful for utility functions that receive a `BuildContext`
- All three forms return the same data — pick one style and be consistent

---

# Slide 7: Theme Injection — CKApp

## Slide

**`CKApp`** is the drop-in replacement for `MaterialApp`

```dart
// Standard navigation
CKApp(
  brand: ckcoreBrand.castleKeep,
  home: HomePage(),
)

// GoRouter / Navigator 2.0
CKApp.router(
  brand: ckcoreBrand.castleKeep,
  routerConfig: goRouter,
)

// Stacked / manual delegate
CKApp.delegate(
  brand: ckcoreBrand.castleKeep,
  routerDelegate: stackedRouter.delegate(),
  routeInformationParser: stackedRouter.defaultRouteParser(),
)
```

## Speaker Notes
- `CKApp` wraps `MaterialApp` and injects both the Material `ThemeData` and the `CkcoreuiTheme` InheritedWidget
- You can still pass `theme`, `darkTheme`, `themeMode` to override specific Material tokens if needed
- `brightness` param forces light or dark; leave it null to follow system setting
- `responsive: true` wraps the app in a responsive layout provider

---

# Slide 8: What CKApp Themes for You

## Slide
When you use `CKApp`, the following Material widgets are automatically styled:

| Material Widget | CK Equivalent / Covered By |
|---|---|
| `ElevatedButton` | `CKButton()` |
| `OutlinedButton` | `CKButton.outline()` |
| `TextButton` | `CKButton.ghost()` |
| `FloatingActionButton` | `CKFab` |
| `AppBar` | `CKAppBar` |
| `SnackBar` | `CKSnackbar.show()` |
| `Switch` | `CKSwitch` |
| `Checkbox` | `CKCheckbox` |
| `RadioButton` | `CKRadio` |
| `LinearProgressIndicator` | `CKProgressBar` |

## Speaker Notes
- Material widget theming is applied via the resolved `ThemeData` inside `CKApp`
- Even if you accidentally use `ElevatedButton` directly, it will pick up brand colors
- CK wrappers give you named constructors, variant theming, and loading states on top

---

# Slide 9: Brands

## Slide
```dart
enum ckcoreBrand {
  castleKeep,   // deep navy, gold accents, stone grey
  skyGo,        // sky blue, violet accents, modern
}
```

- Switch brand at the `CKApp` level — one line change
- Each brand has a light and dark implementation

## Speaker Notes
- Brand switching is instant — no code changes below `CKApp`
- Both brands are fully implemented and production-ready
- The `ckcoreThemeResolver` uses a `switch` pattern — show the file if asked

---

# Slide 10: Components Overview

## Slide
| Category | Components |
|---|---|
| **Buttons** | CKButton, CKFab, CKIconButton |
| **Inputs** | CKTextField, CKPasswordField, CKSearchField, CKDropdown, CKCheckbox, CKSwitch, CKRadio, CKOtpField, CKNumberStepper, CKDatePicker*, CKTimePicker* |
| **Display** | CKAvatar, CKAvatarGroup, CKBadge, CKFilterChip, CKInputChip, CKCard, CKContainer, CKAccordion, CKStepper, CKTimeline, CKDivider*, CKListTile* |
| **Feedback** | CKAlert, CKToast, CKSnackbar, CKLoader, CKProgressBar, CKSlider, CKSkeleton*, CKEmptyState*, CKErrorState*, CKLoadingState |
| **Navigation** | CKAppBar, CKTabs, CKBottomNavigation, CKDrawer, CKSideNav, CKBreadcrumb*, CKNavigationRail* |
| **Overlays** | CKDialog, CKBottomSheet, CKMenu, CKTooltip*, CKPopover* |
| **Data Table** | CKDataTable + CKTableColumn |

*stub — API defined, rendering not yet implemented*

## Speaker Notes
- Stubs have their constructor + parameter API finalized; they just render `SizedBox.shrink()` currently
- Don't use stubs in production screens yet
- All non-stub components are live on the docs site

---

# Slide 11: CKButton

### Component: `CKButton`

#### Purpose
- Primary action button with eight semantic variants
- Use when you need a tappable action with visual emphasis

#### Constructors (9)
| Constructor | Variant |
|---|---|
| `CKButton()` | primary |
| `CKButton.secondary()` | secondary |
| `CKButton.outline()` | outline |
| `CKButton.ghost()` | ghost |
| `CKButton.accent()` | accent |
| `CKButton.destructive()` | destructive |
| `CKButton.success()` | success |
| `CKButton.warning()` | warning |
| `CKButton.info()` | info |

#### Parameters (6)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `variant` | `ButtonVariant` | No | `ButtonVariant.primary` | Visual style variant |
| `size` | `ButtonSize` | No | `ButtonSize.md` | xs / sm / md / lg / xl |
| `onPressed` | `VoidCallback?` | No | `null` | Tap handler; null = disabled |
| `child` | `Widget?` | No | `null` | Button label / content |
| `loading` | `bool` | No | `false` | Shows spinner, disables tap |
| `disabled` | `bool` | No | `false` | Visually disabled, no tap |
| `isFullWidth` | `bool` | No | `false` | Stretches to parent width |
 
**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- Show all variants side by side on the docs site
- Emphasize `destructive` for irreversible actions — gives clear red styling
- Common mistake: forgetting to set `onPressed: null` while `loading: true`
- Question: Why are `loading` and `disabled` boolean parameters instead of handling them outside the button?
- Answer: These are common UI states that affect both appearance and interaction. Keeping them in the component provides consistent visuals and behavior across the application while reducing repetitive boilerplate.


---

# Slide 12: CKButton — Usage

#### Example
```dart
CKButton(
  onPressed: () => save(),
  child: const Text('Save'),
)

CKButton.destructive(
  size: ButtonSize.sm,
  loading: _isSaving,
  onPressed: () => delete(),
  child: const Text('Delete'),
)
```

#### Notes
- `onPressed: null` and `disabled: true` both prevent interaction, but `onPressed: null` also removes the visual tap feedback
- `loading: true` overrides `disabled` visually — always set `onPressed: null` during async operations too
- `ButtonSize` affects padding and font size, not the variant color


## Speaker Notes
- Show all variants side by side on the docs site
- Emphasize `destructive` for irreversible actions — gives clear red styling
- Common mistake: forgetting to set `onPressed: null` while `loading: true`

---

# Slide 13: CKFab

### Component: `CKFab`

#### Purpose
- Floating action button for the most prominent action on a screen
- Pass `label` to get an extended FAB

#### Constructors
| Constructor | Notes |
|---|---|
| `CKFab()` | Standard and extended (via `label`) |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `icon` | `IconData` | Yes | — | Icon displayed in the button |
| `onPressed` | `VoidCallback?` | No | `null` | Tap handler |
| `label` | `String?` | No | `null` | When set, renders as extended FAB |


## Speaker Notes
- FAB is typically placed in `Scaffold.floatingActionButton`
- Avoid using FAB for secondary actions — one FAB per screen max

---

# Slide 14: CKFab — Usage

#### Example
```dart
CKFab(
  icon: LucideIcons.plus,
  onPressed: () => createNew(),
)

CKFab(
  icon: LucideIcons.plus,
  label: 'New Record',
  onPressed: () => createNew(),
)
```

#### Notes
- Use Lucide icons for consistency — the package ships `lucide_icons_flutter`
- Extended FAB is automatically used when `label != null`; no separate constructor needed


## Speaker Notes
- FAB is typically placed in `Scaffold.floatingActionButton`
- Avoid using FAB for secondary actions — one FAB per screen max

---

# Slide 15: CKIconButton

### Component: `CKIconButton`

#### Purpose
- Compact icon-only button
- Use in toolbars, list rows, or any place where a full-width button is too heavy

#### Constructors
| Constructor | Notes |
|---|---|
| `CKIconButton()` | Single constructor |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `icon` | `IconData` | Yes | — | Icon to display |
| `onPressed` | `VoidCallback?` | No | `null` | Tap handler; null = disabled |
| `tooltip` | `String?` | No | `null` | Accessibility tooltip on long-press |


## Speaker Notes
- Renders with consistent padding and `md` border radius from the theme
- The overlay color on hover uses `primaryHover` token automatically

---

# Slide 16: CKIconButton — Usage

#### Example
```dart
CKIconButton(
  icon: LucideIcons.settings,
  tooltip: 'Settings',
  onPressed: () => openSettings(),
)
```

#### Notes
- Disabled state is handled via `onPressed: null` — no explicit `disabled` param
- Always set `tooltip` for accessibility


## Speaker Notes
- Renders with consistent padding and `md` border radius from the theme
- The overlay color on hover uses `primaryHover` token automatically

---

# Slide 17: CKTextField

### Component: `CKTextField`

#### Purpose
- General-purpose text input with label, helper, error, and success states
- Foundation for `CKPasswordField`, `CKSearchField`, and `CKNumberStepper`

#### Constructors
| Constructor | Notes |
|---|---|
| `CKTextField()` | Single constructor |

#### Parameters (17)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `controller` | `TextEditingController?` | No | `null` | External controller |
| `focusNode` | `FocusNode?` | No | `null` | External focus node |
| `label` | `String?` | No | `null` | Floating label above input |
| `hint` | `String?` | No | `null` | Placeholder text |
| `helperText` | `String?` | No | `null` | Hint below the field |
| `errorText` | `String?` | No | `null` | Error message; turns border red |
| `successText` | `String?` | No | `null` | Success message; shown after dirty + valid |
| `leading` | `Widget?` | No | `null` | Widget prepended inside the field |
| `trailing` | `Widget?` | No | `null` | Widget appended inside the field |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Called on every keystroke |
| `onEditingComplete` | `VoidCallback?` | No | `null` | Called on done/enter |
| `validator` | `String? Function(String?)?` | No | `null` | Inline validation; runs on change |
| `enabled` | `bool` | No | `true` | Disabled state |
| `isRequired` | `bool` | No | `false` | When true enforces a required validator and appends a red `*` to the label |
| `maxLines` | `int?` | No | `1` | Multi-line when > 1 |
| `keyboardType` | `TextInputType?` | No | `null` | Keyboard type hint |
| `obscureText` | `bool` | No | `false` | Masks input |
| `textInputAction` | `TextInputAction?` | No | `null` | Keyboard action button |
| `autoFocus` | `bool` | No | `false` | Request focus on mount |
| `borderless` | `bool` | No | `false` | No border/background — for inline table cells |
| `inputFormatters` | `List<TextInputFormatter>?` | No | `null` | Input restriction/formatting |
| `textAlign` | `TextAlign?` | No | `null` | Text alignment inside the field |


## Speaker Notes
- This is the most-used input — know it well
- `errorText` from parent state overrides inline `validator` result
- Multi-line: `maxLines: null` = unlimited; `maxLines: 5` = fixed 5 lines

---

# Slide 18: CKTextField — Usage

#### Example
```dart
CKTextField(
  label: 'Email',
  hint: 'you@example.com',
  keyboardType: TextInputType.emailAddress,
  onChanged: (v) => setState(() => _email = v),
  validator: (v) => v!.contains('@') ? null : 'Invalid email',
)
```

#### Notes
- `validator` runs on every `onChanged` call once the field is "dirty" (first change)
- `successText` only shows after the field is dirty and `validator` returns null
- `borderless: true` is intended for inline table cell editing — do not use it in forms


## Speaker Notes
- This is the most-used input — know it well
- `errorText` from parent state overrides inline `validator` result
- Multi-line: `maxLines: null` = unlimited; `maxLines: 5` = fixed 5 lines

---

# Slide 19: CKPasswordField

### Component: `CKPasswordField`

#### Purpose
- Password input with a built-in visibility toggle button
- Thin wrapper over `CKTextField`

#### Constructors
| Constructor | Notes |
|---|---|
| `CKPasswordField()` | Single constructor |

#### Parameters (10)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `controller` | `TextEditingController?` | No | `null` | External controller |
| `focusNode` | `FocusNode?` | No | `null` | External focus node |
| `label` | `String?` | No | `null` | Floating label |
| `hint` | `String?` | No | `'Enter password'` | Placeholder text |
| `helperText` | `String?` | No | `null` | Helper below the field |
| `errorText` | `String?` | No | `null` | Error message |
| `validator` | `String? Function(String?)?` | No | `null` | Inline validator used on change. |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Change callback |
| `onEditingComplete` | `VoidCallback?` | No | `null` | Done callback |
| `enabled` | `bool` | No | `true` | Disabled state |
| `textInputAction` | `TextInputAction?` | No | `null` | Keyboard action button |
| `autoFocus` | `bool` | No | `false` | Auto-focus on mount |


## Speaker Notes
- Common pattern: disable the submit button until `_password.length >= 8`

---

# Slide 20: CKPasswordField — Usage

#### Example
```dart
CKPasswordField(
  label: 'Password',
  errorText: _passwordError,
  onChanged: (v) => setState(() => _password = v),
)
```

#### Notes
- The eye icon toggle is built-in — do not add a custom `trailing`
- Use `CKTextField` directly if you need full control over obscuring logic


## Speaker Notes
- Common pattern: disable the submit button until `_password.length >= 8`

---

# Slide 21: CKSearchField

### Component: `CKSearchField`

#### Purpose
- Search input with a prepended search icon and optional clear button
- Thin wrapper over `CKTextField`

#### Constructors
| Constructor | Notes |
|---|---|
| `CKSearchField()` | Single constructor |

#### Parameters (7)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `controller` | `TextEditingController?` | No | `null` | External controller |
| `focusNode` | `FocusNode?` | No | `null` | External focus node |
| `hint` | `String?` | No | `'Search...'` | Placeholder text |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Change callback |
| `onClear` | `VoidCallback?` | No | `null` | If set, shows an X clear button |
| `enabled` | `bool` | No | `true` | Disabled state |
| `autoFocus` | `bool` | No | `false` | Auto-focus on mount |


## Speaker Notes
- Pair with `CKDataTable.onSearchChanged` for table filtering, or manage state yourself for custom lists

---

# Slide 22: CKSearchField — Usage

#### Example
```dart
CKSearchField(
  controller: _searchController,
  hint: 'Search members...',
  onChanged: (v) => _filter(v),
  onClear: () {
    _searchController.clear();
    _filter('');
  },
)
```

#### Notes
- The clear button only appears when `onClear != null` — clearing logic is your responsibility
- For the `CKDataTable` built-in search, pass `onSearchChanged` to the table instead


## Speaker Notes
- Pair with `CKDataTable.onSearchChanged` for table filtering, or manage state yourself for custom lists

---

# Slide 23: CKDropdown

### Component: `CKDropdown<T>`

#### Purpose
- Styled dropdown select matching `CKTextField` visuals
- Opens as a custom overlay (not the native `DropdownButton`)

#### Constructors
| Constructor | Notes |
|---|---|
| `CKDropdown()` | Single constructor, generic type T |

#### Parameters (16)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `items` | `List<DropdownMenuItem<T>>?` | No | `null` | Selectable options |
| `value` | `T?` | No | `null` | Currently selected value |
| `onChanged` | `ValueChanged<T?>?` | No | `null` | Called on selection |
| `label` | `String?` | No | `null` | Floating label |
| `hint` | `String?` | No | `null` | Placeholder text |
| `helperText` | `String?` | No | `null` | Helper below the field |
| `errorText` | `String?` | No | `null` | Error message; takes precedence over `validator` |
| `successText` | `String?` | No | `null` | Success message |
| `leading` | `Widget?` | No | `null` | Icon/widget inside field (left) |
| `trailing` | `Widget?` | No | `null` | Icon/widget inside field (right) |
| `enabled` | `bool` | No | `true` | Disabled state |
| `borderless` | `bool` | No | `false` | No border/background |
| `isRequired` | `bool` | No | `false` | When true enforces a required selection and appends a red `*` to the label |
| `validator` | `String? Function(T?)?` | No | `null` | Inline validation; runs on change after first selection |
| `menuMaxHeight` | `double` | No | `400` | Max height of the dropdown overlay |
| `menuMinHeight` | `double` | No | `144` | Min height of the dropdown overlay |


## Speaker Notes
- The overlay closes on outside tap automatically
- Empty `items` list or `enabled: false` prevents opening

---

# Slide 24: CKDropdown<T> — Usage

#### Example (basic)
```dart
CKDropdown<String>(
  label: 'Country',
  value: _country,
  items: ['PH', 'SG', 'US'].map((c) =>
    DropdownMenuItem(value: c, child: Text(c))
  ).toList(),
  onChanged: (v) => setState(() => _country = v),
)
```

#### Example (with validation)
```dart
CKDropdown<String>(
  label: 'Role',
  value: _role,
  items: const [
    DropdownMenuItem(value: 'admin', child: Text('Admin')),
    DropdownMenuItem(value: 'user', child: Text('User')),
  ],
  validator: (v) => v == null ? 'Please select a role' : null,
  onChanged: (v) => setState(() => _role = v),
)
```

#### Notes
- Uses `DropdownMenuItem<T>` from Flutter Material — familiar API
- Menu position (above/below) is calculated automatically from available space
- `validator` runs only after the user makes their first selection (dirty state)
- Explicit `errorText` takes precedence over `validator` result


## Speaker Notes
- The overlay closes on outside tap automatically
- Empty `items` list or `enabled: false` prevents opening
- Show the validation example live on the docs site — tap to select, watch error clear

---

# Slide 25: CKCheckbox

### Component: `CKCheckbox`

#### Purpose
- Styled checkbox with optional label and semantic variant coloring
- Supports tri-state (checked / unchecked / indeterminate)

#### Constructors
| Constructor | Notes |
|---|---|
| `CKCheckbox()` | Single constructor |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `bool?` | Yes | — | `true` = checked, `false` = unchecked, `null` = indeterminate |
| `onChanged` | `ValueChanged<bool?>?` | No | `null` | Tap handler; null = disabled |
| `label` | `String?` | No | `null` | Optional text label beside the checkbox |
| `variant` | `SwitchVariant?` | No | `null` | `success` or `error` for colored fill |



## Speaker Notes
- Touch target is `spacing.lg` (48dp) for accessibility, even though the box itself is `spacing.md`

---

# Slide 26: CKCheckbox — Usage

#### Example
```dart
CKCheckbox(
  value: _agreed,
  label: 'I agree to the terms',
  onChanged: (v) => setState(() => _agreed = v ?? false),
)
```

#### Notes
- Indeterminate state (`null`) renders a minus icon inside the checkbox
- `variant: SwitchVariant.error` is useful for highlighting a required checkbox that was skipped


## Speaker Notes
- Touch target is `spacing.lg` (48dp) for accessibility, even though the box itself is `spacing.md`

---

# Slide 27: CKSwitch

### Component: `CKSwitch`

#### Purpose
- Toggle switch with label support and optional semantic variant
- Use for settings and binary on/off controls

#### Constructors
| Constructor | Variant |
|---|---|
| `CKSwitch()` | neutral (uses primary color) |
| `CKSwitch.success()` | green when enabled |
| `CKSwitch.error()` | red when enabled |

#### Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `bool` | Yes | — | Current on/off state |
| `onChanged` | `ValueChanged<bool>?` | No | `null` | State change callback; null = disabled |
| `label` | `String?` | No | `null` | Text label beside the switch |
| `variant` | `SwitchVariant?` | No | `null` | `success` or `error` |
| `color` | `Color?` | No | `null` | Custom active track color (overrides variant) |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- Use `CKSwitch.error` only for indicating a misconfigured/dangerous toggle — not just for red color

---

# Slide 28: CKSwitch — Usage

#### Example
```dart
CKSwitch(
  value: _notificationsEnabled,
  label: 'Enable notifications',
  onChanged: (v) => setState(() => _notificationsEnabled = v),
)
```

#### Notes
- `color` takes precedence over `variant`
- Disabled state via `onChanged: null` animates to reduced opacity automatically


## Speaker Notes
- Use `CKSwitch.error` only for indicating a misconfigured/dangerous toggle — not just for red color

---

# Slide 29: CKRadio

### Component: `CKRadio<T>`

#### Purpose
- Radio button for selecting a single value within a group
- Generic type `T` — works with strings, enums, ints, etc.

#### Constructors
| Constructor | Notes |
|---|---|
| `CKRadio()` | Single constructor, generic |
| `CKRadio.success()` | Named constructor for success-accent radios |
| `CKRadio.error()` | Named constructor for error-accent radios |

#### Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `T` | Yes | — | The value this radio represents |
| `groupValue` | `T?` | No | `null` | Currently selected value in the group |
| `onChanged` | `ValueChanged<T?>?` | No | `null` | Called when this radio is selected; null = disabled |
| `label` | `String?` | No | `null` | Text label beside the radio |
| `variant` | `SwitchVariant?` | No | `null` | `success` or `error` coloring |
 
**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- Pattern: one `setState` variable, pass the same variable as `groupValue` to all radios in the group

---

# Slide 30: CKRadio<T> — Usage

#### Example
```dart
Column(
  children: ['Male', 'Female', 'Other'].map((v) => CKRadio<String>(
    value: v,
    groupValue: _gender,
    label: v,
    onChanged: (v) => setState(() => _gender = v),
  )).toList(),
)
```

#### Notes
- You must maintain `groupValue` state yourself — there is no internal group management
- All radios in a group must share the same `groupValue` variable


## Speaker Notes
- Pattern: one `setState` variable, pass the same variable as `groupValue` to all radios in the group

---

# Slide 31: CKOtpField

### Component: `CKOtpField`

#### Purpose
- OTP / PIN input rendered as separate digit cells
- Handles focus and input capture internally

#### Constructors
| Constructor | Notes |
|---|---|
| `CKOtpField()` | Single constructor |

#### Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `length` | `int` | No | `6` | Number of OTP digits |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Called on every keystroke |
| `onCompleted` | `ValueChanged<String>?` | No | `null` | Called when all cells are filled |
| `autoFocus` | `bool` | No | `false` | Auto-focus the field on mount |
| `enabled` | `bool` | No | `true` | Disabled state |


## Speaker Notes
- Good fit for SMS verification, PIN entry
- `length: 4` for PIN, `length: 6` for OTP codes

---

# Slide 32: CKOtpField — Usage

#### Example
```dart
CKOtpField(
  length: 6,
  autoFocus: true,
  onCompleted: (code) => verify(code),
)
```

#### Notes
- Accepts numeric input only (digits filtered internally)
- Uses a single hidden `TextField` underneath — keyboard behavior is native
- `onCompleted` auto-unfocuses the keyboard after the last digit


## Speaker Notes
- Good fit for SMS verification, PIN entry
- `length: 4` for PIN, `length: 6` for OTP codes

---

# Slide 33: CKNumberStepper

### Component: `CKNumberStepper`

#### Purpose
- Integer input with increment/decrement buttons
- Enforces optional min/max bounds

#### Constructors
| Constructor | Notes |
|---|---|
| `CKNumberStepper()` | Single constructor |

#### Parameters (11)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `int?` | Yes | — | Current value |
| `onChanged` | `ValueChanged<int>?` | No | `null` | Called on value change; null = disabled |
| `label` | `String?` | No | `null` | Floating label |
| `hint` | `String?` | No | `null` | Placeholder text |
| `helperText` | `String?` | No | `null` | Helper below the field |
| `errorText` | `String?` | No | `null` | Error message |
| `successText` | `String?` | No | `null` | Success message |
| `min` | `int?` | No | `null` | Minimum allowed value |
| `max` | `int?` | No | `null` | Maximum allowed value |
| `step` | `int` | No | `1` | Increment/decrement amount |
| `enabled` | `bool` | No | `true` | Disabled state |
| `borderless` | `bool` | No | `false` | No border/background |


## Speaker Notes
- `step: 5` for quantities in multiples of 5, etc.
- Keyboard input is allowed in addition to the +/- buttons

---

# Slide 34: CKNumberStepper — Usage

#### Example
```dart
CKNumberStepper(
  value: _quantity,
  label: 'Quantity',
  min: 1,
  max: 99,
  onChanged: (v) => setState(() => _quantity = v),
)
```

#### Notes
- Clamping is visual only during typing — `onChanged` always fires with the clamped value
- A brief error flash appears when the user attempts to exceed bounds


## Speaker Notes
- `step: 5` for quantities in multiples of 5, etc.
- Keyboard input is allowed in addition to the +/- buttons

---

# Slide 35: CKBadge

### Component: `CKBadge`

#### Purpose
- Compact label for status indicators, tags, and counts
- 15 named constructors covering all semantic and status variants

#### Constructors
| Constructor | Variant |
|---|---|
| `CKBadge()` | primary |
| `CKBadge.success()` | success |
| `CKBadge.warning()` | warning |
| `CKBadge.error()` | error |
| `CKBadge.info()` | info |
| `CKBadge.draft()` | draft |
| `CKBadge.live()` | live |
| `CKBadge.newBadge()` | new |
| `CKBadge.beta()` | beta |
| `CKBadge.pro()` | pro |
| `CKBadge.outline()` | outline |
| `CKBadge.outlineSuccess()` | outline success |
| `CKBadge.outlineError()` | outline error |
| `CKBadge.online()` | online status |
| `CKBadge.away()` | away status |
| `CKBadge.busy()` | busy status |
| `CKBadge.offline()` | offline status |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `label` | `String` | Yes | — | Display text |
| `variant` | `BadgeVariant` | No | `BadgeVariant.primary` | Visual variant |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

---

# Slide 36: CKBadge — Usage

#### Example
```dart
CKBadge.live(label: 'Live')
CKBadge.beta(label: 'Beta', count: 3)
CKBadge.error(label: 'Failed')
```

#### Notes
- Status variants (online/away/busy/offline) include a colored dot
- `pro` and `beta` use gradient fills — do not override color via theme directly



---

# Slide 37: CKFilterChip / CKInputChip

### Components: `CKFilterChip`, `CKInputChip`

#### Purpose
- `CKFilterChip` — selectable filter tag (toggle on/off)
- `CKInputChip` — removable tag (e.g., multi-select pills, tags)

#### CKFilterChip Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `label` | `String` | Yes | — | Chip text |
| `selected` | `bool` | No | `false` | Selected/active state |
| `onTap` | `VoidCallback?` | No | `null` | Tap handler |
| `state` | `ChipState` | No | `ChipState.defaultState` | `defaultState / draft / selected / disabled / error` |

#### CKInputChip Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `label` | `String` | Yes | — | Chip text |
| `onRemove` | `VoidCallback?` | No | `null` | Called when X is tapped |
| `state` | `ChipState` | No | `ChipState.defaultState` | Chip state |
| `leading` | `Widget?` | No | `null` | Optional leading widget (e.g., avatar) |


## Speaker Notes
- `ChipState.disabled` prevents tap; apply it instead of setting `onTap: null` for semantic correctness
- `CKFilterChip` shows a checkmark icon when `selected: true`

---

# Slide 38: CKFilterChip / CKInputChip — Usage

#### Example
```dart
// Filter chip
CKFilterChip(
  label: 'Active',
  selected: _filters.contains('Active'),
  onTap: () => _toggleFilter('Active'),
)

// Input chip with avatar
CKInputChip(
  label: 'John Doe',
  leading: CKAvatar(initials: 'JD', size: AvatarSize.xs),
  onRemove: () => _removeTag('JD'),
)
```


## Speaker Notes
- `ChipState.disabled` prevents tap; apply it instead of setting `onTap: null` for semantic correctness
- `CKFilterChip` shows a checkmark icon when `selected: true`

---

# Slide 39: CKAvatar / CKAvatarGroup

### Components: `CKAvatar`, `CKAvatarGroup`

#### Purpose
- `CKAvatar` — user/entity avatar with initials, image, or icon, plus optional presence dot
- `CKAvatarGroup` — overlapping stack of multiple avatars

#### CKAvatar Parameters (6)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `initials` | `String?` | No | `null` | 1–2 characters shown when no image |
| `image` | `ImageProvider?` | No | `null` | Photo/image source |
| `size` | `AvatarSize` | No | `AvatarSize.md` | xs / sm / md / lg / xl / x2l / x3l |
| `status` | `AvatarStatus?` | No | `null` | `online / away / busy / offline` |
| `backgroundColor` | `Color?` | No | `null` | Override auto-computed bg color |
| `square` | `bool` | No | `false` | Square with rounded corners instead of circle |


## Speaker Notes
- Size tokens map to specific spacing values — don't set a custom size manually
- `CKAvatarGroup` handles overlap and "+N more" truncation automatically

---

# Slide 40: CKAvatar / CKAvatarGroup — Usage

#### Example
```dart
CKAvatar(
  initials: 'AB',
  size: AvatarSize.lg,
  status: AvatarStatus.online,
)

CKAvatarGroup(
  avatars: [
    CKAvatar(initials: 'AB'),
    CKAvatar(initials: 'CD'),
    CKAvatar(image: NetworkImage('...')),
  ],
)
```

#### Notes
- Background color when using initials is deterministically chosen from a palette based on the initials — consistent per user
- Shows a generic user icon when both `initials` and `image` are null


## Speaker Notes
- Size tokens map to specific spacing values — don't set a custom size manually
- `CKAvatarGroup` handles overlap and "+N more" truncation automatically

---

# Slide 41: CKCard

### Component: `CKCard`

#### Purpose
- Content card with optional media, description, action slot, and trailing area
- Supports vertical and horizontal layouts with semantic color variants

#### Constructors
| Constructor | Variant |
|---|---|
| `CKCard()` | default (neutral) |
| `CKCard.success()` | success (green tint) |
| `CKCard.warning()` | warning (orange tint) |
| `CKCard.error()` | error (red tint) |
| `CKCard.info()` | info (blue tint) |

#### Parameters (12)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `title` | `String` | Yes | — | Card heading |
| `subtitle` | `String?` | No | `null` | Secondary heading |
| `description` | `String?` | No | `null` | Body text |
| `media` | `Widget?` | No | `null` | Image or icon area |
| `action` | `Widget?` | No | `null` | Primary action widget (e.g., button) |
| `trailing` | `Widget?` | No | `null` | Trailing widget (e.g., icon, badge) |
| `mediaAlignment` | `ContentAlignment` | No | `ContentAlignment.center` | Media placement |
| `trailingAlignment` | `ContentAlignment` | No | `ContentAlignment.center` | Trailing placement |
| `elevated` | `bool` | No | `false` | Adds shadow elevation |
| `layout` | `CardLayout` | No | `CardLayout.vertical` | `vertical` or `horizontal` |
| `variant` | `CardVariant` | No | `CardVariant.defaultCard` | Semantic variant |
| `onTap` | `VoidCallback?` | No | `null` | Makes the card tappable |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- Use `CKCard.error` for failed states, not for the `CKErrorState` stub
- Horizontal layout is good for list items with a thumbnail

---

# Slide 42: CKCard — Usage

#### Example
```dart
CKCard(
  title: 'Monthly Report',
  subtitle: 'August 2026',
  description: 'Revenue up 12% compared to last month.',
  action: CKButton(onPressed: () => open(), child: const Text('View')),
  elevated: true,
)
```



## Speaker Notes
- Use `CKCard.error` for failed states, not for the `CKErrorState` stub
- Horizontal layout is good for list items with a thumbnail

---

# Slide 43: CKContainer

### Component: `CKContainer`

#### Purpose
- Generic surface container applying design-system background, radius, and optional border/shadow
- Use as a building block for custom layouts

#### Constructors
| Constructor | Variant |
|---|---|
| `CKContainer()` | surface (default) |
| `CKContainer.muted()` | `surfaceVariant` background |
| `CKContainer.outlined()` | surface with border |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `child` | `Widget` | Yes | — | Content to wrap |
| `variant` | `ContainerVariant` | No | `ContainerVariant.surface` | Visual variant |
| `padding` | `EdgeInsetsGeometry?` | No | `EdgeInsets.all(spacing.md)` | Inner padding |
| `elevated` | `bool` | No | `false` | Adds shadow |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.


## Speaker Notes
- Think of this as a themed `Container` — use it whenever you need a styled box that adapts to the brand



---

# Slide 44: CKContainer — Usage

#### Example
```dart
CKContainer.outlined(
  padding: EdgeInsets.all(context.ckSpacing.lg),
  child: Column(children: [...]),
)
```


## Speaker Notes
- Think of this as a themed `Container` — use it whenever you need a styled box that adapts to the brand

---

# Slide 45: CKAccordion

### Component: `CKAccordion`

#### Purpose
- Expandable/collapsible sections in a bordered list
- Single or multi-expand mode

#### Constructors
| Constructor | Notes |
|---|---|
| `CKAccordion()` | Single constructor |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `items` | `List<CKAccordionItem>` | Yes | — | List of accordion entries |
| `initiallyExpanded` | `int?` | No | `null` | Index of item expanded on first render |
| `allowMultiple` | `bool` | No | `false` | Allow multiple sections open at once |

**`CKAccordionItem` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `title` | `String` | Yes | Section header |
| `content` | `Widget` | Yes | Expanded body content |


## Speaker Notes
- `allowMultiple: false` (default) collapses the previous section when opening a new one
- Content can be any widget — not just text

---

# Slide 46: CKAccordion — Usage

#### Example
```dart
CKAccordion(
  items: const [
    CKAccordionItem(title: 'What is CKCoreUI?', content: Text('...')),
    CKAccordionItem(title: 'How do I install it?', content: Text('...')),
  ],
  initiallyExpanded: 0,
)
```


## Speaker Notes
- `allowMultiple: false` (default) collapses the previous section when opening a new one
- Content can be any widget — not just text

---

# Slide 47: CKStepper

### Component: `CKStepper`

#### Purpose
- Visual step progress indicator (e.g., onboarding, multi-step forms)
- Vertical and horizontal orientations

#### Constructors
| Constructor | Notes |
|---|---|
| `CKStepper()` | Single constructor |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `steps` | `List<CKStep>` | Yes | — | Step definitions |
| `orientation` | `CKStepperOrientation` | No | `CKStepperOrientation.vertical` | `vertical` or `horizontal` |
| `checkColor` | `Color?` | No | `null` | Override checkmark/icon color |
| `lineColor` | `Color?` | No | `null` | Override connector line color |

**`CKStep` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `title` | `String` | Yes | Step label |
| `status` | `StepStatus` | Yes | `completed / inProgress / pending / rejected` |
| `icon` | `Widget?` | No | Custom icon; replaces default circle content |
| `color` | `Color?` | No | Override per-step circle color |


## Speaker Notes
- `rejected` shows an X icon and uses the error color
- Color between steps reflects the status of the source step

---

# Slide 48: CKStepper — Usage

#### Example
```dart
CKStepper(
  steps: const [
    CKStep(title: 'Account', status: StepStatus.completed),
    CKStep(title: 'Profile', status: StepStatus.inProgress),
    CKStep(title: 'Review', status: StepStatus.pending),
  ],
)
```

#### Notes
- `CKStepper` is display-only — it does not manage which step is active
- Update `status` on each step in your state to reflect progress


## Speaker Notes
- `rejected` shows an X icon and uses the error color
- Color between steps reflects the status of the source step

---

# Slide 49: CKTimeline

### Component: `CKTimeline`

#### Purpose
- Chronological event list with dots, connectors, timestamps
- Vertical and horizontal orientations

#### Constructors
| Constructor | Notes |
|---|---|
| `CKTimeline()` | Single constructor |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `events` | `List<CKTimelineEvent>` | Yes | — | Timeline events |
| `orientation` | `CKTimelineOrientation` | No | `CKTimelineOrientation.vertical` | `vertical` or `horizontal` |
| `lineColor` | `Color?` | No | `null` | Override connector line color |
| `dotColor` | `Color?` | No | `null` | Override dot color (when no `dotColor` on event) |

**`CKTimelineEvent` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `title` | `String` | Yes | Event label |
| `timestamp` | `String?` | No | Optional time/date string |
| `icon` | `Widget?` | No | Custom icon in the dot |
| `dotColor` | `Color?` | No | Per-event dot color override |
| `status` | `StepStatus?` | No | Drives dot/connector coloring |


## Speaker Notes
- Per-event `dotColor` overrides the top-level `dotColor` param
- `status` on the event drives connector color between adjacent events

---

# Slide 50: CKTimeline — Usage

#### Example
```dart
CKTimeline(
  events: [
    CKTimelineEvent(title: 'Order placed', timestamp: '9:00 AM', status: StepStatus.completed),
    CKTimelineEvent(title: 'Processing', timestamp: '9:15 AM', status: StepStatus.inProgress),
    CKTimelineEvent(title: 'Shipped', status: StepStatus.pending),
  ],
)
```


## Speaker Notes
- Per-event `dotColor` overrides the top-level `dotColor` param
- `status` on the event drives connector color between adjacent events

---

# Slide 51: CKAlert

### Component: `CKAlert`

#### Purpose
- Inline message banner with semantic color and icon
- Use for non-dismissible form-level feedback or informational callouts

#### Constructors
| Constructor | Variant |
|---|---|
| `CKAlert()` | info (default) |
| `CKAlert.success()` | success |
| `CKAlert.warning()` | warning |
| `CKAlert.error()` | error |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `message` | `String` | Yes | — | Alert body text |
| `title` | `String?` | No | `null` | Bold heading above the message |
| `variant` | `AlertVariant` | No | `AlertVariant.info` | Visual variant |
| `onDismiss` | `VoidCallback?` | No | `null` | Shows an X button if provided |


**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- Show variants side by side — icon and color change per variant
- Common mistake: using `CKAlert` for toasts — they serve different purposes

---

# Slide 52: CKAlert — Usage

#### Example
```dart
CKAlert.error(
  title: 'Login failed',
  message: 'Check your credentials and try again.',
  onDismiss: () => setState(() => _showError = false),
)
```

#### Notes
- Without `onDismiss`, the alert is not dismissible — it renders inline persistently
- Use `CKToast` / `CKSnackbar` for ephemeral notifications instead


## Speaker Notes
- Show variants side by side — icon and color change per variant
- Common mistake: using `CKAlert` for toasts — they serve different purposes

---

# Slide 53: CKToast

### Component: `CKToast`

#### Purpose
- Notification pill meant to be shown inside a `SnackBar` or overlay
- Use `CKSnackbar.show()` for the most common case

#### Constructors
| Constructor | Variant |
|---|---|
| `CKToast()` | default (neutral) |
| `CKToast.success()` | success |
| `CKToast.error()` | error |
| `CKToast.warning()` | warning |
| `CKToast.info()` | info |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `message` | `String` | Yes | — | Notification text |
| `variant` | `ToastVariant` | No | `ToastVariant.defaultToast` | Visual variant |
| `onDismiss` | `VoidCallback?` | No | `null` | X button callback |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.


## Speaker Notes
- `CKToast` is the visual widget; `CKSnackbar` is the imperative helper that shows it
- You can render `CKToast` directly inside a custom overlay if needed

---

# Slide 54: CKSnackbar

### Component: `CKSnackbar`

#### Purpose
- Imperative helper to show a styled snackbar using `ScaffoldMessenger`
- Wraps `CKToast` in a floating `SnackBar`

#### Constructor
- `CKSnackbar` is an abstract class — use the static `show` method directly

#### `CKSnackbar.show()` Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `context` | `BuildContext` | Yes | — | For `ScaffoldMessenger.of(context)` |
| `message` | `String` | Yes | — | Notification text |
| `variant` | `ToastVariant` | No | `ToastVariant.defaultToast` | Visual variant |
| `duration` | `Duration` | No | `Duration(seconds: 3)` | Auto-dismiss time |
| `onDismiss` | `VoidCallback?` | No | `null` | Called when X is tapped |


## Speaker Notes
- This is the go-to for transient feedback — use it after save/delete/upload operations

---

# Slide 55: CKSnackbar — Usage

#### Example
```dart
CKSnackbar.show(
  context,
  'Changes saved successfully',
  variant: ToastVariant.success,
)
```

#### Notes
- Dismisses any existing snackbar before showing the new one
- Uses `SnackBarBehavior.floating` — no `margin` needed


## Speaker Notes
- This is the go-to for transient feedback — use it after save/delete/upload operations

---

# Slide 56: CKLoader

### Component: `CKLoader`

#### Purpose
- Animated loading indicator in four styles

#### Constructors
| Constructor | Style |
|---|---|
| `CKLoader()` | circular (default) |
| `CKLoader.ring()` | ring |
| `CKLoader.bar()` | animated bar |
| `CKLoader.dots()` | bouncing dots |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `type` | `LoaderType` | No | `LoaderType.circular` | Animation style |
| `color` | `Color?` | No | `null` | Override color (defaults to `primary`) |
| `size` | `double` | No | `40` | Bounding box size in logical pixels |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- `CKLoadingState` uses `CKLoader` internally and adds a centered + optional message layout

---

# Slide 57: CKLoader — Usage

#### Example
```dart
CKLoader()                     // circular, primary color, 40dp
CKLoader.dots(size: 24)
CKLoader(color: Colors.white)  // white spinner on dark backgrounds
```


## Speaker Notes
- `CKLoadingState` uses `CKLoader` internally and adds a centered + optional message layout

---

# Slide 58: CKProgressBar / CKSlider

### Components: `CKProgressBar`, `CKSlider`

#### CKProgressBar

**Constructors:**
| Constructor | Variant |
|---|---|
| `CKProgressBar()` | primary |
| `CKProgressBar.success()` | success |
| `CKProgressBar.warning()` | warning |
| `CKProgressBar.error()` | error |
| `CKProgressBar.indeterminate()` | indeterminate (animated) |

**Parameters (4):**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `double?` | No | `null` | Progress (0.0–1.0); null = empty |
| `maxValue` | `double` | No | `1.0` | Scale denominator |
| `variant` | `ProgressVariant` | No | `ProgressVariant.primary` | Color variant |
| `showValue` | `bool` | No | `false` | Shows percentage label beside bar |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

#### CKSlider

**Parameters (6):**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `value` | `double` | Yes | — | Current value |
| `onChanged` | `ValueChanged<double>?` | Yes | — | Change callback |
| `min` | `double` | No | `0.0` | Minimum value |
| `max` | `double` | No | `100.0` | Maximum value |
| `showValue` | `bool` | No | `false` | Show current value label |
| `color` | `Color?` | No | `null` | Override track/thumb color |


## Speaker Notes
- `maxValue` lets you avoid manual normalization — e.g., `value: 250, maxValue: 500`
- `indeterminate` ignores `value` entirely

---

# Slide 59: CKProgressBar / CKSlider — Usage

#### Example
```dart
CKProgressBar(value: 0.65, showValue: true)
CKProgressBar.indeterminate()

CKSlider(
  value: _volume,
  min: 0,
  max: 100,
  onChanged: (v) => setState(() => _volume = v),
)
```


## Speaker Notes
- `maxValue` lets you avoid manual normalization — e.g., `value: 250, maxValue: 500`
- `indeterminate` ignores `value` entirely

---

# Slide 60: CKLoadingState (Work in progress)

### Component: `CKLoadingState`

#### Purpose
- Centered loading view combining `CKLoader` with an optional message
- Use as a full-screen or section loading placeholder

#### Constructors
| Constructor | Notes |
|---|---|
| `CKLoadingState()` | Single constructor |

#### Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `message` | `String?` | No | `null` | Optional loading message below the spinner |
| `loaderSize` | `double?` | No | `40` | Loader size override |
| `variant` | `LoaderType` | No | `LoaderType.circular` | Animation style |

#### Example
```dart
CKLoadingState(
  message: 'Fetching data...',
  variant: LoaderType.dots,
)
```

## Speaker Notes
- Wraps the loader in a `Center` widget — drop it directly into a `body:` or conditional slot

---

# Slide 61: CKAppBar

### Component: `CKAppBar`

#### Purpose
- Implements `PreferredSizeWidget` — drop-in for `Scaffold.appBar`
- Four style variants

#### Constructors
| Constructor | Style |
|---|---|
| `CKAppBar()` | primary (default) |
| `CKAppBar.surface()` | surface color |
| `CKAppBar.dark()` | inverse surface (dark) |
| `CKAppBar.transparent()` | no background |

#### Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `title` | `Widget?` | No | `null` | Center title widget |
| `leading` | `Widget?` | No | `null` | Leading widget (back/menu button) |
| `trailing` | `List<Widget>` | No | `[]` | Action widgets on the right |
| `style` | `AppBarStyle` | No | `AppBarStyle.primary` | Visual style |
| `largeTitle` | `bool` | No | `false` | Taller bar with larger title text |

**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.


## Speaker Notes
- `largeTitle: true` uses `displaySm` typography and a taller bar (80dp vs 64dp)
- Icon theme and text style inside the bar are automatically set to match the bar color

---

# Slide 62: CKAppBar — Usage

#### Example
```dart
Scaffold(
  appBar: CKAppBar(
    title: const Text('Dashboard'),
    trailing: [
      CKIconButton(icon: LucideIcons.bell, onPressed: () {}),
    ],
  ),
  body: ...,
)
```


## Speaker Notes
- `largeTitle: true` uses `displaySm` typography and a taller bar (80dp vs 64dp)
- Icon theme and text style inside the bar are automatically set to match the bar color

---

# Slide 63: CKTabs

### Component: `CKTabs`

#### Purpose
- Full tab navigation including tab bar and tab body switching
- Three visual styles

#### Constructors
| Constructor | Style |
|---|---|
| `CKTabs()` | line (underline indicator) |
| `CKTabs.pill()` | pill / capsule style |
| `CKTabs.card()` | card-elevated style |

#### Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `tabs` | `List<CKTab>` | Yes | — | Tab definitions |
| `variant` | `TabVariant` | No | `TabVariant.line` | Visual style |
| `scrollable` | `bool` | No | `false` | Horizontal scrolling for many tabs |
| `initialIndex` | `int` | No | `0` | Tab index active on first render |
| `onTabChanged` | `ValueChanged<int>?` | No | `null` | Callback when tab changes |

**`CKTab` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `label` | `String` | Yes | Tab header text |
| `content` | `Widget` | Yes | Tab body widget |
| `icon` | `IconData?` | No | Optional icon in tab header |
| `badge` | `int?` | No | Notification count bubble |


**Roadmap:** The package is gradually moving toward a more consistent API. Some variant/type parameters may become internal or be replaced by named constructors in a future major release as the design system matures. Existing APIs remain supported for backward compatibility.

## Speaker Notes
- `scrollable: true` is useful for >= 5 tabs
- Tab body content is lazy — not built until that tab is first shown

---

# Slide 64: CKTabs — Usage

#### Example
```dart
CKTabs(
  tabs: [
    CKTab(label: 'Overview', content: OverviewPage()),
    CKTab(label: 'Users', badge: 3, content: UsersPage()),
  ],
)
```

#### Notes
- `CKTabs` manages its own `TabController` — no external controller needed
- For externally controlled tabs, use `initialIndex` + `onTabChanged`


## Speaker Notes
- `scrollable: true` is useful for >= 5 tabs
- Tab body content is lazy — not built until that tab is first shown

---

# Slide 65: CKBottomNavigation

### Component: `CKBottomNavigation`

#### Purpose
- Bottom tab bar for mobile navigation with 3–5 items
- Supports an optional FAB slot centered above the bar

#### Constructors
| Constructor | Notes |
|---|---|
| `CKBottomNavigation()` | Single constructor |

#### Parameters (4)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `selectedIndex` | `int` | Yes | — | Active tab index |
| `items` | `List<CKNavItem>` | Yes | — | Navigation items |
| `onDestinationSelected` | `ValueChanged<int>?` | No | `null` | Tab change callback |
| `fab` | `Widget?` | No | `null` | Widget elevated above the bar center |

**`CKNavItem` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `icon` | `IconData` | Yes | Inactive icon |
| `label` | `String` | Yes | Tab label |
| `activeIcon` | `IconData?` | No | Filled variant for active state |


## Speaker Notes
- Pair with `IndexedStack` or a page controller to swap content
- `fab` is centered above the bar and creates an automatic gap between left and right nav items

---

# Slide 66: CKBottomNavigation — Usage

#### Example
```dart
CKBottomNavigation(
  selectedIndex: _currentTab,
  onDestinationSelected: (i) => setState(() => _currentTab = i),
  items: const [
    CKNavItem(icon: LucideIcons.home, label: 'Home'),
    CKNavItem(icon: LucideIcons.users, label: 'Members'),
    CKNavItem(icon: LucideIcons.settings, label: 'Settings'),
  ],
)
```


## Speaker Notes
- Pair with `IndexedStack` or a page controller to swap content
- `fab` is centered above the bar and creates an automatic gap between left and right nav items

---

# Slide 67: CKDrawer

### Component: `CKDrawer`

#### Purpose
- Side drawer with brand header, user info, and navigation items
- Designed for `Scaffold.drawer`

#### Constructors
| Constructor | Notes |
|---|---|
| `CKDrawer()` | Single constructor |

#### Parameters (7)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `appName` | `String` | Yes | — | App name shown in the header |
| `items` | `List<CKDrawerItem>` | Yes | — | Navigation items |
| `selectedIndex` | `int` | Yes | — | Active item index |
| `onItemSelected` | `ValueChanged<int>` | Yes | — | Selection callback |
| `userEmail` | `String?` | No | `null` | User email in header |
| `logo` | `Widget?` | No | `null` | Custom logo; defaults to brand logo |

**`CKDrawerItem` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `icon` | `IconData` | Yes | Item icon |
| `label` | `String` | Yes | Item label |


## Speaker Notes
- Header background uses `primary` color automatically
- If no `logo` is passed, the brand logo is resolved from `CKApp.brand`
- Remember to `Navigator.pop(context)` inside `onItemSelected`

---

# Slide 68: CKDrawer — Usage

#### Example
```dart
Scaffold(
  drawer: CKDrawer(
    appName: 'CastleKeep',
    selectedIndex: _drawerIndex,
    onItemSelected: (i) { setState(() => _drawerIndex = i); Navigator.pop(context); },
    items: const [
      CKDrawerItem(icon: LucideIcons.layoutDashboard, label: 'Dashboard'),
      CKDrawerItem(icon: LucideIcons.users, label: 'Users'),
    ],
  ),
)
```


## Speaker Notes
- Header background uses `primary` color automatically
- If no `logo` is passed, the brand logo is resolved from `CKApp.brand`
- Remember to `Navigator.pop(context)` inside `onItemSelected`

---

# Slide 69: CKSideNav

### Component: `CKSideNav`

#### Purpose
- Collapsible side navigation for desktop/tablet app shells
- Supports sections, badges, profile card, and brand logo

#### Constructors
| Constructor | Notes |
|---|---|
| `CKSideNav()` | Single constructor |

#### Parameters (14)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `sections` | `List<CKSideNavSection>` | Yes | — | Navigation section groups |
| `selectedIndex` | `int` | Yes | — | Active item index (global across all sections). Deprecated in favor of `selectedKey`/`onItemSelectedKey`.
| `onItemSelected` | `ValueChanged<int>` | Yes | — | Selection callback (index-based). Deprecated; use `onItemSelectedKey` for key-based callbacks.
| `selectedKey` | `Object?` | No | `null` | Preferred: active item key when items provide `itemKey` |
| `onItemSelectedKey` | `ValueChanged<Object?>?` | No | `null` | Preferred: selection callback with item key |
| `collapsed` | `bool` | No | `false` | Collapsed (icon-only) mode |
| `onToggleCollapse` | `VoidCallback?` | No | `null` | Toggle collapse callback |
| `logo` | `Widget?` | No | `null` | Custom logo |
| `brandName` | `String?` | No | `null` | Brand/app name shown below logo |
| `version` | `String?` | No | `null` | Version string at the bottom |
| `style` | `SideNavStyle` | No | `SideNavStyle.surface` | `surface` or `brand` |
| `profileName` | `String?` | No | `null` | User name in profile card |
| `profilePosition` | `String?` | No | `null` | User role/position |
| `profileAvatar` | `Widget?` | No | `null` | Avatar widget |
| `profileAuthProvider` | `String?` | No | `null` | Auth provider label |
| `onLogout` | `VoidCallback?` | No | `null` | Logout button callback |

**`CKSideNavSection` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `items` | `List<CKSideNavItem>` | Yes | Items in this section |
| `label` | `String?` | No | Optional section heading |

**`CKSideNavItem` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `icon` | `IconData` | Yes | Item icon |
| `label` | `String` | Yes | Item label |
| `badge` | `int?` | No | Notification count |
| `itemKey` | `Object?` | No | Optional opaque key used for `selectedKey` selection |


## Speaker Notes
- `SideNavStyle.brand` applies the brand primary color as the nav background
- Profile card popup shows name, position, auth provider, and logout button
- Use `collapsed` state for responsive desktop layouts (toggle on breakpoint)

---

# Slide 70: CKSideNav — Usage

#### Example
```dart
CKSideNav(
  selectedIndex: _navIndex, // deprecated: prefer selectedKey
  selectedKey: 'users',
  onItemSelectedKey: (k) => setState(() => _navIndex = /* map key to index */ 1),
  onItemSelected: (i) => setState(() => _navIndex = i),
  brandName: 'CastleKeep Admin',
  profileName: 'John Doe',
  profilePosition: 'Administrator',
  onLogout: () => signOut(),
  sections: [
    CKSideNavSection(
      label: 'Main',
      items: const [
        CKSideNavItem(icon: LucideIcons.layoutDashboard, label: 'Dashboard', itemKey: 'dashboard'),
        CKSideNavItem(icon: LucideIcons.users, label: 'Users', badge: 3, itemKey: 'users'),
      ],
    ),
  ],
)
```

#### Notes
- `selectedIndex` is global across all sections — index 0 is the first item of the first section
- `collapsed: true` renders icon-only mode; labels and section headings are hidden


## Speaker Notes
- `SideNavStyle.brand` applies the brand primary color as the nav background
- Profile card popup shows name, position, auth provider, and logout button
- Use `collapsed` state for responsive desktop layouts (toggle on breakpoint)

---

# Slide 71: CKDialog

### Component: `CKDialog`

#### Purpose
- Modal dialog with confirm/cancel actions
- Has a static `show` helper for imperative usage

#### Constructors
| Constructor | Use case |
|---|---|
| `CKDialog()` | Generic confirm dialog |
| `CKDialog.destructive()` | Irreversible action confirmation |
| `CKDialog.info()` | Read-only info dialog |

#### Parameters (9)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `content` | `Widget` | Yes | — | Dialog body content |
| `title` | `String?` | No | `null` | Dialog heading |
| `confirmLabel` | `String` | No | `'Confirm'` | Primary button label |
| `cancelLabel` | `String` | No | `'Cancel'` | Secondary button label |
| `onConfirm` | `VoidCallback?` | No | `null` | Confirm callback |
| `onCancel` | `VoidCallback?` | No | `null` | Cancel callback |
| `showClose` | `bool` | No | `true` | X button in top-right |
| `maxWidth` | `double?` | No | `null` | Max dialog width |
| `maxHeight` | `double?` | No | `null` | Max dialog height |
| `confirmWidget` | `Widget?` | No | `null` | Custom confirm button override |
| `cancelWidget` | `Widget?` | No | `null` | Custom cancel button override |


## Speaker Notes
- `show()` returns a `Future<T?>` — result is `null` if dismissed without confirming
- Confirm/cancel callbacks receive no arguments — pass closures capturing your state

---

# Slide 72: CKDialog — Usage

#### Example
```dart
// Imperative
await CKDialog.show(
  context: context,
  title: 'Save Changes',
  content: const Text('Do you want to save before leaving?'),
  onConfirm: () => save(),
)

// Destructive
CKDialog.destructive(
  title: 'Delete Account',
  content: const Text('This cannot be undone.'),
  confirmLabel: 'Yes, Delete Permanently',
  onConfirm: () => deleteAccount(),
)
```

#### Notes
- `CKDialog.destructive` automatically styles the confirm button as destructive (red)
- `CKDialog.info` has `showClose: true` by default and omits the cancel button


## Speaker Notes
- `show()` returns a `Future<T?>` — result is `null` if dismissed without confirming
- Confirm/cancel callbacks receive no arguments — pass closures capturing your state

---

# Slide 73: CKBottomSheet

### Component: `CKBottomSheet`

#### Purpose
- Draggable modal bottom sheet with a drag handle, optional title, and custom content
- Use `CKBottomSheet.show()` for the common case

#### Constructors
| Constructor | Notes |
|---|---|
| `CKBottomSheet()` | Widget constructor |
| `CKBottomSheet.show()` | Static imperative helper |

#### Widget Parameters (3)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `children` | `List<Widget>` | Yes | — | Sheet body content |
| `title` | `String?` | No | `null` | Sheet heading |
| `onClose` | `VoidCallback?` | No | `null` | Custom close callback |

#### `show()` Parameters (5)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `context` | `BuildContext` | Yes | — | Build context |
| `children` | `List<Widget>` | Yes | — | Sheet body content |
| `title` | `String?` | No | `null` | Sheet heading |
| `onClose` | `VoidCallback?` | No | `null` | Close callback |
| `isDismissible` | `bool` | No | `true` | Allow tap-outside dismiss |


## Speaker Notes
- `isScrollControlled: true` is set internally — content can exceed 60% screen height
- Drag handle is always shown; no additional configuration needed

---

# Slide 74: CKBottomSheet — Usage

#### Example
```dart
await CKBottomSheet.show(
  context: context,
  title: 'Select Status',
  children: statuses.map((s) => ListTile(title: Text(s))).toList(),
)
```


## Speaker Notes
- `isScrollControlled: true` is set internally — content can exceed 60% screen height
- Drag handle is always shown; no additional configuration needed

---

# Slide 75: CKMenu

### Component: `CKMenu`

#### Purpose
- Contextual dropdown menu anchored to a trigger widget
- Displays a list of labeled actions with optional icons

#### Constructors
| Constructor | Notes |
|---|---|
| `CKMenu()` | Single constructor |

#### Parameters (2)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `trigger` | `Widget` | Yes | — | Widget that opens the menu on tap |
| `items` | `List<CKMenuItem>` | Yes | — | Menu action items |

**`CKMenuItem` model:**
| Field | Type | Required | Description |
|---|---|---|---|
| `label` | `String` | Yes | Action label |
| `icon` | `IconData?` | No | Optional leading icon |
| `onTap` | `VoidCallback?` | No | Action callback |
| `destructive` | `bool` | No (`false`) | Renders label and icon in error color |


## Speaker Notes
- `destructive: true` on a `CKMenuItem` renders it in red — use for irreversible actions
- Menu closes automatically after an item is tapped

---

# Slide 76: CKMenu — Usage

#### Example
```dart
CKMenu(
  trigger: CKIconButton(icon: LucideIcons.moreVertical, onPressed: null),
  items: [
    const CKMenuItem(icon: LucideIcons.pencil, label: 'Edit', onTap: edit),
    const CKMenuItem(icon: LucideIcons.trash, label: 'Delete', destructive: true, onTap: delete),
  ],
)
```

#### Notes
- The `trigger` widget receives an `onTap` callback injected by `CKMenu` — do not set `onPressed` on it
- Menu position (above/below/left/right) is automatically computed


## Speaker Notes
- `destructive: true` on a `CKMenuItem` renders it in red — use for irreversible actions
- Menu closes automatically after an item is tapped

---

# Slide 77: CKDataTable — Overview

## Slide
- The most complex component in the library
- Manages: columns, rows, sorting, search, selection, pagination, editing, loading/error/empty states
- Two parts: **`CKDataTable`** (the widget) + **`CKTableColumn`** (column definition)
- Data is row-oriented: `List<Map<String, dynamic>>`

## Speaker Notes
- Everything flows through maps — column `key` fields match the map keys in each row
- The table is self-contained: search, sort, and pagination can all be handled internally OR delegated to the parent

---

# Slide 78: CKTableColumn

### Component: `CKTableColumn`

#### Purpose
- Defines metadata for a single column: display, type, sizing, sort, and cell rendering

#### Constructors
| Constructor | Notes |
|---|---|
| `CKTableColumn()` | Single constructor |
| `CKTableColumn.fromStrings()` | Migration helper — converts `List<String>` labels to columns |

#### Parameters (10)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `key` | `String` | Yes | — | Matches the key in each row `Map` |
| `label` | `String` | Yes | — | Column header display text |
| `type` | `CKColumnType` | No | `CKColumnType.text` | Built-in renderer: `text / badge / avatarText / progress / custom` |
| `width` | `double?` | No | `null` | Fixed pixel width; null = flex |
| `flex` | `int` | No | `1` | Proportional share when `width` is null |
| `minWidth` | `double` | No | `120` | Minimum width in `compact` mode |
| `sortable` | `bool` | No | `false` | Shows sort arrow in header |
| `hidden` | `bool` | No | `false` | Hides column from header and all rows |
| `textAlign` | `TextAlign` | No | `TextAlign.start` | Cell content alignment |
| `badgeVariantBuilder` | `BadgeVariant Function(dynamic)?` | No | `null` | Required when `type == badge` |
| `cellBuilder` | `Widget Function(dynamic, Map)?` | No | `null` | Required when `type == custom`; also overrides other types |

#### Built-in Column Types
| `CKColumnType` | Renders | Extra requirement |
|---|---|---|
| `text` | Plain text | — |
| `badge` | `CKBadge` | Must provide `badgeVariantBuilder` |
| `avatarText` | `CKAvatar` + text | Value must be a `String` (used as initials) |
| `progress` | `CKProgressBar` | Value must be `num` (0–100) |
| `custom` | Your widget | Must provide `cellBuilder` |

#### Example
```dart
CKTableColumn(
  key: 'status',
  label: 'Status',
  type: CKColumnType.badge,
  sortable: true,
  badgeVariantBuilder: (v) => switch (v) {
    'active'   => BadgeVariant.success,
    'inactive' => BadgeVariant.error,
    _          => BadgeVariant.defaultFill,
  },
)
```

## Speaker Notes
- `key` is the most critical field — a mismatch silently shows empty cells
- `hidden: true` is for columns you want in the data but not displayed (e.g., an `id` column used for row key only)
- `cellBuilder` receives the cell value AND the full row map — use the row for multi-field custom cells

---

# Slide 79: CKDataTable — Core Parameters

### Component: `CKDataTable`

#### Purpose
- Full-featured data table with header, body, and footer regions
- Handles all table concerns: display, interaction, state

#### Parameters (27 total)

**Data (3)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `columns` | `List<CKTableColumn>` | Yes | — | Column definitions |
| `rows` | `List<Map<String, dynamic>>` | Yes | — | Row data |
| `rowKey` | `String` | No | `'id'` | Key field used to uniquely identify each row |

**Header (5)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `title` | `String?` | No | `null` | Table heading |
| `subtitle` | `String?` | No | `null` | Table sub-heading |
| `headerActions` | `List<Widget>?` | No | `null` | Widgets in the top-right header area |
| `searchQuery` | `String?` | No | `null` | Controlled search value |
| `searchHint` | `String?` | No | `null` | Search field placeholder |
| `onSearchChanged` | `ValueChanged<String>?` | No | `null` | Called on search input; enables search bar |

**Sorting (3)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `sortColumnKey` | `String?` | No | `null` | Column key currently sorted |
| `sortAscending` | `bool` | No | `true` | Sort direction |
| `onSortChanged` | `void Function(String, bool)?` | No | `null` | Sort callback; if null, sorting is internal |


## Speaker Notes
- Know the difference between controlled and uncontrolled modes for sort and search
- `rowKey` defaults to `'id'` — ensure your row maps have this key for selection and editing to work correctly

---

# Slide 80: CKDataTable — Selection, Pagination & State

**Selection (3)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `selectionMode` | `TableSelectionMode` | No | `TableSelectionMode.none` | `none / single / multiple` |
| `selectedKeys` | `Set<dynamic>` | No | `{}` | Currently selected row keys |
| `onSelectionChanged` | `ValueChanged<Set<dynamic>>?` | No | `null` | Called when selection changes |

**Pagination (4)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `totalCount` | `int` | No | `0` | Total record count (for page info display) |
| `currentPage` | `int` | No | `1` | Currently shown page |
| `pageSize` | `int` | No | `10` | Rows per page |
| `onPageChanged` | `ValueChanged<int>?` | No | `null` | Page change callback; if null, footer is hidden |

**State (3)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `isLoading` | `bool` | No | `false` | Shows loading overlay |
| `errorMessage` | `String?` | No | `null` | Shows error state with this message |
| `emptyMessage` | `String?` | No | `null` | Message shown when rows is empty |
| `emptyWidget` | `Widget?` | No | `null` | Custom empty state widget (overrides `emptyMessage`) |


## Speaker Notes
- Know the difference between controlled and uncontrolled modes for sort and search
- `rowKey` defaults to `'id'` — ensure your row maps have this key for selection and editing to work correctly

---

# Slide 81: CKDataTable — Display & Interaction

**Display (5)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `footerRow` | `Map<String, dynamic>?` | No | `null` | Summary row pinned to table bottom |
| `striped` | `bool` | No | `true` | Alternating row background |
| `headerFooterColor` | `Color?` | No | `null` | Override header/footer background |
| `widthBehavior` | `TableWidthBehavior` | No | `TableWidthBehavior.stretch` | `stretch` fills container; `compact` uses `minWidth` |
| `maxHeight` | `double?` | No | `null` | Constrains table height; enables vertical scroll |

**Interaction (3)**
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `onRowTap` | `void Function(Map<String, dynamic>)?` | No | `null` | Called when a row is tapped |
| `editableColumns` | `Set<String>?` | No | `null` | Column keys that render inline text editors |
| `onCellChanged` | `void Function(dynamic rowKey, String colKey, dynamic newValue)?` | No | `null` | Called when an editable cell is changed |


## Speaker Notes
- Know the difference between controlled and uncontrolled modes for sort and search
- `rowKey` defaults to `'id'` — ensure your row maps have this key for selection and editing to work correctly

---

# Slide 82: CKDataTable — Controlled vs Uncontrolled

## Slide

### Uncontrolled (internal state)
```dart
CKDataTable(
  columns: _columns,
  // `rows` expects a List<Map<String, dynamic>> where each map is a row.
  // Sample shape: [{'id': '1', 'name': 'Alice', 'status': 'active'}, ...]
  // This mode is best for small in-memory datasets; the table will
  // perform filtering, sorting and pagination internally on `_allRows`.
  rows: _allRows,
  onSearchChanged: null,
  onSortChanged: null,
)
```

### Controlled (external state / API)
```dart
CKDataTable(
  columns: _columns,
  // `rows` should contain only the current page of data returned by your API.
  // Sample API return: { 'rows': List<Map<String,dynamic>>, 'total': 123 }
  // Set `_pagedRows` to the returned `rows` and `_total` to `total`.
  rows: _pagedRows,         // already filtered/sorted from API (current page)
  searchQuery: _query,
  onSearchChanged: (q) => setState(() { _query = q; _refetch(); }),
  sortColumnKey: _sortKey,
  sortAscending: _sortAsc,
  onSortChanged: (key, asc) => setState(() {
    _sortKey = key; _sortAsc = asc; _refetch();
  }),
  totalCount: _total,
  currentPage: _page,
  pageSize: 10,
  onPageChanged: (p) => setState(() { _page = p; _refetch(); }),
)
```

## Speaker Notes
- Uncontrolled: pass all rows, let the table filter/sort/paginate — great for small datasets in memory
- Controlled: pass only the current page of rows, handle everything server-side
- Mixing is allowed: e.g., internal sort + external pagination

---

# Slide 83: CKDataTable — Inline Editing

## Slide
```dart
CKDataTable(
  columns: [...],
  // Rows: sample shape — each row must include the `rowKey` (default 'id'):
  // [{'id': 1, 'name': 'Alice', 'email': 'a@x.com'}, ...]
  rows: _rows,
  editableColumns: {'name', 'email'},
  onCellChanged: (rowKey, colKey, newValue) {
    // Update local cache optimistically
    setState(() {
      final row = _rows.firstWhere((r) => r['id'] == rowKey);
      row[colKey] = newValue;
    });
    // Persist change to API as needed, e.g.:
    // await api.updateRow(rowKey, {colKey: newValue});
    // Optionally re-fetch or merge server response to keep state authoritative.
  },
)
```
- Editable cells render `CKTextField` with `borderless: true`
- `onCellChanged` fires on `focusOut` / editing complete
- Only columns listed in `editableColumns` become editable

## Speaker Notes
- `rowKey` (default `'id'`) must be present in each row map for `onCellChanged` to identify the correct row
- Avoid making primary key or ID columns editable

---

# Slide 84: CKDataTable — Badge Columns

## Slide
```dart
CKTableColumn(
  key: 'status',
  label: 'Status',
  type: CKColumnType.badge,
  sortable: true,
  badgeVariantBuilder: (value) {
    return switch (value.toString().toLowerCase()) {
      'active'   => BadgeVariant.success,
      'inactive' => BadgeVariant.defaultFill,
      'banned'   => BadgeVariant.error,
      'pending'  => BadgeVariant.warning,
      _          => BadgeVariant.outline,
    };
  },
)
```
- Automatically adds **badge filter chips** above the table for that column
- Users can filter by clicking the badge chip

## Speaker Notes
- Badge columns get filter UI for free — no extra code needed
- The filter chips show unique values extracted from the column data

---

# Slide 85: CKDataTable — Custom Cell Rendering

## Slide
```dart
CKTableColumn(
  key: 'actions',
  label: '',
  type: CKColumnType.custom,
  width: 100,
  cellBuilder: (value, row) {
    return Row(
      children: [
        CKIconButton(
          icon: LucideIcons.pencil,
          onPressed: () => edit(row['id']),
        ),
        CKIconButton(
          icon: LucideIcons.trash,
          onPressed: () => delete(row['id']),
        ),
      ],
    );
  },
)
```

## Speaker Notes
- `cellBuilder` receives both the cell `value` and the full `row` map
- Use a fixed `width` for action columns so they don't stretch
- Keep cell builders lightweight — they are called for every visible row

---

# Slide 86: CKDataTable — Selection

## Slide
```dart
CKDataTable(
  columns: _columns,
  rows: _rows,
  selectionMode: TableSelectionMode.multiple,
  selectedKeys: _selectedIds,
  onSelectionChanged: (keys) => setState(() => _selectedIds = keys),
  headerActions: [
    if (_selectedIds.isNotEmpty)
      CKButton.destructive(
        onPressed: () => bulkDelete(_selectedIds),
        child: Text('Delete ${_selectedIds.length}'),
      ),
  ],
)
```
- `single`: only one row selected at a time
- `multiple`: checkboxes appear; supports "select all"
- `selectedKeys` is a `Set<dynamic>` matching values of the `rowKey` field

## Speaker Notes
- `headerActions` is the right place for bulk action buttons
- "Select all" checkbox in the header selects/deselects all visible rows

---

# Slide 87: CKScreenLayout

### Component: `CKScreenLayout`

#### Purpose
- Responsive layout template combining side navigation with main content area
- Adapts between desktop (persistent side nav) and mobile (overlay drawer) layouts
- Handles profile section, collapse toggle, and branding in the nav header

#### Constructors
| Constructor | Notes |
|---|---|
| `CKScreenLayout()` | Single constructor |

#### Parameters (14)
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `body` | `Widget` | Yes | — | Main content area |
| `sections` | `List<CKSideNavSection>` | Yes | — | Navigation sections and items |
| `selectedIndex` | `int` | Yes | — | Currently selected nav item index |
| `onItemSelected` | `ValueChanged<int>` | Yes | — | Callback when nav item is tapped |
| `logo` | `Widget?` | No | `null` | Logo widget for nav header |
| `brandName` | `String?` | No | `null` | Brand name in nav header and mobile top bar |
| `version` | `String?` | No | `null` | Version string in nav footer |
| `sideNavStyle` | `SideNavStyle` | No | `SideNavStyle.surface` | `surface` or `brand` styling |
| `allowSideNavCollapse` | `bool` | No | `true` | Show collapse toggle on desktop |
| `bodyScrollable` | `bool` | No | `true` | Wrap body in `SingleChildScrollView` |
| `profileName` | `String?` | No | `null` | User name in profile section |
| `profilePosition` | `String?` | No | `null` | Job title or role in profile section |
| `profileAvatar` | `Widget?` | No | `null` | Avatar widget (icon or image) |
| `profileAuthProvider` | `String?` | No | `null` | Auth provider label (e.g., "Google") |
| `onLogout` | `VoidCallback?` | No | `null` | Callback when logout button is tapped |

#### Responsive Behavior
- **Desktop (width ≥ 840px):** Side nav is persistent on the left; body expands to fill remaining space
- **Mobile/Tablet (width < 840px):** Side nav is hidden; hamburger menu appears in top bar; nav opens as fullscreen drawer on tap

#### Notes
- `bodyScrollable: false` is useful for custom scroll management or full-viewport layouts
- The profile section appears at the bottom of the nav; `onLogout` is only called if the widget is present
- `sideNavStyle: SideNavStyle.brand` uses the primary brand color; `surface` uses neutral background
- The layout automatically closes the drawer when a nav item is tapped on mobile


## Speaker Notes
- Use `CKScreenLayout` as the root widget of authenticated app pages — it handles the entire responsive shell
- The hamburger icon and top bar background color adapt based on `sideNavStyle` to maintain consistency
- Pairing with `CKSideNav` is automatic — do not construct `CKSideNav` separately
- Test responsive behavior by resizing the browser or running on different device profiles
- The `logo` and `brandName` help users understand where they are; always provide at least one

---

# Slide 88: Best Practices

## Slide
- Always wrap the app in `CKApp` — never construct `CkcoreuiThemeData` manually
- Use token accessors (`context.ckColors`, `context.ckSpacing`) — no hardcoded colors or sizes
- Use named constructors for semantic clarity: `CKButton.destructive()` over passing `variant: ButtonVariant.destructive`
- Set `onPressed: null` (not just `disabled: true`) when awaiting async operations on buttons
- Use `rowKey` explicitly in `CKDataTable` — don't rely on the `'id'` default unless your data has it
- Keep `cellBuilder` functions lightweight and stateless

## Speaker Notes
- The biggest recurring issue is hardcoded colors that break in dark mode or brand switches
- Named constructors make code reviews faster — intent is immediately readable

---

# Slide 89: Current Limitations / To Be Added

## Slide

**Stubs (API ready, not rendered):**
- `CKDivider`, `CKListTile`
- `CKSkeleton`
- `CKEmptyState`, `CKErrorState`
- `CKBreadcrumb`, `CKNavigationRail`
- `CKDatePicker`, `CKTimePicker`
- `CKTooltip`, `CKPopover`

**Known gaps:**
- No `CKForm` wrapper with bulk validation
- `CKDataTable` does not support row drag-to-reorder
- `CKDataTable` editable cells are text-only (no dropdown/date picker editing)
- `CKSideNav` uses a global `selectedIndex`, which can be unintuitive for multi-section navigation
- `CKNumberStepper` fires `onChanged` on every clamped value, which may cause unnecessary `setState` calls

## Speaker Notes
- Stubs are safe to include in code now — they just won't render
- Workarounds exist for most gaps using Flutter primitives + CK tokens
- Contributions welcome: use `bin/ckgoc.dart` to scaffold new brand themes

---

# Slide 90: Wrap-Up

## Slide
- Import once: `import 'package:ckcoreui/ckcoreui.dart'`
- Entry point: `CKApp(brand: ckcoreBrand.castleKeep, ...)`
- Tokens everywhere: `context.ckColors`, `context.ckSpacing`, etc.
- Component catalog on the docs site — live demos for every implemented widget
- Ask before building custom widgets — the component you need may already exist

## Speaker Notes
- Demo the docs site live — show brand switching between CastleKeep and SkyGo
- Show dark mode toggle on the docs site
- Q&A: common first question is "can I use custom colors?" — yes, via `CkcoreuiThemeData.copyWith()`