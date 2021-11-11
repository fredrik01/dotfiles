lua<<EOF
  require('lualine').setup{
    options = {
      theme = 'modus-vivendi',
      icons_enabled = false,
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_c = { {'filename', file_status = true, full_path = false, shorten = false} },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
    }
  }
EOF
