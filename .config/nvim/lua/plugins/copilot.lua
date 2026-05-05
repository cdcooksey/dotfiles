return {
  {
    "github/copilot.vim",
    -- Load on InsertEnter so it doesn't slow down startup
    event = "InsertEnter",
    config = function()
      -- For copilot.vim, you configure via global variables
      -- This example disables it for specific filetypes
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["TelescopePrompt"] = false,
      }

      -- Optional: Custom keymap to accept suggestions
      -- By default, it's <Tab>. If you want to change it to <M-l> (Alt+L):
      -- vim.keymap.set('i', '<M-l>', 'copilot#Accept("\\<CR>")', {
      --   expr = true,
      --   replace_keycodes = false,
      -- })
      -- vim.g.copilot_no_tab_map = true
    end,
  },
}
