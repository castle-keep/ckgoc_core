import 'package:ckcoreui/ckcore_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ckcore_docs_app/docs/doc_widgets.dart';

/// Guide to the ckcoreui MCP server and the AI skill / instruction files.
class AiToolsPage extends StatelessWidget {
  const AiToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocsScaffold(
      title: 'AI tools: MCP and skills',
      subtitle:
          'Let Copilot, Claude Code or Cursor write ckcoreui code that is right the first time. '
          'The MCP server gives the assistant live knowledge of components, tokens and brands. '
          'A skill (or instructions file) teaches it the house rules. Use both.',
      children: [
        _Overview(),
        VSpace(height: 24),
        _McpSetup(),
        VSpace(height: 24),
        _McpTools(),
        VSpace(height: 24),
        _PromptPlayground(),
        VSpace(height: 24),
        _SkillsSetup(),
        VSpace(height: 24),
        _Troubleshooting(),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    Widget card(IconData icon, String title, String text) => SizedBox(
          width: 300,
          child: CKContainer.outlined(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: theme.colors.primary),
                const VSpace(height: 8),
                Text(title, style: theme.typography.labelLg),
                const VSpace(height: 4),
                Text(text, style: theme.typography.textSm),
              ],
            ),
          ),
        );

    return DocPanel(
      title: 'Which one do I need?',
      blurb: 'They solve different problems and work best together.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          card(
            Icons.hub_outlined,
            'MCP server',
            'A local tool server. The assistant calls it to look up a component, '
                'list tokens or generate code, instead of guessing from memory.',
          ),
          card(
            Icons.rule_outlined,
            'Skill / instructions',
            'A short rules file the assistant always reads: use CKApp, use tokens, '
                'buttons take child. Prevents the common mistakes.',
          ),
          card(
            Icons.auto_awesome_outlined,
            'Together',
            'Rules keep the code on-pattern, the MCP server fills in the exact '
                'props and examples.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// MCP setup
// ---------------------------------------------------------------------------

enum _Client { copilot, claude, cursor }

enum _Source { npm, local }

class _Step extends StatelessWidget {
  const _Step({
    required this.n,
    required this.title,
    this.body,
    this.code,
    this.codeTitle,
  });

  final int n;
  final String title;
  final String? body;
  final String? code;
  final String? codeTitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colors.primary,
            ),
            child: Text(
              '$n',
              style: theme.typography.labelMd.copyWith(
                color: theme.colors.onPrimary,
              ),
            ),
          ),
          const HSpace(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(title, style: theme.typography.labelLg),
                ),
                if (body != null) ...[
                  const VSpace(height: 4),
                  Text(body!, style: theme.typography.textSm),
                ],
                if (code != null) ...[
                  const VSpace(height: 8),
                  CodeBlock(code: code!, title: codeTitle),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _McpSetup extends StatefulWidget {
  const _McpSetup();

  @override
  State<_McpSetup> createState() => _McpSetupState();
}

class _McpSetupState extends State<_McpSetup> {
  _Client _client = _Client.copilot;
  _Source _source = _Source.npm;

  static const _localPath = '/absolute/path/to/ckgoc_core/mcp/dist/index.js';

  String get _command => _source == _Source.npm ? 'npx' : 'node';
  List<String> get _args =>
      _source == _Source.npm ? ['-y', '@ckcore/ui-mcp'] : [_localPath];

  String get _argsJson => _args.map((a) => '"$a"').join(', ');

  String get _config => switch (_client) {
        _Client.copilot => '''{
  "servers": {
    "ckcoreui": {
      "type": "stdio",
      "command": "$_command",
      "args": [$_argsJson]
    }
  }
}''',
        _Client.cursor => '''{
  "mcpServers": {
    "ckcoreui": {
      "command": "$_command",
      "args": [$_argsJson]
    }
  }
}''',
        _Client.claude => 'claude mcp add ckcoreui -- $_command ${_args.join(' ')}',
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final configFile = switch (_client) {
      _Client.copilot => '.vscode/mcp.json',
      _Client.cursor => '.cursor/mcp.json',
      _Client.claude => 'terminal (run in your Flutter project)',
    };
    var n = 0;

    return DocPanel(
      badge: 'Step by step',
      title: 'Set up the MCP server',
      blurb: 'Pick your editor and where the server comes from. '
          'The steps and config below update to match.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Editor / assistant', style: theme.typography.labelMd),
          const VSpace(height: 6),
          Wrap(
            spacing: 6,
            children: [
              for (final c in _Client.values)
                ChoiceChip(
                  label: Text(switch (c) {
                    _Client.copilot => 'VS Code + Copilot',
                    _Client.claude => 'Claude Code',
                    _Client.cursor => 'Cursor',
                  }),
                  selected: _client == c,
                  onSelected: (_) => setState(() => _client = c),
                ),
            ],
          ),
          const VSpace(height: 12),
          Text('Server source', style: theme.typography.labelMd),
          const VSpace(height: 6),
          Wrap(
            spacing: 6,
            children: [
              ChoiceChip(
                label: const Text('npm (npx)'),
                selected: _source == _Source.npm,
                onSelected: (_) => setState(() => _source = _Source.npm),
              ),
              ChoiceChip(
                label: const Text('Local build'),
                selected: _source == _Source.local,
                onSelected: (_) => setState(() => _source = _Source.local),
              ),
            ],
          ),
          const VSpace(height: 20),
          const Divider(height: 1),
          const VSpace(height: 20),
          _Step(
            n: ++n,
            title: 'Install Node.js 16 or later',
            body: 'Check with the command below. Get it from nodejs.org if missing.',
            code: 'node --version',
            codeTitle: 'terminal',
          ),
          if (_source == _Source.local)
            _Step(
              n: ++n,
              title: 'Build the server from the repo',
              body: 'Only needed for the local build. Note the absolute path to '
                  'mcp/dist/index.js; you will paste it in the config.',
              code: 'cd ckgoc_core/mcp\nnpm install\nnpm run build',
              codeTitle: 'terminal',
            )
          else
            _Step(
              n: ++n,
              title: 'Nothing to install',
              body: 'npx downloads and runs @ckcore/ui-mcp on demand. If npx '
                  'cannot find the package yet, switch to "Local build".',
            ),
          _Step(
            n: ++n,
            title: _client == _Client.claude
                ? 'Register the server'
                : 'Add the server to $configFile',
            body: _client == _Client.claude
                ? 'Adds it for the current project. Add --scope user to make it '
                    'available everywhere.'
                : 'Create the file in your Flutter project root (or merge into the '
                    'existing "${_client == _Client.copilot ? 'servers' : 'mcpServers'}" object).',
            code: _config,
            codeTitle: configFile,
          ),
          _Step(
            n: ++n,
            title: switch (_client) {
              _Client.copilot => 'Start it in Copilot Chat',
              _Client.claude => 'Check it is connected',
              _Client.cursor => 'Enable it in Cursor settings',
            },
            body: switch (_client) {
              _Client.copilot =>
                'Open mcp.json and click the Start code lens above "ckcoreui", '
                    'or run "MCP: List Servers" from the command palette. '
                    'Then switch Copilot Chat to Agent mode and open the tools '
                    'picker to confirm ckcoreui is ticked.',
              _Client.claude =>
                'Run /mcp inside Claude Code. ckcoreui should show as connected '
                    'with 8 tools.',
              _Client.cursor =>
                'Open Settings > MCP and toggle ckcoreui on. A green dot means '
                    'it is running.',
            },
            code: _client == _Client.claude ? 'claude mcp list' : null,
            codeTitle: 'terminal',
          ),
          _Step(
            n: ++n,
            title: 'Ask something',
            body: 'Try: "List all ckcoreui components", then "Generate a login '
                'form with CKTextField and CKButton". You should see the '
                'assistant call a ckcoreui tool before it answers.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tools reference
// ---------------------------------------------------------------------------

class _McpTools extends StatelessWidget {
  const _McpTools();

  static const _tools = <(String, String, String)>[
    ('listComponents', '—', 'Every component with its category.'),
    ('getComponent', 'name', 'Props, variants, import and usage for one component, e.g. CKButton.'),
    ('searchComponent', 'keyword', 'Find components by name, description or category.'),
    ('generateCode', 'componentName, variant?, props?', 'A ready-to-paste Dart snippet.'),
    ('getTokens', 'tokenType', 'Colours, spacing, typography, radius, elevation, shadows, motion, opacity, breakpoints.'),
    ('getBrandConfig', 'brandName', 'Setup and palette for castleKeep or skyGo.'),
    ('listPatterns', '—', 'Names of the documented patterns.'),
    ('getPattern', 'patternName', 'A pattern with code, e.g. setupApp, form, dataTable, animation.'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocPanel(
      title: 'What the server can do',
      blurb: 'Eight tools. You rarely call them by name; the assistant picks one.',
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.4),
          1: FlexColumnWidth(1.6),
          2: FlexColumnWidth(3.4),
        },
        border: TableBorder.all(color: theme.colors.outline),
        children: [
          for (final (i, row) in [
            ('Tool', 'Arguments', 'Returns'),
            ..._tools,
          ].indexed)
            TableRow(
              decoration: i == 0
                  ? BoxDecoration(color: theme.colors.surfaceVariant)
                  : null,
              children: [
                for (final (j, cell) in [row.$1, row.$2, row.$3].indexed)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      cell,
                      style: i == 0
                          ? theme.typography.labelLg
                          : j == 2
                              ? theme.typography.textMd
                              : theme.typography.codeMd,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Prompt playground
// ---------------------------------------------------------------------------

class _PromptPlayground extends StatefulWidget {
  const _PromptPlayground();

  @override
  State<_PromptPlayground> createState() => _PromptPlaygroundState();
}

class _PromptPlaygroundState extends State<_PromptPlayground> {
  static const _prompts = <String, List<(String, String)>>{
    'Components': [
      ('What are the CKButton variants?', 'getComponent'),
      ('Show me CKDataTable with sorting and pagination', 'getComponent'),
      ('Which components can show a loading state?', 'searchComponent'),
    ],
    'Tokens': [
      ('List the spacing tokens', 'getTokens'),
      ('What colours does the SkyGo brand use?', 'getBrandConfig'),
      ('Which motion durations are available?', 'getTokens'),
    ],
    'Generate': [
      ('Generate a login form with CKTextField and CKButton', 'generateCode'),
      ('Create a settings screen with switches and a destructive button', 'generateCode'),
      ('Animate a list of cards so they cascade in', 'getPattern'),
    ],
    'Setup': [
      ('How do I set up my app with ckcoreui?', 'getPattern'),
      ('How do I switch brand and dark mode at runtime?', 'getBrandConfig'),
      ('Add a new brand called Acme', 'getBrandConfig'),
    ],
  };

  String _group = _prompts.keys.first;
  String? _copied;

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) setState(() => _copied = text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    return DocPanel(
      badge: 'Try it',
      title: 'Prompts to try',
      blurb: 'Click a prompt to copy it, then paste it into your assistant. '
          'The tag shows which tool it will most likely call.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            children: [
              for (final g in _prompts.keys)
                ChoiceChip(
                  label: Text(g),
                  selected: _group == g,
                  onSelected: (_) => setState(() => _group = g),
                ),
            ],
          ),
          const VSpace(height: 12),
          AnimatedSwitcher(
            duration: theme.motion.normal,
            child: Column(
              key: ValueKey(_group),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (prompt, tool) in _prompts[_group]!)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(theme.radius.md),
                      onTap: () => _copy(prompt),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _copied == prompt
                                ? theme.colors.success
                                : theme.colors.outlineVariant,
                          ),
                          borderRadius: BorderRadius.circular(theme.radius.md),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('"$prompt"', style: theme.typography.textMd),
                            ),
                            const HSpace(width: 12),
                            CKBadge(label: tool, variant: BadgeVariant.defaultFill),
                            const HSpace(width: 8),
                            Icon(
                              _copied == prompt ? Icons.check : Icons.copy_outlined,
                              size: 16,
                              color: _copied == prompt ? theme.colors.success : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skills
// ---------------------------------------------------------------------------

enum _SkillTarget { claude, copilot }

class _SkillsSetup extends StatefulWidget {
  const _SkillsSetup();

  @override
  State<_SkillsSetup> createState() => _SkillsSetupState();
}

class _SkillsSetupState extends State<_SkillsSetup> {
  _SkillTarget _target = _SkillTarget.claude;

  @override
  Widget build(BuildContext context) {
    final theme = context.ckcoreTheme;
    final claude = _target == _SkillTarget.claude;
    var n = 0;

    return DocPanel(
      badge: 'Step by step',
      title: 'Add the ckcoreui skill',
      blurb: 'Ready-made rules ship in the repo under skills/. Copy them into '
          'your Flutter project so the assistant reads them automatically.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            children: [
              ChoiceChip(
                label: const Text('Claude Code (skill)'),
                selected: claude,
                onSelected: (_) => setState(() => _target = _SkillTarget.claude),
              ),
              ChoiceChip(
                label: const Text('Copilot (instructions file)'),
                selected: !claude,
                onSelected: (_) => setState(() => _target = _SkillTarget.copilot),
              ),
            ],
          ),
          const VSpace(height: 20),
          _Step(
            n: ++n,
            title: 'Get the files',
            body: 'They live in the ckgoc_core repo. Clone it, or download just '
                'the skills folder from GitHub.',
            code: 'git clone https://github.com/castle-keep/ckgoc_core.git',
            codeTitle: 'terminal',
          ),
          _Step(
            n: ++n,
            title: claude ? 'Copy the skill into your project' : 'Copy the instructions file',
            body: claude
                ? 'Project skills live in .claude/skills. To use it in every '
                    'project instead, copy to ~/.claude/skills.'
                : 'Copilot reads .github/copilot-instructions.md from the repo '
                    'root. If you already have one, append the contents.',
            code: claude
                ? 'mkdir -p .claude/skills\ncp -r ckgoc_core/skills/ckcoreui .claude/skills/'
                : 'mkdir -p .github\ncp ckgoc_core/skills/copilot-instructions.md .github/copilot-instructions.md',
            codeTitle: 'terminal, from your Flutter project root',
          ),
          _Step(
            n: ++n,
            title: claude ? 'Restart Claude Code and check it loaded' : 'Check Copilot picks it up',
            body: claude
                ? 'Start a new session. The skill appears in the skills list '
                    'and loads whenever you work on ckcoreui UI. You can also '
                    'invoke it by name: /ckcoreui.'
                : 'In Copilot Chat, send a message and expand References. '
                    '.github/copilot-instructions.md should be listed.',
          ),
          _Step(
            n: ++n,
            title: 'Test it',
            body: 'Ask for "a primary Save button inside a card". A correct '
                'answer uses CKButton(child: Text(...)) and context.ckSpacing, '
                'not a label: parameter or hard-coded padding.',
          ),
          _Step(
            n: ++n,
            title: 'Commit it',
            body: 'Check the file into git so your whole team gets the same rules.',
          ),
          const VSpace(height: 4),
          Text('What the rules cover', style: theme.typography.labelMd),
          const VSpace(height: 6),
          for (final line in const [
            'CKApp replaces MaterialApp (no nesting; ckcoreApp is deprecated)',
            'Tokens instead of colours and pixel values',
            'CK components instead of raw Material widgets',
            'CKButton takes child, not label',
            'Text helper order, brand/mode as state, CKAnimate for motion',
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16, color: theme.colors.success),
                  const HSpace(width: 8),
                  Expanded(child: Text(line, style: theme.typography.textSm)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Troubleshooting
// ---------------------------------------------------------------------------

class _Troubleshooting extends StatelessWidget {
  const _Troubleshooting();

  static const _items = <(String, String)>[
    (
      'The server shows as failed / not started',
      'Run it by hand: node mcp/dist/index.js. It should print '
          '"ckcore-ui MCP server running on stdio" and wait. Any stack trace '
          'there is the real error. Make sure you ran npm run build.'
    ),
    (
      'The assistant never calls a ckcoreui tool',
      'Copilot needs Agent mode, and the ckcoreui tools must be ticked in the '
          'tools picker. In Claude Code run /mcp. Then mention "ckcoreui" in '
          'your prompt.'
    ),
    (
      'npx cannot find @ckcore/ui-mcp',
      'The package may not be on the registry for your org yet. Use the "Local '
          'build" source above.'
    ),
    (
      'It gives outdated props',
      'The knowledge lives in mcp/src/knowledge/*.json. Pull the latest repo, '
          'run npm run build in mcp/, and restart the server.'
    ),
    (
      'Windows: spawn npx ENOENT',
      'Use "command": "cmd" with "args": ["/c", "npx", "-y", "@ckcore/ui-mcp"].'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DocPanel(
      title: 'Troubleshooting',
      blurb: 'Most problems are the server not starting or the tool not enabled.',
      child: CKAccordion(
        items: [
          for (final (q, a) in _items)
            CKAccordionItem(
              title: q,
              content: Align(
                alignment: Alignment.centerLeft,
                child: Text(a),
              ),
            ),
        ],
      ),
    );
  }
}
