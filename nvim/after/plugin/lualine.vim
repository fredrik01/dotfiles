lua<<EOF
  require('lualine').setup{
    options = {
      theme = 'modus-vivendi',
      icons_enabled = false,
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_c = { {'filename', path = 1} }, -- 0 = just filename, 1 = relative path, 2 = absolute path
      lualine_x = {'encoding', 'fileformat', 'filetype'},
    }
  }
EOF
