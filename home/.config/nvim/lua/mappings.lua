require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


-- Window splits mapping
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split window horizontally" })
map("n", "<leader>se", "<cmd>wincmd =<cr>", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })

