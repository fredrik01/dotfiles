" Open directory or file
nmap <buffer> l <CR>
" Go up in the hierarchy
nmap <buffer> h -

" unmap all default dovish mappings
let g:dirvish_dovish_map_keys = 0

" Your preferred mappings
nmap <silent><buffer> a <Plug>(dovish_create_file)
nmap <silent><buffer> A <Plug>(dovish_create_directory)
nmap <silent><buffer> dd <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> yf <Plug>(dovish_yank)
xmap <silent><buffer> yf <Plug>(dovish_yank)
" Copy yanked files
nmap <silent><buffer> p <Plug>(dovish_copy)
" Move yanked files
nmap <silent><buffer> P <Plug>(dovish_move)
