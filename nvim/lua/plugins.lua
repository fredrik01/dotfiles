local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP stuff
  use {'neovim/nvim-lspconfig', commit = 'da7461b596d70fa47b50bf3a7acfaef94c47727d'}
  use {'williamboman/nvim-lsp-installer', commit = '469fe5c409623e8c8acb18f95911c4c37cdca82e'}
  use {'hrsh7th/cmp-nvim-lsp', commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8'}
  use {'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'}
  use {'hrsh7th/cmp-path', commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1'}
  use {'hrsh7th/cmp-cmdline', commit = '9c0e331fe78cab7ede1c051c065ee2fc3cf9432e'}
  use {'hrsh7th/nvim-cmp', commit = '706371f1300e7c0acb98b346f80dad2dd9b5f679'}
  use({"L3MON4D3/LuaSnip", tag = "v1.*"})
  use {'saadparwaiz1/cmp_luasnip', commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36'}
  use {'jose-elias-alvarez/null-ls.nvim', commit = '5b745e5fa2a18a2c0df8966080f4321fad4f42d7'}
  use {'windwp/nvim-autopairs', commit = '34bd374f75fb58656572f847e2bc3565b0acb34f'}

  use 'bluz71/vim-moonfly-colors'
  use 'folke/tokyonight.nvim'
  -- use 'B4mbus/oxocarbon-lua.nvim'

  use 'voldikss/vim-floaterm'
  use 'NTBBloodbath/rest.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'tommcdo/vim-exchange'

  use 'fredrik01/notes.vim'
  vim.g.notes_path = '~/.notes'

  -- Requires: universal-ctags
  -- brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  use 'ludovicchabant/vim-gutentags'

  use 'airblade/vim-rooter'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    commit = 'a52f078026b27694d2290e34efa61a6e4a690621',
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  use {'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim', commit = 'f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971'}

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'v0.5'
  }

  -- Show marks
  use {'kshenoy/vim-signature', commit = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc'}

  use 'simeji/winresizer'

  -- Cache file stored in ~/.cache/nvim
  use {'ii14/exrc.vim', commit = 'ae734ae2c087b370d869e41a2706a128d8f3fc37'}
  vim.g['exrc#names'] = {'.exrc'}

  use {'numToStr/Comment.nvim', commit = '30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6'}

  -- Plugins in this block has to be BEFORE folke/which-key.nvim
  use 'tpope/vim-surround'
  use {'wellle/targets.vim', commit = '8d6ff2984cdfaebe5b7a6eee8f226a6dd1226f2d'}
  -- Adds `iv` and `av` text objects
  use {
    'Julian/vim-textobj-variable-segment',
    commit = '51c323dca5c44f7a8e5a689b9156ef818d02188e',
    requires = {
      {'kana/vim-textobj-user', commit = '41a675ddbeefd6a93664a4dc52f302fe3086a933'}
    }
  }

  use {'folke/which-key.nvim', commit = 'd1872f13ae7d13e41cb2879739bf0915c9491ea6'}
  use {'folke/zen-mode.nvim', commit = '6f5702db4fd4a4c9a212f8de3b7b982f3d93b03c'}

  use {'justinmk/vim-dirvish', commit = '81b40878f286f370df2a2b3a52c4d860643d2142'}
  use {'roginfarrer/vim-dirvish-dovish', branch = 'main', commit = '04c77b6010f7e45e72b4d3c399c120d42f7c5d47'}
  -- Folders at top
  vim.g.dirvish_mode = ':sort ,^.*[/],'
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat' -- Enhances the . operator to work with vim-surround
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-dispatch' -- Use :Make to compile asynchronously

  use {'nelstrom/vim-visual-star-search', commit = '37259722f45996733fd309add61385a4ad88bdb9'} -- Allows * and # searches to occur on the current visual selection

  -- Might have to run this after install: `:call mkdp#util#install()`
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use 'sheerun/vim-polyglot' -- Includes a version of vim-sleuth
  vim.g.polyglot_disabled = {'php', 'vue', 'javascript', 'typescript', 'json', 'python', 'yaml', 'bash', 'dart', 'html', 'css', 'ruby', 'rust', 'go'}

  use {'mhinz/vim-grepper', commit = '2b93535752ffcb312f9fab73d90e80dc9f2e60fc'}

  use {'junegunn/fzf', run = function() vim.fn["fzf#install"]() end}
  use 'junegunn/fzf.vim'
  -- brew install bat <- Enable syntax highlight in preview

  use 'vim-test/vim-test'
  use 'simnalamburt/vim-mundo'
  use 'rcarriga/nvim-notify'
  use 'rhysd/clever-f.vim'
  use {'phaazon/hop.nvim', branch = 'v1'}
  use 'christoomey/vim-tmux-navigator'
  use {'lukas-reineke/indent-blankline.nvim', commit = 'db7cbcb40cc00fc5d6074d7569fb37197705e7f6'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    commit = '2eaf18826988f921ddb39e4a2e7d23d95bb0e52a'
  }
  use {'nvim-treesitter/nvim-treesitter-textobjects', commit = 'e63c2ff8e38fad77299dd74e14c7c9360e1b3181'}
  use {'nvim-treesitter/nvim-treesitter-context', commit = '8bef4409a83219e800852f18c2894a60b64071b8'}
  use {'AckslD/nvim-trevJ.lua', commit = '73636194d9ec63f74a714b4c394bec68406acb2c'}

  use { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'} }

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
