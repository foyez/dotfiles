local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
    python = { "ruff_format" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    -- css = { "prettierd" },
    -- html = { "prettierd" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
  format_on_save = {
    timeout_ms = 1500,
    lsp_fallback = true,
  },
}

return options
