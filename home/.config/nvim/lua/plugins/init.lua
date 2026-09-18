return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- enable format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "python",
        "typescript",
        "tsx",
        "javascript",
        "c",
        "cpp",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "gopls",
        "pyright",
        "ruff",
        "vtsls",
        "eslint-lsp",
        "clangd",
        "lua-language-server",

        -- Formatters
        "goimports",
        "gofumpt",
        "prettierd",
        "clang-format",
        "stylua",

        -- Debug adapters (optional but useful)
        "delve", -- Go debugger
        "debugpy", -- Python debugger
        "codelldb", -- cpp debugger
        "js-debug-adapter", -- js/ts debugger
      },
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false, -- Must load on startup to catch directory states
    config = function()
      require("auto-session").setup {
        auto_logging = false,
        auto_save = true, -- Automatically saves your layout on exit
        auto_restore = true, -- Automatically loads your layout on open
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" }, -- Skip system folders

        -- Optional VS Code-like behavior:
        -- Changes your Neovim current directory if you restore a session from another folder
        auto_session_use_git_branch = false,
      }
    end,
  },

  -- ===== Debugging =====
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug: continue/start",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Debug: toggle REPL",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: terminate",
      },
    },
    config = function()
      require "configs.dap"
      require "configs.dap-cpp" -- c/cpp adapter config, cheap to load unconditionally
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: toggle UI",
      },
    },
  },
  { "theHamsta/nvim-dap-virtual-text", opts = {} },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      require "configs.dap-go"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require "configs.dap-python"
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    config = function()
      require "configs.dap-js"
    end,
  },

  -- ===== Daily-use quality-of-life (optional but recommended) =====
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },
}
