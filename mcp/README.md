# ckcoreui MCP Server

Model Context Protocol (MCP) server for [ckcoreui](https://github.com/castle-keep/ckcoreui) — the Flutter design system for multiple brands.

This MCP server makes ckcoreui knowledge accessible to Copilot, Claude Code and Cursor, enabling intelligent code generation, component discovery, token lookup, and design system guidance directly in VS Code.

## Features

**Component Knowledge** — Get full details on 20+ components with props, variants, and examples  
**Design Tokens** — Lookup colors, spacing, typography, radius, elevation, shadows, motion, opacity, and breakpoints  
**Code Generation** — Generate Dart code snippets for components  
**Pattern Library** — Learn common patterns and best practices  
**Brand Configuration** — Setup guides for CastleKeep and SkyGo brands  
**Search** — Find components by name, description, or category  

## Installation

Requires Node.js 16+. **Installing does not configure your editor.** Add the server to your client's MCP config (below).

### 1. Get the server

**npm:** nothing to install; clients run it with `npx -y @ckcore/ui-mcp`.

**Local build** (if `npx` can't find the package):

```bash
cd mcp
npm install
npm run build        # produces dist/index.js
node dist/index.js   # prints "ckcore-ui MCP server running on stdio"; Ctrl+C to stop
```

### 2. Register it with your client

| Client | Where | Config |
| --- | --- | --- |
| VS Code + Copilot | `.vscode/mcp.json` | `{"servers":{"ckcoreui":{"type":"stdio","command":"npx","args":["-y","@ckcore/ui-mcp"]}}}` |
| Claude Code | terminal | `claude mcp add ckcoreui -- npx -y @ckcore/ui-mcp` |
| Cursor | `.cursor/mcp.json` | `{"mcpServers":{"ckcoreui":{"command":"npx","args":["-y","@ckcore/ui-mcp"]}}}` |

For a local build use `"command": "node"` and `"args": ["/absolute/path/to/mcp/dist/index.js"]`.

In VS Code, click **Start** above the server in `mcp.json`, then use Copilot Chat in **Agent** mode and tick `ckcoreui` in the tools picker. In Claude Code, run `/mcp` to check it's connected.

Full walkthrough with troubleshooting: [doc/getting-started/ai-tools.md](../doc/getting-started/ai-tools.md).

### Skills

Pair the server with the rules files in [`../skills`](../skills): a Claude Code skill (`skills/ckcoreui`) and a Copilot instructions file (`skills/copilot-instructions.md`).

## Usage with Copilot

Once installed, open Copilot Chat in any Flutter project and ask:

### Component Questions
```
"How do I use CKButton?"
"Show me CKDataTable examples"
"What are the CKButton variants?"
```

### Token Lookup
```
"What colors are available in ckcoreui?"
"Show me the spacing tokens"
"What typography styles do we have?"
"List all design tokens"
```

### Code Generation
```
"Generate a login form with CKTextField and CKButton"
"Create a CKButton with destructive variant"
"Show me how to use CKDataTable with sorting and filtering"
```

### Patterns & Best Practices
```
"How do I set up my app with ckcoreui?"
"Show me a form pattern"
"How do I switch between themes?"
"How do I build a responsive layout?"
```

### Brand & Theme Setup
```
"How do I configure the CastleKeep brand?"
"What's the difference between CastleKeep and SkyGo?"
"How do I enable dark mode?"
```

## MCP Tools

The server provides these tools:

| Tool | Description |
|------|-------------|
| `getComponent` | Get component details, props, variants, examples |
| `getTokens` | Retrieve design tokens by type |
| `searchComponent` | Search components by keyword |
| `generateCode` | Generate Dart code snippets |
| `getBrandConfig` | Get brand setup and colors (`brandName`: `castleKeep` or `skyGo`) |
| `getPattern` | Learn common patterns and best practices |
| `listComponents` | List all available components |
| `listPatterns` | List all available patterns |

## Examples

### Ask Copilot for a component

**Prompt:** "How do I create a CKButton with secondary variant and loading state?"

**Response includes:**
- Component name and category
- Available variants (primary, secondary, outline, ghost, destructive, etc.)
- All props and their types
- Usage examples
- Import statement

### Generate a form

**Prompt:** "Generate a login form using ckcoreui components"

**Response:**
```dart
import 'package:ckcoreui/ckcoreui.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget { ... }
```

### Look up design tokens

**Prompt:** "What are the available spacing tokens?"

**Response:**
```
spacing:
  xxs: 2px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  x2l: 48px
  x3l: 64px
  x4l: 96px
  x5l: 128px
```

## Troubleshooting

### Server doesn't start or shows as failed

Run `node dist/index.js` by hand. Any stack trace is the real error. Make sure you ran `npm run build`, and that every file in `src/knowledge/` is valid JSON.

### The assistant never calls a ckcoreui tool

Copilot needs **Agent** mode with the tools ticked. In Claude Code run `/mcp`. Mention "ckcoreui" in your prompt.

### Outdated component information

Pull the repo, run `npm run build` in `mcp/`, and restart the server.

## Development

### Folder structure

```
mcp/
├── src/
│   ├── index.ts              # MCP server (tools and handlers)
│   └── knowledge/            # What the assistant knows
│       ├── components.json   # component props, variants, examples
│       ├── tokens.json       # design tokens
│       ├── patterns.json     # usage patterns and best practices
│       └── brands.json       # CastleKeep / SkyGo setup
├── dist/                     # compiled output (generated, git-ignored)
├── package.json
└── tsconfig.json
```

### Updating the knowledge base

When the library changes, edit the matching JSON file (a new component goes in `components.json`, a new token family in `tokens.json`, and so on), then rebuild with `npm run build` and restart the server. The files must stay valid JSON; the server refuses to start otherwise. Keep [`skills/`](../skills) in step with any API rename.

### Build from source

```bash
npm install
npm run build
npm start
```

### For contributors

```bash
npm install
npm run dev  # Watch mode TypeScript compilation
```

## Releasing (maintainers)

The server is versioned independently of the Flutter package (first release: `0.1.0`).

**Automatic (recommended).** One-time: create an npm *Automation* token for an account that owns the `@ckcore` scope and save it as the repo secret `NPM_TOKEN`. Then:

```bash
cd mcp
npm version patch --no-git-tag-version   # or minor / major; bumps package.json and the lockfile
# also bump the version string in src/index.ts, then:
git commit -am "chore(mcp): release 0.1.1"
git tag mcp-v0.1.1                        # must match package.json
git push && git push origin mcp-v0.1.1
```

The [publish-mcp workflow](../.github/workflows/publish-mcp.yml) checks the tag against `package.json`, builds, smoke-tests that the server lists its tools, and runs `npm publish --provenance --access public`. For the very first release, skip the bump: tag `mcp-v0.1.0`.

**Manual.**

```bash
cd mcp
npm login
npm run build
npm pack --dry-run       # check the file list
npm publish --access public
```

Versions are permanent: a published number can't be reused. Verify with `npx -y @ckcore/ui-mcp`.

## Documentation

- [ckcoreui main repository](https://github.com/castle-keep/ckgoc_core)
- [ckcoreui Getting Started](https://github.com/castle-keep/ckgoc_core/tree/main/doc/getting-started)
- [Design System Overview](https://github.com/castle-keep/ckgoc_core/blob/main/doc/CORE/overview_design_system.md)
- [AI tools guide (all editors)](https://github.com/castle-keep/ckgoc_core/blob/main/doc/getting-started/ai-tools.md)

## License

MIT — See LICENSE in main ckcoreui repository

## Support

Issues or questions? Open an issue on [GitHub](https://github.com/castle-keep/ckgoc_core/issues)
