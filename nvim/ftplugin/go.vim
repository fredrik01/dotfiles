" Automatically fix imports on save
" https://github.com/josa42/coc-go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Error signs disappear when saving for some reason, and Ale isn't used for Go files so...
let g:coc_user_config = {
    \'diagnostic.displayByAle': v:false
\}

" Use :make or :Make to compile
compiler go
