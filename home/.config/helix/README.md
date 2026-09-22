# Helix Setup (Go, TS, Python, C++, MD, YAML)

## 1. Mental model shift: selection → action

Vim: `d3w` = *delete* then *3 words*. Helix: `3w` selects, `d` acts on the selection. You always see what you're about to operate on highlighted before you commit. Multiple cursors are first-class, not a plugin (`C` adds a cursor, `,` collapses to one).

This means muscle memory transfers partially but not fully — expect a week of friction, then it's faster than Vim for structural edits (renaming, multi-cursor refactors, matching-node selection).

---

## 2. Install

```bash
# macOS
brew install helix

# Arch
sudo pacman -S helix

# Debian/Ubuntu (get a recent build, apt's is often stale)
# use the official .deb release or:
cargo install --locked --path helix-term  # from source, if you want bleeding-edge

# Fetch all tree-sitter grammars + queries after install
hx --grammar fetch
hx --grammar build
```

Verify everything: `hx --health` — shows every language, whether its LSP/formatter/DAP binary is found on `$PATH`. Run this after any change; it's your single most useful diagnostic command.

---

## 3. Config file layout

```
~/.config/helix/
├── config.toml       # editor behavior, keymaps, theme
├── languages.toml    # LSP/formatter/DAP wiring per language
└── ignore            # global ignore patterns for file picker
```

Project-local overrides go in `.helix/languages.toml` and `.helix/config.toml` inside a repo — genuinely useful for devops repos with mixed YAML dialects (Helm templates vs plain k8s manifests vs Ansible).

### `config.toml`

```toml
theme = "catppuccin_mocha"   # or "onedark", "gruvbox", "nord" — see :theme <tab>

[editor]
line-number = "relative"
cursorline = true
color-modes = true          # different cursor color per mode — huge for spotting mode at a glance
bufferline = "multiple"
true-color = true
rulers = [80, 120]
auto-format = true
auto-save = false           # set true if you want vscode-like autosave
completion-trigger-len = 1
idle-timeout = 200
end-of-line-diagnostics = "hint"
default-line-ending = "lf"

[editor.statusline]
left = ["mode", "spinner", "version-control", "file-name"]
center = []
right = ["diagnostics", "selection-count", "position", "file-encoding", "file-type"]

[editor.lsp]
display-messages = true
display-inlay-hints = true
display-signature-help = true

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.file-picker]
hidden = false               # show dotfiles — you'll want .env, .helix, .github visible
git-ignore = true

[editor.whitespace.render]
space = "none"
tab = "all"
newline = "none"

[editor.indent-guides]
render = true
character = "╎"

[editor.soft-wrap]
enable = true               # good for Markdown/YAML prose
max-wrap = 25
wrap-indicator = ""

[editor.auto-pairs]
"(" = ")"
"[" = "]"
"{" = "}"
"\"" = "\""

[keys.normal]
# Vim-muscle-memory bridges
"C-s" = ":w"
"C-q" = ":q"
space.w = ":w"
space.q = ":q"
# jk to escape insert (add under [keys.insert] below, not here)

[keys.insert]
"j" = { "k" = "normal_mode" }   # jk → Esc, classic Vim habit
```

---

## 4. Language servers, formatters, linters to install

Install these binaries; Helix's built-in `languages.toml` already knows how to invoke them — you just need them on `$PATH`.

| Language | LSP | Formatter | Linter/extra |
|---|---|---|---|
| Go | `gopls` (`go install golang.org/x/tools/gopls@latest`) | `gofmt`/`goimports` (built into gopls formatting) | `golangci-lint` |
| TypeScript/JS | `typescript-language-server` + `typescript` (`npm i -g typescript-language-server typescript`) | `prettier` | `eslint` (via `vscode-eslint-language-server` optionally) |
| Python | `pyright` or `basedpyright` (`pip install pyright`) — pair with `ruff` for lint+format | `ruff format` or `black` | `ruff` (`pip install ruff`) — also works as an LSP now (`ruff server`) |
| C/C++ | `clangd` (usually via `apt install clangd` / `brew install llvm`) | `clang-format` | needs `compile_commands.json` — generate with CMake (`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`) or `bear` for non-CMake builds |
| Markdown | `marksman` | `prettier` (optional) | — |
| YAML | `yaml-language-server` (`npm i -g yaml-language-server`) | `prettier` or `yamlfmt` | can bind to k8s/schema-store schemas (below) |
| Bash | `bash-language-server` | `shfmt` | `shellcheck` (wired in automatically if installed) |
| Terraform/HCL | `terraform-ls` | `terraform fmt` | — |
| Docker | `docker-langserver` (`npm i -g dockerfile-language-server-nodejs`) | — | `hadolint` |
| JSON | `vscode-json-language-server` | `prettier` | — |
| TOML | `taplo` | `taplo fmt` | — |

Quick install block for a devops box:

```bash
# Go
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest   # debugger

# Node-based LSPs
npm i -g typescript typescript-language-server \
       yaml-language-server bash-language-server \
       dockerfile-language-server-nodejs vscode-langservers-extracted

# Python
pip install pyright ruff basedpyright

# C++
brew install llvm bear   # or apt install clangd bear

# Rust/formatters
cargo install taplo-cli --locked
brew install shfmt shellcheck hadolint yamlfmt marksman
```

Run `hx --health go`, `hx --health python`, etc. per language to confirm binaries are detected.

---

## 5. `languages.toml` — the important devops-specific bits

```toml
# ~/.config/helix/languages.toml

[[language]]
name = "go"
auto-format = true
language-servers = ["gopls"]

[language-server.gopls]
command = "gopls"

[language-server.gopls.config.gopls]
staticcheck = true
gofumpt = true                     # stricter gofmt, install gofumpt if you use it
usePlaceholders = true
completeUnimported = true

[[language]]
name = "python"
auto-format = true
language-servers = ["ruff", "pyright"]   # ruff for lint/format+quick actions, pyright for types

[language-server.ruff]
command = "ruff"
args = ["server"]

[language-server.pyright]
command = "pyright-langserver"
args = ["--stdio"]

[[language]]
name = "yaml"
auto-format = true
language-servers = ["yaml-language-server"]

[language-server.yaml-language-server]
command = "yaml-language-server"
args = ["--stdio"]

[language-server.yaml-language-server.config.yaml]
schemas = { kubernetes = "/*.k8s.yaml", "https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.29.0-standalone-strict/all.json" = "/*.k8s.yaml" }
format = { enable = true }
validation = true
completion = true

[[language]]
name = "markdown"
language-servers = ["marksman"]
auto-format = false   # usually you don't want to reflow prose on save

[[language]]
name = "dockerfile"
language-servers = ["docker-langserver"]

[[language]]
name = "hcl"    # Terraform
language-servers = ["terraform-ls"]
auto-format = true
```

**Kubernetes schema tip:** the yaml-language-server config above auto-validates any file matching `*.k8s.yaml` against the K8s schema — rename your manifests with that suffix (or match on path glob) and you get real-time squiggles for invalid manifests, same as the VS Code Kubernetes extension.

**Project-local override for mixed repos:** drop a `.helix/languages.toml` in a Helm chart repo to point yaml-language-server at Helm's Go-template YAML (which isn't strictly valid YAML) — set `language-servers = []` for `templates/*.yaml` via a project override, or just accept some false-positive squiggles inside `{{ }}` blocks; there's no perfect fix for Helm templating, same limitation exists in VS Code.

---

## 6. Core keybinds you'll actually use daily

Helix has a full interactive cheatsheet built in: use `:tutor` for the interactive tutorial, and hold any leader key (e.g. `g`, `space`, `m`) to see a popup of what's available. This beats memorizing a static list.

That said, the ones worth burning into memory immediately:

**Selection & movement**
- `w` / `b` / `e` — select word forward/back/end (note: *selects*, doesn't just move)
- `x` — select whole line, repeatable to extend
- `%` — select entire buffer
- `mm` — jump to matching bracket; `mi(` — select *inside* parens (works for any bracket/tag pair, like vim's `ci(`)
- `f<char>` / `t<char>` — find/till character, extends selection
- `<A-;>` — flip selection anchor/head (huge for fixing "selected backwards" moments)

**Multiple cursors — the killer feature**
- `C` — add cursor on line below (like `Ctrl-Alt-Down` in VS Code)
- `s` — select all regex matches *within* current selection (e.g. select a function, `s` + `\w+Error` to grab every error identifier inside it)
- `%` then `s` then pattern — select all matches in buffer, then edit all at once
- `,` — collapse back to single cursor
- `&` — align cursors (useful for YAML key alignment)

**Editing**
- `mi{`, `mi[`, `mi"` — select inside braces/brackets/quotes (surround-aware, no plugin needed)
- `ms<char>` — surround selection with a character (wrap selection in quotes/brackets)
- `mr<char1><char2>` — replace surrounding pair
- `md<char>` — delete surrounding pair
- `>` / `<` — indent/dedent selection

**LSP (all under `g` and `space`)**
- `gd` — go to definition
- `gr` — go to references
- `gI` — go to implementation
- `space-a` — code action (quick fix, auto-import, extract var — same as VS Code's lightbulb)
- `space-r` — rename symbol (renames across the whole workspace)
- `space-k` — hover docs
- `space-s` — document symbol picker (jump to any function/type in file)
- `space-S` — workspace symbol picker (jump to any symbol in the whole project — replaces `Ctrl-T` in VS Code)
- `space-d` — document diagnostics picker
- `space-D` — workspace diagnostics picker
- `]d` / `[d` — next/prev diagnostic

**File/project navigation**
- `space-f` — file picker (fuzzy find, like `Ctrl-P`)
- `space-F` — file picker including ignored files
- `space-b` — buffer picker
- `space-/` — global grep search across the project (ripgrep-backed, respects `.gitignore`)
- `Ctrl-w` then `hjkl`/`v`/`s` — window/split management, exactly like Vim

**Version control (built in, no plugin)**
- `space-g` — git-related pickers (changed files, etc. — coverage varies by version, check `:health`)
- The gutter shows `+`/`~`/`-` for uncommitted changes automatically, no config needed.
- `[c` / `]c` — jump between diff hunks

**Command mode**
- `:` — command palette (`:w`, `:q`, `:wq`, `:sh <cmd>` to run shell, `:reload` to reload config)
- `:sh lazygit` — drop into a full TUI git client in a shell pane without leaving Helix (see §10)

---

## 7. Duplicate a line and edit repeats at once (VS Code multi-cursor equivalent)

Common pattern: copy a line, paste it below, then tweak a couple of repeated words on the new line — like `OK = "OK"` → `KO = "KO"`. Easiest way in Helix:

1. `Y` — **yank the whole line** in one keystroke (capital Y = "yank line", shortcut for select-line + yank).
2. `p` — paste it below. You're now sitting on the duplicate.
3. `x` — select the new line, then `s` and type the word you want to replace (e.g. `OK`), Enter. This drops a cursor on **every** occurrence of that word on the line — both the bare word and the one inside quotes.
4. `c` — change (deletes all selected matches and opens insert mode at every cursor at once), type the replacement (e.g. `KO`), `Esc`.

One line, four keys: `Y p x s` *(type match)* `Enter c` *(type replacement)* `Esc`.

General rule to remember: **select a scope → `s` + regex to fan out cursors on every match inside it → act on all of them at once (`c`/`d`/etc.)**. That combo is Helix's version of VS Code's "select all occurrences" — scope first, then multi-select, then edit.

---

## 8. Checking errors and warnings (diagnostics)

Helix shows diagnostics inline automatically (squiggly underlines + a message at end-of-line, controlled by `end-of-line-diagnostics` in your config), but for actually navigating them:

- `space-d` — **diagnostics picker for the current file** — a searchable list, `Enter` jumps to the one selected.
- `space-D` — **diagnostics picker for the whole workspace** — every error/warning across every open-able file, not just the current buffer.
- `]d` / `[d` — jump to the **next / previous** diagnostic in the current file, no picker needed — fastest way to walk through errors one by one.
- Hover any underlined text and press `space-k` to see the full diagnostic message + docs in a popup, instead of guessing from the truncated end-of-line text.
- `hx --health <language>` (outside the editor) — checks whether the LSP/formatter binary itself is even installed and found, which is the #1 cause of "no diagnostics are showing up at all."
- The **status line** (bottom right, from the `[editor.statusline]` config above) shows a running error/warning count for the current file at a glance, similar to VS Code's bottom-bar problem counter.

---

## 9. Copying to the system clipboard

By default Helix's `y`/`d`/`c` yank into its **internal register**, not your OS clipboard — so pasting into another app (Slack, browser, terminal outside Helix) needs the clipboard-specific commands:

- `space-y` — yank selection to the **system clipboard**
- `space-p` — paste **after** cursor from the system clipboard
- `space-P` — paste **before** cursor from the system clipboard
- `space-R` — replace current selection with system clipboard contents

Mnemonic: plain `y`/`p` = internal register (fast, same-buffer edits); `space-y`/`space-p` = system clipboard (crossing outside Helix). If you want `y`/`p` to *always* hit the system clipboard like a normal GUI editor, you can remap `y`/`p` to the clipboard versions in `config.toml`, but most people keep them separate since the internal register survives cleaner for multi-cursor/register-based workflows.

---

## 10. Debugging (DAP)

Helix has a built-in debug adapter client — no plugin needed, just an external debug adapter binary per language and a bit of config.

**Install the adapters:**
```bash
go install github.com/go-delve/delve/cmd/dlv@latest   # Go
pip install debugpy                                    # Python
# C++: lldb-dap (ships with LLVM) or Microsoft's cpptools adapter
```

**Wire it up** in `.helix/languages.toml` (project-local) or the global one, e.g. for Go:
```toml
[[language]]
name = "go"
debugger = { name = "go", transport = "tcp", command = "dlv", args = ["dap"], port-arg = "-l 127.0.0.1:{}" }
```
Helix ships built-in debugger configs for several languages already (check `hx --health go` — it'll tell you if a debug adapter is detected); you mostly need this block for less common setups.

**Using it — everything lives under `space-g` (debug menu, distinct from the `space-g` git pickers, shown contextually) or dedicated keys:**
- `:dbg` or the debug menu — start a debug session
- `space-g b` — toggle breakpoint on current line
- `space-g c` — continue
- `space-g i` / `space-g o` — step into / step out
- `space-g n` — step over (next)
- `space-g e` — edit/manage breakpoints
- The terminal splits to show variables, call stack, and breakpoints while the debuggee runs, similar to VS Code's debug sidebar but text-based

**Honest take:** this is the least polished part of Helix compared to VS Code. It works for straightforward Go/Python breakpoint-and-step sessions, but for anything gnarly (conditional breakpoints, complex watch expressions, remote/container debugging), most people still reach for `dlv` directly on the CLI, `pdb`/`debugpy` standalone, or just open VS Code for that one session. Don't force it if it's fighting you — the CLI debugger is always there as a fallback (`dlv debug`, `python -m pdb`, `gdb`).

---

## 11. Filling the "plugin ecosystem" gap

Helix deliberately has **no plugin system** like Neovim's Lua ecosystem — this is the main thing you'll miss coming from a heavily-plugin'd Vim setup. Compensate with external tools invoked via `:sh` or a terminal multiplexer:

- **Git UI:** `lazygit` via `:sh lazygit` or a tmux pane alongside Helix — most people run Helix inside tmux/zellij and keep a lazygit pane open rather than expecting an in-editor git UI like Fugitive.
- **File tree:** Helix has no sidebar file tree by design (philosophy: fuzzy-picker > tree browsing). If you want one, run `yazi` or `lf` in a split terminal pane, or lean harder on `space-f`.
- **AI completion:** experimental LSP-shim projects like `helix-gpt` or `lsp-ai` bridge Copilot/OpenAI/Ollama into Helix's LSP completion pipeline if you want inline AI suggestions — these are third-party and less polished than native Copilot extensions, worth trying only if you specifically miss AI autocomplete.

---

## 12. Recommended terminal workflow for devops work

```
tmux
├── pane 1: hx .                     (your code)
├── pane 2: lazygit                  (commits, diffs, branches)
└── pane 3: shell for kubectl/terraform/docker/make
```

This mirrors VS Code's integrated terminal + source control panel, just externalized — and it's the idiomatic Helix workflow since the editor intentionally stays lean.

---

## 13. First-week checklist

1. Run `hx --health` and install anything marked missing for Go/TS/Python/C++/YAML/Markdown.
2. Copy the `config.toml` and `languages.toml` snippets above, adjust theme to taste (`:theme` + tab-complete to preview live).
3. Run `:tutor` once — 10 minutes, covers the selection model properly.
4. Force yourself to use `mi(`, `s` for multi-select, and `space-a` for code actions for a few days instead of falling back to single-cursor editing — that's where Helix actually beats Vim/VS Code for refactor-heavy devops work (bulk-editing YAML manifests, renaming across a Go module, etc.).
5. Practice `]d`/`[d` and `space-d` for diagnostics, and `space-y`/`space-p` for clipboard, until they're automatic.
6. Set up the tmux/lazygit pane pattern from §12 so you're not missing VS Code's git panel.

## 14. Important Keys

```js
// copy "hi there"
// vim: vi"y
// helix: mi"y
console.log("hi there")

// replace "hi" with "hi there"
// vim: vi"p
// helix: mi"R
console.log("hi")
```