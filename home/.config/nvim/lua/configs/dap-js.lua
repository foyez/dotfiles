require("dap-vscode-js").setup {
  node_path = "node",
  debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
  adapters = { "pwa-node", "pwa-chrome" },
}

local dap = require "dap"
for _, lang in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
  dap.configurations[lang] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
