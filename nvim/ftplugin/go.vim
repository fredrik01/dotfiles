let b:ale_fixers = {'go': ['gofmt']}
let b:ale_fix_on_save = 1

" Automatically fix imports on save
" https://github.com/neoclide/coc.nvim/issues/888
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
