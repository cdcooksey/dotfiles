return {
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      -- Default keymaps are gS (split) and gJ (join).
      -- We'll add a convenience toggle on <leader>$s.
      vim.keymap.set("n", "<leader>$s", ":SplitjoinToggle<CR>", {
        desc = "Split/Join (toggle block style)",
        silent = true,
      })
    end,
  },
}
