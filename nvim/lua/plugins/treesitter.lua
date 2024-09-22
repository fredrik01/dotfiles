return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    commit = 'cc0e29727a9651e27869b7444e835c44fb1e7b4c'
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    commit = 'acffd3476eb340faef0ec07e48060b817386b973'
  },
  {'nvim-treesitter/nvim-treesitter-context', commit = 'f19766163c18515fb4d3c12d572bf9cba6cdb990'},
  {'AckslD/nvim-trevJ.lua', commit = '7f401543b5cd5496b6120dddcab394c29983a55c'},
  { "IndianBoy42/tree-sitter-just" },
}
