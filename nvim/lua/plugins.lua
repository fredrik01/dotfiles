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
  use {'williamboman/nvim-lsp-installer', commit = '23820a878a5c2415bfd3b971d1fe3c79e4dd6763'}
  use {'neovim/nvim-lspconfig', commit = 'f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda'}
  use {'hrsh7th/cmp-nvim-lsp', commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8'}
  use {'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'}
  use {'hrsh7th/cmp-path', commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1'}
  use {'hrsh7th/cmp-cmdline', commit = 'c66c379915d68fb52ad5ad1195cdd4265a95ef1e'}
  use {'hrsh7th/nvim-cmp', commit = 'b0dff0ec4f2748626aae13f011d1a47071fe9abc'}
  use {"L3MON4D3/LuaSnip", tag = "v1.*",
    after = 'nvim-cmp',
    config = function() 
      require("luasnip.loaders.from_vscode").lazy_load({paths = "./snippets/vscode"})
      require("luasnip.loaders.from_lua").load({paths = "./snippets/lua"})
    end
  }

  use {'saadparwaiz1/cmp_luasnip', commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36'}
  use {'jose-elias-alvarez/null-ls.nvim', commit = 'c0c19f32b614b3921e17886c541c13a72748d450'}
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end,
      commit = '4fc96c8f3df89b6d23e5092d31c866c53a346347'
  }

  use 'bluz71/vim-moonfly-colors'
  use 'bluz71/vim-nightfly-guicolors'
  -- use 'B4mbus/oxocarbon-lua.nvim'
  -- vim.g.oxocarbon_lua_alternative_telescope = true

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
    commit = '76ea9a898d3307244dce3573392dcf2cc38f340f',
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
  use { 'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('fzf-lua').setup({ fzf_opts = {['--layout'] = 'default'}, winopts = { height=1, width=1 }}) end
  }

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
    commit = '8e763332b7bf7b3a426fd8707b7f5aa85823a5ac'
  }
  use {'nvim-treesitter/nvim-treesitter-textobjects', commit = '41e8d8964e5c874d9ce5e37d00a52f37f218502e'}
  use {'nvim-treesitter/nvim-treesitter-context', commit = '8d0759eb798fee2e1201b26c3279713ac67c44c2'}
  use {'AckslD/nvim-trevJ.lua', commit = '73636194d9ec63f74a714b4c394bec68406acb2c'}

  use { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'} }
  use 'rhysd/conflict-marker.vim'

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  use {'anuvyklack/hydra.nvim', commit = 'fa41a971765d4cce9c39185289f5a10894f66dbd'}
  use {'mrjones2014/smart-splits.nvim', commit = 'c8d80d90f3c783ac0ea21f256c74d541a7b66a72'}

  use {'gaoDean/autolist.nvim', config = function() require('autolist').setup() end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
