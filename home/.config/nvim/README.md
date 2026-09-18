# NvChad NeoVim

## 📚 Table of Contents

- **1. [📁 File Explorer (NvimTree)](#-file-explorer-nvimtree)**  
- **2. [🔍 Search (Telescope)](#-search-telescope)**  
- **3. [📂 Buffers (Tabs)](#-buffers-tabs)**  
- **4. [🪟 Window Management (Splits)](#-window-management-splits)**  
- **5. [✏️ Modes](#️-modes)**  
- **6. [🚀 Navigation](#-navigation)**  
- **7. [✂️ Editing](#️-editing)**  
    - [7.1 Copy (Yank)](#copy-yank)  
    - [7.2 Paste](#paste)  
    - [7.3 Delete](#delete)
- **8. [↩ Undo / Redo](#-undo--redo)**  
- **9. [🔎 Search & Replace](#-search--replace)**  
- **10. [💾 File Commands](#-file-commands)**  
- **11. [⚡ Useful NvChad Extras](#-useful-nvchad-extras)**  
- **12. [📌 Essential Shortcuts to Memorize First](#-essential-shortcuts-to-memorize-first)**

---

> **Leader key:** `<leader>` = **Space** (default in NvChad)

## 📁 File Explorer (NvimTree)

| Shortcut      | Action                                           |
| ------------- | ------------------------------------------------ |
| `Ctrl + n`    | Toggle file explorer                             |
| `a`           | Create file/folder (`folder/` creates directory) |
| `r`           | Rename                                           |
| `d`           | Delete                                           |
| `c`           | Copy                                             |
| `x`           | Cut (move)                                       |
| `p`           | Paste                                            |
| `R`           | Refresh tree                                     |
| `H`           | Toggle hidden files                              |
| `Enter` / `o` | Open file                                        |
| `Tab`         | Preview file                                     |

> The cursor must be inside **NvimTree** for the single-letter commands to work.

---

## 🔍 Search (Telescope)

| Shortcut     | Action                             |
| ------------ | ---------------------------------- |
| `<leader>ff` | Find files                         |
| `<leader>fw` | Live grep (search text in project) |
| `<leader>fb` | Find open buffers                  |
| `<leader>fh` | Help tags                          |
| `<leader>fo` | Recent files                       |
| `<leader>fc` | Find word under cursor             |
| `<leader>cm` | Search commands (if enabled)       |

---

## 📂 Buffers (Tabs)

| Shortcut      | Action                             |
| ------------- | ---------------------------------- |
| `Tab`         | Next buffer                        |
| `Shift + Tab` | Previous buffer                    |
| `<leader>x`   | Close current buffer               |
| `<leader>b`   | Pick buffer                        |
| `<leader>bc`  | Close other buffers *(if enabled)* |

---

## 🪟 Window Management (Splits)

| Shortcut     | Action               |
| ------------ | -------------------- |
| `<leader>sv` | Vertical split       |
| `<leader>sh` | Horizontal split     |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split  |
| `Ctrl + h`   | Move left            |
| `Ctrl + j`   | Move down            |
| `Ctrl + k`   | Move up              |
| `Ctrl + l`   | Move right           |

---

## ✏️ Modes

| Key        | Mode                  |
| ---------- | --------------------- |
| `i`        | Insert                |
| `a`        | Append                |
| `A`        | Append at end of line |
| `o`        | New line below        |
| `O`        | New line above        |
| `v`        | Visual                |
| `V`        | Visual Line           |
| `Ctrl + v` | Visual Block          |
| `Esc`      | Back to Normal        |
| `:`        | Command mode          |

---

## 🚀 Navigation

### Character Movement

| Shortcut | Action |
| -------- | ------ |
| `h`      | Left   |
| `j`      | Down   |
| `k`      | Up     |
| `l`      | Right  |

---

### Word Movement

| Shortcut | Action            |
| -------- | ----------------- |
| `w`      | Next word         |
| `b`      | Previous word     |
| `e`      | End of word       |
| `ge`     | Previous word end |

---

### Line Movement

| Shortcut | Action                    |
| -------- | ------------------------- |
| `0`      | Beginning of line         |
| `^`      | First non-blank character |
| `$`      | End of line               |

---

### File Navigation

| Shortcut    | Action           |
| ----------- | ---------------- |
| `gg`        | Top of file      |
| `G`         | Bottom of file   |
| `:{number}` | Go to line       |
| `%`         | Matching bracket |
| `Ctrl + o`  | Jump backward    |
| `Ctrl + i`  | Jump forward     |

---

### Scrolling

| Shortcut   | Action                 |
| ---------- | ---------------------- |
| `Ctrl + d` | Half page down         |
| `Ctrl + u` | Half page up           |
| `Ctrl + f` | Full page down         |
| `Ctrl + b` | Full page up           |
| `zz`       | Center current line    |
| `zt`       | Current line at top    |
| `zb`       | Current line at bottom |

---

## ✂️ Editing

### Copy (Yank)

| Shortcut | Action              |
| -------- | ------------------- |
| `yy`     | Copy current line   |
| `yw`     | Copy word           |
| `y$`     | Copy to end of line |
| `y}`     | Copy paragraph      |

---

### Paste

| Shortcut | Action              |
| -------- | ------------------- |
| `p`      | Paste after cursor  |
| `P`      | Paste before cursor |

---

### Delete

| Shortcut | Action                   |
| -------- | ------------------------ |
| `dd`     | Delete line              |
| `dw`     | Delete word              |
| `diw`    | Delete word under cursor |
| `D`      | Delete to end of line    |
| `x`      | Delete character         |

---

### Change

| Shortcut | Action                |
| -------- | --------------------- |
| `cc`     | Change entire line    |
| `ciw`    | Change word           |
| `cw`     | Change to end of word |
| `C`      | Change to end of line |

---

### Indentation

| Shortcut | Action              |
| -------- | ------------------- |
| `>>`     | Indent line         |
| `<<`     | Un-indent line      |
| `>`      | Indent selection    |
| `<`      | Un-indent selection |
| `=`      | Auto-indent selection |

---

## ↩ Undo / Redo

| Shortcut   | Action              |
| ---------- | ------------------- |
| `u`        | Undo                |
| `Ctrl + r` | Redo                |
| `.`        | Repeat last command |

---

## 🔎 Search & Replace

| Shortcut         | Action                     |
| ---------------- | -------------------------- |
| `/text`          | Search forward             |
| `?text`          | Search backward            |
| `n`              | Next result                |
| `N`              | Previous result            |
| `*`              | Search word under cursor   |
| `#`              | Search previous occurrence |
| `<leader>nh`     | Clear search highlight     |
| `:%s/old/new/g`  | Replace all in file        |
| `:%s/old/new/gc` | Replace with confirmation  |

---

## 💾 File Commands

| Command | Action              |
| ------- | ------------------- |
| `:w`    | Save                |
| `:wa`   | Save all            |
| `:q`    | Quit                |
| `:q!`   | Force quit          |
| `:wq`   | Save & quit         |
| `:x`    | Save & quit         |
| `ZZ`    | Save & quit         |
| `ZQ`    | Quit without saving |

---

## ⚡ Useful NvChad Extras

| Shortcut     | Action                              |
| ------------ | ----------------------------------- |
| `<leader>th` | Toggle theme picker                 |
| `<leader>ch` | Open mappings cheat sheet           |
| `<leader>e`  | Focus NvimTree *(if mapped)*        |
| `<leader>fm` | Format current file (LSP/Formatter) |
| `gd`         | Go to definition                    |
| `gD`         | Go to declaration                   |
| `gr`         | Find references                     |
| `gi`         | Go to implementation                |
| `K`          | Hover documentation                 |
| `<leader>ca` | Code actions                        |
| `<leader>rn` | Rename symbol                       |
| `[d`         | Previous diagnostic                 |
| `]d`         | Next diagnostic                     |

---

## 📌 Essential Shortcuts to Memorize First

### Files

* `Ctrl + n` → File explorer
* `<leader>ff` → Find files
* `<leader>fw` → Search project text

### Buffers

* `Tab`
* `Shift + Tab`
* `<leader>x`

### Splits

* `<leader>sv`
* `<leader>sh`
* `Ctrl + h/j/k/l`

### Navigation

* `w`, `b`, `0`, `^`, `$`
* `gg`, `G`
* `%`
* `Ctrl + d/u`

### Editing

* `yy`
* `dd`
* `p`
* `u`
* `Ctrl + r`
* `ciw`
* `diw`

### Search

* `/`
* `n`
* `*`
* `<leader>nh`

### Save/Quit

* `:w`
* `:wq`
* `:q`
* `:q!`

