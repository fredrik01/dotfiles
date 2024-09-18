-- Install with :TSInstall http
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- "all" or a list of languages
	ignore_install = { "phpdoc" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "gitcommit" }
  },
  indent = {
    enable = true,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
      -- init_selection = '<CR>',
      -- scope_incremental = '<CR>',
      -- node_incremental = '<TAB>',
      -- node_decremental = '<S-TAB>'
    -- }
  -- },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
        ["ao"] = "@class.outer",
        ["io"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["]a"] = "@parameter.inner",
      },
      swap_previous = {
        ["[a"] = "@parameter.inner",
      },
    },
  },
}
