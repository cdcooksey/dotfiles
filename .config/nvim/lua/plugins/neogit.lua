return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "ibhagwan/fzf-lua", -- optional
  },
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Open Neogit" },
  },
}
