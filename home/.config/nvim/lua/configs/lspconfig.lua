require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "gopls", -- Go
  "pyright", -- Python (type checking + intellisense)
  "ruff", -- Python (fast linter, also does some LSP actions)
  "vtsls", -- TypeScript/JavaScript
  "clangd", -- C/C++
  "lua_ls",
}

vim.lsp.enable(servers)

-- Go: gofmt-on-save style formatting handled by conform.nvim (below),
-- but gopls itself benefits from these settings:
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = { unusedparams = true, shadow = true },
    },
  },
})

-- clangd: point it at compile_commands.json if you have one (CMake/Bear projects)
vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
})

-- Python: keep Pyright for intellisense, let ruff own linting (avoid duplicate diagnostics)
vim.lsp.config("pyright", {
  settings = {
    python = { analysis = { typeCheckingMode = "basic" } },
  },
})

-- TypeScript/JavaScript: Optimized vtsls setup
vim.lsp.config("vtsls", {
  on_attach = function(client, bufnr)
    -- Disable formatting so it never conflicts with prettier/conform
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Call NvChad's core LSP setup (mappings, autocmds)
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)

    -- Enable inlay hints inline in the buffer (Neovim 0.10+)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
  settings = {
    typescript = {
      -- Automatically detects local node_modules/typescript, falls back globally if missing
      tsdk = "node_modules/typescript/lib",
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
      },
    },
    vtsls = {
      -- Automatically updates imports when you move or rename files
      autoUseWorkspaceTsdk = true,
    },
  },
})

-- ESLint: Run lint fixes automatically every time you save a JS/TS file
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers
