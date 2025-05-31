return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_ls = {},
    },
    setup = {
      ruby_ls = function(_, opts)
        require("lspconfig").ruby_ls.setup(opts)
        return true
      end,
    },
  },
}
