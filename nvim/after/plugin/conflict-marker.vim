" disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guifg=#e06c75
highlight ConflictMarkerOurs guibg=#003d32
highlight ConflictMarkerSeparator guifg=#e06c75
highlight ConflictMarkerTheirs guibg=#002445
highlight ConflictMarkerEnd guifg=#e06c75
