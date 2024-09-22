local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    layout_config = {
      width = 0.9,
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}

-- local t = require('telescope')
-- t.load_extension('fzf')
-- t.load_extension("grapple")
