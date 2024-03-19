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
  use {"williamboman/mason.nvim", commit = 'df1dd889b72ddcf63e262c22b8e69087560c698d'}
  use {"williamboman/mason-lspconfig.nvim", commit = 'aa25b4153d2f2636c3b3a8c8360349d2b29e7ae3'}
  use {'neovim/nvim-lspconfig', commit = '0687eaacc634a82f4832599653ad1305fdf0c941'}
  use {'hrsh7th/cmp-nvim-lsp', commit = '59224771f91b86d1de12570b4070fe4ad7cd1eeb'}
  use {'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'}
  use {'hrsh7th/cmp-path', commit = '91ff86cd9c29299a64f968ebb45846c485725f23'}
  use {'hrsh7th/cmp-cmdline', commit = '23c51b2a3c00f6abc4e922dbd7c3b9aca6992063'}
  use {'hrsh7th/nvim-cmp', commit = 'c49ad26e894e137e401b1d294948c46327877eaf'}
  use {"L3MON4D3/LuaSnip", tag = "v1.*",
    after = 'nvim-cmp',
    config = function() 
      require("luasnip.loaders.from_vscode").lazy_load({paths = "./snippets/vscode"})
      require("luasnip.loaders.from_lua").load({paths = "./snippets/lua"})
    end
  }

  use {'saadparwaiz1/cmp_luasnip', commit = '18095520391186d634a0045dacaa346291096566'}

  use {'jose-elias-alvarez/null-ls.nvim', commit = 'd09d7d82cc26d63673cef85cb62895dd68aab6d8'}
  -- Bridge between mason and null-ls, enables "ensure installed" for null-ls sources, installed with mason
  use { "jayp0521/mason-null-ls.nvim", commit = 'c4b4a6fe3cb8d8590b831c22b3475166dc9a894e'}

  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end,
      commit = '4fc96c8f3df89b6d23e5092d31c866c53a346347'
  }

  use 'bluz71/vim-moonfly-colors'
  use 'bluz71/vim-nightfly-guicolors'
  -- use 'B4mbus/oxocarbon-lua.nvim'
  -- vim.g.oxocarbon_lua_alternative_telescope = true

  use {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup()
    end
  }

  use 'tommcdo/vim-exchange'

  use 'fredrik01/notes.vim'
  vim.g.notes_path = '~/.notes'

  use {
    "luukvbaal/statuscol.nvim", config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false },
            click = "v:lua.ScSa"
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = false, wrap = true },
            click = "v:lua.ScSa"
          },
        }
      })
    end,
  }

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
    commit = '2d92125620417fbea82ec30303823e3cd69e90e8',
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

  use {'folke/which-key.nvim', commit = '7ccf476ebe0445a741b64e36c78a682c1c6118b7'}

  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat' -- Enhances the . operator to work with vim-surround
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-dispatch' -- Use :Make to compile asynchronously

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
  use 'rhysd/clever-f.vim'
  use 'christoomey/vim-tmux-navigator'
  use {'lukas-reineke/indent-blankline.nvim', commit = 'db7cbcb40cc00fc5d6074d7569fb37197705e7f6'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    commit = 'bc52938ddde0ff6b3d51ff215d2c66f2e39b7099'
  }
  use {'nvim-treesitter/nvim-treesitter-textobjects', commit = '9e519b6146512c8e2e702faf8ac48420f4f5deec'}
  use {'nvim-treesitter/nvim-treesitter-context', commit = '3d4ab25056dcaf6dd11ebacf1da8525c8df6550f'}
  use {'AckslD/nvim-trevJ.lua', commit = '7f401543b5cd5496b6120dddcab394c29983a55c'}
  use "IndianBoy42/tree-sitter-just"

  use 'rhysd/conflict-marker.vim'

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  use {'anuvyklack/hydra.nvim', commit = 'fa41a971765d4cce9c39185289f5a10894f66dbd'}
  use {'mrjones2014/smart-splits.nvim', commit = 'c8d80d90f3c783ac0ea21f256c74d541a7b66a72'}

  use {'gaoDean/autolist.nvim', config = function() require('autolist').setup() end}

  use {'https://gitlab.com/madyanov/svart.nvim', config = function() require('svart').configure({ label_location = 1 }) end}
  vim.keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
  vim.keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRepeat<CR>") -- repeat with last searched query

  use({
      "kwkarlwang/bufjump.nvim",
      config = function()
          require("bufjump").setup({
              forward = "<tab>",
              backward = "<s-tab>",
              on_success = nil
          })
      end,
  })

  use {
    'stevearc/oil.nvim',
    config = function() require('oil').setup({
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    }) end
  }
  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

  use {'preservim/vimux'}

  use {
    "cbochs/grapple.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    commit = '6dc1bad1f67d2984d942ef43d87b98ef34447ab9',
    config = function () require("grapple").setup({ scope = "git_branch", icons = false }) end
  }

  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      {'nvim-telescope/telescope.nvim'},
      {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup({
        default_register = '*',
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-b>',
              replay = '<c-q>',  -- replay a macro
              delete = '<c-d>',  -- delete an entry
              edit = '<c-e>',  -- edit an entry
              custom = {},
            },
            n = {
              select = '<cr>',
              paste = 'p',
              --- It is possible to map to more than one key.
              -- paste = { 'p', '<c-p>' },
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
              edit = 'e',
              custom = {},
            },
          },
          fzf = {
            select = 'default',
            paste = 'ctrl-p',
            paste_behind = 'ctrl-b',
            custom = {},
          },
        },
      })
      require('telescope').load_extension('neoclip')
    end,
  }

  use 'gabrielpoca/replacer.nvim'

  use({
    "andrewferrier/debugprint.nvim",
    config = function()
      local opts = {
        create_keymaps = false,
        create_commands = true
      }
      require("debugprint").setup(opts)
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
