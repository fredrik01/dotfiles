let g:indent_blankline_enabled = v:false
let g:indent_blankline_char = '▏'
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['fern', 'man', 'help', 'markdown']

" IndentBlanklineToggle does not work as expected
function! IndendGuidesToggle()
  if g:indent_blankline_enabled == v:false
    let g:indent_blankline_enabled = v:true
    IndentBlanklineEnable
  else
    let g:indent_blankline_enabled = v:false
    IndentBlanklineDisable
  endif
endfunction
