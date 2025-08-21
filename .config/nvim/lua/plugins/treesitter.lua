return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true,
      disable = { "ruby" }, -- languages you don’t want treesitter highlighting for
    },
  },
}
