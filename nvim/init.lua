-- This is a basic neovim config.
-- It is enough for dev on a remote server without taxing the server.
-- It installs lazy.nvim as the package manager,
--    colorscheme => catppuccin
--    treesitter
--    telescope
--    lualine

vim.cmd("set expandtab tabstop=4 softtabstop=4 shiftwidth=4 smartindent")
vim.cmd("set nu")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
      "catppuccin/nvim",
      lazy = false,
      name = "catppuccin",
      priority = 1000
    },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
    },
    {'nvim-lualine/lualine.nvim'},
}
local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>n', ':Neotree source=filesystem reveal=true position=right<CR>', {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "terraform"},
  highlight = { enable = true },
  indent = { enable = true },  
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

require('lualine').setup()
