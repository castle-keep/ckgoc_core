# AI tools: MCP server and skills

Let GitHub Copilot, Claude Code or Cursor write ckcoreui code that's right the first time.

| Piece | What it does | Lives in |
| --- | --- | --- |
| **MCP server** | A local tool server. The assistant calls it to look up a component, list tokens or generate code, instead of guessing. | [`mcp/`](../../mcp) |
| **Skill / instructions** | A short rules file the assistant always reads: use `CKApp`, use tokens, buttons take `child`. Prevents the common mistakes. | [`skills/`](../../skills) |

Use both. The rules keep code on-pattern; the server fills in exact props and examples.

> Prefer clicking? The docs app has this guide with a client picker that rewrites the steps and config for you: open **AI Tools** in `doc/flutter_docs`.

---

## 1. Set up the MCP server

**Requirements:** Node.js 16 or later.

### Choose where the server comes from

**A. npm (`npx`)**: nothing to install; the client downloads it on demand.

```
command: npx
args:    -y @ckcore/ui-mcp
```

**B. Local build**: use this if `npx` can't find the package.

```bash
git clone https://github.com/castle-keep/ckgoc_core.git
cd ckgoc_core/mcp
npm install
npm run build
```

```
command: node
args:    /absolute/path/to/ckgoc_core/mcp/dist/index.js
```

Sanity check: `node dist/index.js` should print `ckcore-ui MCP server running on stdio` and wait. Press `Ctrl+C` to stop.

> **Nothing registers itself.** Installing the package does not configure your editor. You add the server to your client's config as shown below.

### VS Code + GitHub Copilot

1. In your Flutter project, create `.vscode/mcp.json`:

   ```json
   {
     "servers": {
       "ckcoreui": {
         "type": "stdio",
         "command": "npx",
         "args": ["-y", "@ckcore/ui-mcp"]
       }
     }
   }
   ```

2. Click **Start** above `ckcoreui` in the file (or run **MCP: List Servers** from the command palette).
3. Open Copilot Chat, switch to **Agent** mode, open the tools picker and confirm `ckcoreui` is ticked.

### Claude Code

```bash
claude mcp add ckcoreui -- npx -y @ckcore/ui-mcp
```

Add `--scope user` to make it available in every project. Run `/mcp` inside Claude Code to confirm it's connected (8 tools).

### Cursor

Create `.cursor/mcp.json`, then enable the server under **Settings > MCP**:

```json
{
  "mcpServers": {
    "ckcoreui": {
      "command": "npx",
      "args": ["-y", "@ckcore/ui-mcp"]
    }
  }
}
```

### Windows

If you see `spawn npx ENOENT`, wrap the command: `"command": "cmd", "args": ["/c", "npx", "-y", "@ckcore/ui-mcp"]`.

---

## 2. What the server can do

| Tool | Arguments | Returns |
| --- | --- | --- |
| `listComponents` | none | Every component with its category |
| `getComponent` | `name` | Props, variants, import and usage, e.g. `CKButton` |
| `searchComponent` | `keyword` | Components matching a name, description or category |
| `generateCode` | `componentName`, `variant?`, `props?` | A ready-to-paste Dart snippet |
| `getTokens` | `tokenType` | Colours, spacing, typography, radius, elevation, shadows, motion, opacity, breakpoints, or `designSpec` (the design team's values mapped to code tokens) |
| `getBrandConfig` | `brandName` | Setup and palette for `castleKeep` or `skyGo`. The match is case-insensitive. |
| `listPatterns` | none | Names of documented patterns |
| `getPattern` | `patternName` | A pattern with code: `setupApp`, `form`, `dataTable`, `animation`, ... |

You rarely call these yourself; the assistant picks one. Prompts to try:

- *"What are the CKButton variants?"*
- *"List the spacing tokens."*
- *"Generate a login form with CKTextField and CKButton."*
- *"How do I switch brand and dark mode at runtime?"*
- *"Animate a list of cards so they cascade in."*

You should see the assistant call a ckcoreui tool before it answers.

---

## 3. Add the skill

Ready-made rules live in [`skills/`](../../skills). Copy them into **your Flutter project** so the assistant reads them automatically.

### Claude Code (skill)

```bash
mkdir -p .claude/skills
cp -r path/to/ckgoc_core/skills/ckcoreui .claude/skills/
```

Use `~/.claude/skills` instead to enable it in every project. Start a new session; the skill loads whenever you work on ckcoreui UI, or invoke it with `/ckcoreui`.

### GitHub Copilot (instructions file)

```bash
mkdir -p .github
cp path/to/ckgoc_core/skills/copilot-instructions.md .github/copilot-instructions.md
```

If you already have that file, append the contents. In Copilot Chat, expand **References** on a reply to confirm it was read.

### Test it

Ask for *"a primary Save button inside a card"*. A correct answer uses `CKButton(child: Text('Save'))` and `context.ckSpacing`, not a `label:` argument or hard-coded padding. Commit the file so your whole team gets the same rules.

### What the rules cover

- `CKApp` replaces `MaterialApp` (no nesting; `ckcoreApp` is deprecated)
- Tokens instead of colours and pixel values
- `CK*` components instead of raw Material widgets
- `CKButton` takes `child`, not `label`
- Text helper order, brand and mode as state, `CKAnimate` for motion

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Server shows as failed / not started | Run `node mcp/dist/index.js` by hand; any stack trace is the real error. Make sure you ran `npm run build`. |
| Assistant never calls a ckcoreui tool | Copilot needs **Agent** mode and the tools ticked. In Claude Code run `/mcp`. Mention "ckcoreui" in your prompt. |
| `npx` can't find `@ckcore/ui-mcp` | Use the **Local build** source. |
| Outdated props in answers | The knowledge lives in `mcp/src/knowledge/*.json`. Pull the repo, run `npm run build` in `mcp/`, restart the server. |

## Maintaining the server (for maintainers)

The server is versioned and published separately from the Flutter package, as `@ckcore/ui-mcp` on npm. Everything it knows lives in `mcp/src/knowledge/*.json`.

### A. Update what the server knows

1. Edit the matching file in `mcp/src/knowledge/`:
   - `components.json`: one entry per public `CK*` class (props, variants, `basicUsage`)
   - `tokens.json`: token names that exist in code; design-team values go under `designSpec`
   - `patterns.json`, `brands.json`
2. Run `flutter test test/mcp/knowledge_sync_test.dart` from the repo root. It fails if a public `CK*` class has no entry, or an entry names a class that doesn't exist.
3. Build and smoke-test:
   ```bash
   cd mcp
   npm ci
   npm run build
   npm run smoke
   ```
   `npm run smoke` starts the built server and calls all 8 tools once.
4. Try it in your editor against the local build (see **Local build** above), then restart the server.

### B. Publish a new version to npm

**One-time setup:** an npm account that owns the `@ckcore` scope, and an npm *Automation* token saved as the repository secret `NPM_TOKEN` (GitHub: Settings > Secrets and variables > Actions).

1. Finish and check step A first.
2. Pick the next version: run `npm view @ckcore/ui-mcp version`, then bump a patch for fixes and data updates (`0.1.1` to `0.1.2`) or a minor for a new tool (`0.2.0`). **Published versions are permanent.**
3. Bump it in two places:
   ```bash
   cd mcp
   npm version 0.1.2 --no-git-tag-version
   ```
   This updates `package.json` and `package-lock.json`. Then edit the version string in `mcp/src/index.ts` (`{ name: "ckcore-ui-mcp", version: "0.1.2" }`).
4. Verify the package: `npm run build && npm run smoke && npm pack --dry-run`. The file list should be `dist/` and `src/knowledge/` (about 40 kB), with no `scripts/`.
5. Commit the release from the repo root. Include `.github/workflows/publish-mcp.yml` only if you changed it:
   ```bash
   git add mcp
   git commit -m "chore(mcp): release 0.1.2"
   ```
6. Tag it and push. Run these as three separate commands and do not add `# comments` to the same line (zsh passes them to `git push` as extra arguments and the tag push fails):
   ```bash
   git tag mcp-v0.1.2
   git push origin main
   git push origin mcp-v0.1.2
   ```
7. Watch GitHub > Actions > **Publish MCP server** (about 2 minutes). It checks that the tag equals the `package.json` version, checks that `NPM_TOKEN` exists, runs `npm ci`, the build and `npm run smoke`, then `npm publish --provenance --access public`.
8. Confirm: `npm view @ckcore/ui-mcp version` prints the new version. Clients that start the server with `npx -y @ckcore/ui-mcp` pick it up the next time the server starts.

### If something goes wrong

| What you see | What to do |
| --- | --- |
| Workflow fails at "Tag must match package.json" | The tag and `package.json` differ. Delete the tag (`git tag -d mcp-v0.1.2` and `git push origin :refs/tags/mcp-v0.1.2`), fix the version, commit, tag again. |
| Workflow fails at "NPM_TOKEN secret must exist" | Add the secret, then re-run the workflow from the Actions page. The tag can stay. |
| Smoke test fails in the workflow | Nothing was published. Fix it, delete the tag as above, commit, and tag the same version again. |
| `npm publish` says you cannot publish over an existing version | That version already exists on npm. Bump to the next one. |
| A bug is found after publishing | Versions cannot be reused. Fix it and publish the next patch. |

**Manual fallback** (no GitHub Actions): `cd mcp && npm login && npm run build && npm run smoke && npm pack --dry-run && npm publish --access public`. A local publish has no provenance attestation.

More detail: [Development](../../mcp/README.md#development) and [Releasing](../../mcp/README.md#releasing-maintainers) in the MCP README.
