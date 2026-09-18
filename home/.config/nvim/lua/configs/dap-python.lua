-- Points nvim-dap-python at the debugpy Mason installs
local mason_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python3"
require("dap-python").setup(mason_path)
