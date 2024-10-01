return {
  {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end,
      commit = '4fc96c8f3df89b6d23e5092d31c866c53a346347'
  },
  { 'bluz71/vim-moonfly-colors' },
  {
    'bluz71/vim-nightfly-guicolors',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
  },
  { 'tommcdo/vim-exchange' },
  -- Requires: universal-ctags
  -- brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  { 'ludovicchabant/vim-gutentags' },
  { 'airblade/vim-rooter' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    commit = 'a52f078026b27694d2290e34efa61a6e4a690621',
    lazy = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    commit = '2d92125620417fbea82ec30303823e3cd69e90e8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons'
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'ThePrimeagen/harpoon', 
    dependencies = 'nvim-lua/plenary.nvim', 
    commit = 'f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971'
  },
  {'echasnovski/mini.diff',
    commit = 'd052bf31cc01bb1dde0afd129d8dcdd9f36b9d35',
    -- opts = ,
    config = function()
      require('mini.diff').setup({
        view = {
          style = 'number',
          signs = { add = '|', change = '|', delete = '|' },
        }
      })
      vim.cmd [[
        highlight MiniDiffSignAdd guifg=#26c978 " Add sign color
        highlight MiniDiffSignChange guifg=#0096FF " Change sign color
        highlight MiniDiffSignDelete guifg=#de4949 " Delete sign color
        highlight MiniDiffOverContext guibg=#33487d " Change overlay bg color
        highlight MiniDiffOverDelete guibg=#6b2d37 " Delete overlay bg color
      ]]
    end
  },
    -- Show marks
  {'kshenoy/vim-signature', commit = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc'},
  -- Cache file stored in ~/.cache/nvim
  {'ii14/exrc.vim', commit = 'ae734ae2c087b370d869e41a2706a128d8f3fc37'},
  {'numToStr/Comment.nvim', commit = '30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6'},
  -- Plugins in this block has to be BEFORE folke/which-key.nvim
  { 'tpope/vim-surround' },
  {'wellle/targets.vim', commit = '8d6ff2984cdfaebe5b7a6eee8f226a6dd1226f2d'},
  -- Adds `iv` and `av` text objects
  {
    'Julian/vim-textobj-variable-segment',
    commit = '51c323dca5c44f7a8e5a689b9156ef818d02188e',
    dependencies = {
      {'kana/vim-textobj-user', commit = '41a675ddbeefd6a93664a4dc52f302fe3086a933'}
    }
  },
  {'folke/which-key.nvim', commit = '7ccf476ebe0445a741b64e36c78a682c1c6118b7'},
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' }, -- Enhances the . operator to work with vim-surround
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-dispatch' }, -- Use :Make to compile asynchronously
  { 'sheerun/vim-polyglot' }, -- Includes a version of vim-sleuth
  { 'mhinz/vim-grepper', commit = '2b93535752ffcb312f9fab73d90e80dc9f2e60fc'},
  { 'ibhagwan/fzf-lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('fzf-lua').setup({
        fzf_opts = {['--layout'] = 'default'},
        winopts = { height=1, width=1 }
      })
    end
  },
  { 'vim-test/vim-test' },
  { 'simnalamburt/vim-mundo' },
  { 'rhysd/clever-f.vim' },
  { 'christoomey/vim-tmux-navigator' },
  {'lukas-reineke/indent-blankline.nvim', commit = 'db7cbcb40cc00fc5d6074d7569fb37197705e7f6'},
  { 'rhysd/conflict-marker.vim' },
  {'anuvyklack/hydra.nvim', commit = 'fa41a971765d4cce9c39185289f5a10894f66dbd'},
  {'mrjones2014/smart-splits.nvim', commit = 'c8d80d90f3c783ac0ea21f256c74d541a7b66a72'},
  { 'dkarter/bullets.vim' },
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup()
    end,
  },
  {'https://gitlab.com/madyanov/svart.nvim', config = function() require('svart').configure({ label_location = 1 }) end},
  {
      "kwkarlwang/bufjump.nvim",
      config = function()
          require("bufjump").setup({
              forward = "]b",
              backward = "[b",
              on_success = function()
                  vim.cmd([[execute "normal! g`\"zz"]]) -- Go to last cursor position after exiting the buffer
              end,
          })
      end,
  },
  {
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
  },
  {'preservim/vimux'},
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    commit = '7aedc261b05a6c030397c4bc26416efbe746ebf1',
    config = function () require("grapple").setup({ scope = "git_branch", icons = false }) end
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      -- you'll need at least one of these
      {'nvim-telescope/telescope.nvim'},
      {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup({
        default_register = '*',
        keys = {
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
  },
  { 'gabrielpoca/replacer.nvim' },
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      local opts = {
        keymaps = {
            normal = {
            },
            visual = {
            },
        },
        commands = {
            -- toggle_comment_debug_prints = "ToggleCommentDebugPrints",
            delete_debug_prints = "DeleteDebugPrints",
        },
      }
      require("debugprint").setup(opts)
    end,
    -- requires = {
    --   "echasnovski/mini.nvim" -- Needed to enable :ToggleCommentDebugPrints
    -- },
    commit = 'ff44034c8f52feb252bd88311f91b8c9b9abe0f0'
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        popup_input = {
          submit = "<Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",

      "folke/trouble.nvim",
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  -- Requires yarn and node
  -- { "iamcco/markdown-preview.nvim", build = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { 'terrastruct/d2-vim' },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = false,
      highlight = {
        comments_only = false,
      },
      keywords = {
        DONE = { color = "default" },
        SKIP = { color = "warning" },
        DUE = { color = "error" },
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
}
