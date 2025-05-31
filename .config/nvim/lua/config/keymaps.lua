-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run test file" })
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run test suite" })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Go to last test file" })
