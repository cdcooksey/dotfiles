local vim = vim

-- Line numbers: Show current line, but use relative numbers elsewhere
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.hlsearch = true               -- Highlight results
vim.opt.incsearch = true              -- Show results as you type
vim.opt.ignorecase = true             -- Ignore case
vim.opt.smartcase = true              -- unless uppercase chars are given

vim.g.mapleader = ","

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('tpope/vim-sensible')
Plug('mason-org/mason.nvim')
Plug('williamboman/nvim-lsp-installer')
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})

vim.call('plug#end')

-- vim.g.ruby_host_prg = "/usr/bin/ruby"

require("mason").setup()

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
require'lspconfig'.pyright.setup{}
require'nvim-treesitter.configs'.setup {
  ensure_installed = "ruby",  -- Ensure Ruby is installed
  highlight = {
    enable = true,  -- Enable syntax highlighting
  },
}

