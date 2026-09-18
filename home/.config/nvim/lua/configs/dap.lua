local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticSignWarn" })

-- Keymaps now live in the plugin spec (lua/plugins/init.lua) via `keys = {...}`,
-- so they're registered at startup instead of only after this config() runs.
