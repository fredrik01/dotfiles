lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    width = 0.9,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}
EOF
