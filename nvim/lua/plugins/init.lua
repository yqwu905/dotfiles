local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print("Download packer.nvim")
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local status_ok, notify = pcall(require, "notify")
if status_ok then
  vim.notify = require('notify')
end

return require('packer').startup(function(use)
  -- Basic Plugins
  use 'wbthomason/packer.nvim'
  use "lewis6991/impatient.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use {
    "rcarriga/nvim-notify",
    config = require("plugins.notify")
  }
  use "kyazdani42/nvim-web-devicons"
  use {
    "nathom/filetype.nvim",
    config = require('plugins.filetype')
  }
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = require("plugins.nvim_tree"),
    requires = "kyazdani42/nvim-web-devicons",
  }
  use "folke/which-key.nvim"
  use "hrsh7th/vim-eft"
  use "skywind3000/asyncrun.vim"
  use "rhysd/accelerated-jk"
  use {
    "numToStr/FTerm.nvim",
    config = require("plugins.FTerm")
  }

  -- Colorscheme
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = require('plugins.catppuccin')
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = "<cmd>TSUpdate",
    config = require('plugins.treesitter'),
  }

  -- Editor
  use {
    "windwp/nvim-autopairs",
    config = require('plugins.autopairs'),
  }
  use "andymass/vim-matchup"
  use "tpope/vim-surround"
  use "numToStr/Comment.nvim"

  -- UI
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = 'BufRead',
    config = require('plugins.indent-blankline'),
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = require('plugins.lualine'),
  }
  use {
    "akinsho/bufferline.nvim",
    config = require('plugins.bufferline')
  }
  use {
    "goolord/alpha-nvim",
    config = require('plugins.alpha')
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = require('plugins.lspconfig'),
  }
  use "ray-x/lsp_signature.nvim"
  use "williamboman/nvim-lsp-installer"
  use {
    "simrat39/symbols-outline.nvim",
    after = "nvim-treesitter",
    config = require('plugins.symbols-outline')
  }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    config = require('plugins.cmp')
  }
  use "SirVer/ultisnips"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lua"
  use "quangnguyen30192/cmp-nvim-ultisnips"

  --Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = require("plugins.telescope"),
    cmd = "Telescope"
  }
  use {
    "nvim-telescope/telescope-rg.nvim",
    after = 'telescope.nvim',
  }
  use {
    "nvim-telescope/telescope-ui-select.nvim",
    after = 'telescope.nvim',
  }

  -- Git
  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
  }
  use {
    "lewis6991/gitsigns.nvim",
    config = require('plugins.gitsigns'),
    cmd = 'Gitsigns',
  }

  -- Specific Language
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end
  }
  use {
    "lervag/vimtex",
    config = require("plugins.vimtex")
  }
  use "JuliaEditorSupport/julia-vim"
  use {
    "vimwiki/vimwiki",
    config = require("plugins.vimwiki")
  }

  -- Tools
  use {
    "folke/trouble.nvim",
    config = require("plugins.trouble"),
    cmd = "TroubleToggle",
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
