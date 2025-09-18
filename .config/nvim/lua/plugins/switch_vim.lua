return {
  {
    "AndrewRadev/switch.vim",
    config = function()
      -- Optional: define custom switch definitions
      vim.g.switch_custom_definitions = {
        { "true", "false" },
        { "on", "off" },
        { "yes", "no" },
      }

      -- Map <leader>$$ to switch
      -- vim.keymap.set("n", "<leader>$a", ":Switch<CR>", { desc = "Switch word" })
    end,
  },
}
