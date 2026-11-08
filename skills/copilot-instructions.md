# ckcoreui conventions

This project uses the `ckcoreui` Flutter design system. Follow these rules in all Dart UI code.

- Import `package:ckcoreui/ckcoreui.dart`.
- The root widget is `CKApp(brand: ckcoreBrand.castleKeep, home: ...)`. It replaces `MaterialApp`. Do not nest a `MaterialApp` in it. `ckcoreApp` is deprecated.
- Use tokens, never literals: `context.ckColors.primary`, `context.ckSpacing.md`, `context.ckTypography.textMd`, `context.ckRadius.md`, `context.ckMotion.normal`.
- Use `CK*` components (`CKButton`, `CKTextField`, `CKCard`, `CKDataTable`, `CKDialog`, `CKBadge`) rather than raw Material equivalents.
- `CKButton` takes `child: Text('...')`, not a `label`. Variants: `CKButton.outline`, `.ghost`, `.secondary`, `.accent`, or `variant: ButtonVariant.destructive`.
- Text helpers: apply modifiers first, then at most one style or colour helper, last (`Text('Hi').bold.h1`). Style and colour helpers return a `Widget`, so `Text('Hi').h1.primary` does not compile.
- `CKTableColumn` takes `key` and `label` (not `title`). `context.ckShadows.*` is already a list: `boxShadow: context.ckShadows.md`. `context.ckMotion.standard` is a curve; durations are `fast`, `normal`, `slow`. `CKIconButton` and `CKFab` take an `IconData` (`icon: Icons.add`).
- Animate entrances with `CKAnimate(animation: CKAnimation.slideUp, child: ...)` and `CKAnimate.stagger(children: [...])`.
- Brand enum is `ckcoreBrand` (`castleKeep`, `skyGo`).
- If the `ckcoreui` MCP server is available, use its tools (`getComponent`, `getTokens`, `getPattern`, `generateCode`) before guessing an API.
