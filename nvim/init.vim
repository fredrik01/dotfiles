lua require("config.lazy")
lua require("config.colors")
lua require("config.avante-colors")

" Save all edited buffers
nmap <Space> :wa<CR>

nnoremap <silent> [s :Grapple cycle backward<cr>
nnoremap <silent> ]s :Grapple cycle forward<cr>
" nnoremap <silent> <c-s> :GrappleToggle<cr>
" nnoremap <silent> <c-m> :GrapplePopup tags<cr>

" https://github.com/L3MON4D3/LuaSnip#keymaps
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" Terminal maps
" Go back to previous buffer
" tnoremap <silent><leader>. <C-\><C-n><c-6><cr>
" Exit terminal mode
tnoremap <C-o> <C-\><C-n>

" Move selection up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Reselect pasted text
nnoremap gp `[v`]

" Generate .spl files on startup
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

" Easier j/k navigation for wrapped lines that works with relative line numbers
" https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Switch to previous buffer
nnoremap <Backspace> <C-^>
" c-6 is the same as c-^ => go to previous buffer
" nnoremap <silent>§ <c-^><cr>

" Search for a term and replace it
nnoremap <Leader>r :%s///g<left><left><left>
nnoremap <Leader>rc :%s///gc<left><left><left>

" Same as above but restrict to a visual selection.
" First search for something and then visually select a range.
xnoremap <Leader>r :%s///g<left><left><left>
xnoremap <Leader>rc :%s///gc<left><left><left>

" Type replacement term and press . to repeat the replacement again
" (comparable to multiple cursors)
nnoremap <Leader>s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <Leader>s* "sy:let @/=@s<CR>cgn

" Use PHPs date function to get date and time
" Example: next tuesday 17:00
nnoremap <Leader>ic :execute 'normal! a' . system('php -r ''echo date("Y-m-d", strtotime(""));''')<left><left><left><left><left><left><left><left>

" Phpunit test :p (requires "af" text object)
xnoremap ay :normal vafok<cr>
onoremap ay :normal vafok<cr>

" Don't yank with these
nnoremap x "_x
vnoremap x "_x

" replace currently selected text with default register without yanking it
" vnoremap p "_dP

lua << EOF
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>D", [["_D]])
vim.keymap.set({"n", "v"}, "<leader>c", [["_c]])
vim.keymap.set({"n", "v"}, "<leader>C", [["_C]])
EOF

" Yank to the end of the line
nnoremap Y y$

" Keep cursor at the bottom of the visual selection after yanking it
vmap y ygv<Esc>

" reselect pasted text
nnoremap gp `[v`]

set ignorecase                  " Case-insensitive searching
set smartcase                   " But case-sensitive if expression contains a capital letter
set number                      " Regular line numbers since relative are slow
set nohlsearch                  " Don't highlight search matches
set cursorline
set laststatus=2                " make lightline work with single window
set noshowmode                  " hide mode since lightline handles that
set autoread                    " Automatically re-read files changed outside Vim
set updatetime=300
set signcolumn=yes              " Always show sign column
set clipboard+=unnamedplus      " Use clipboard for y and p
set noswapfile
set scrolloff=8                 " Keep cursor centered vertically on the screen
set hidden                      " Required to be able to open another buffer without saving the current one
set background=dark             " tell vim what the background color looks like
set nobackup                    " This was recommended by coc
set nowritebackup               " This was recommended by coc
set shortmess+=c                " A coc thing
set spelllang=en,sv
set splitright
set splitbelow
set mouse=                      " Disable mouse
set laststatus=3                " One statusbar at the bottom showing the current window’s status
" Wrap long lines
set breakindent
set breakindentopt=shift:2
set showbreak=↳

set sessionoptions+=options,resize,winpos,terminal

function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" Enable filtering in quickfix list
packadd! Cfilter

" Examples: gsw or gsiW or gsi' (case sensitive)
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" To scroll in test results
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

if (has('termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

lua require('avante_lib').load()

lua << EOF
EOF

if has('persistent_undo')
    let target_path = expand('~/.config/vim-persisted-undo/')

    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    let &undodir = target_path
    set undofile
endif

augroup autocmds
  autocmd! *
  " exrc.vim - Trust .exrc on save
  autocmd BufWritePost .exrc ExrcTrust
  " Disable line numbers in terminal buffers
  autocmd TermOpen * setlocal nonumber norelativenumber
  " Highlight on yank (neovim only)
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
  " Open files at last position
  autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  " Override background color
  " autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=lightgrey guibg=black
  " Adjust quickfix window height automatically
  au FileType qf call AdjustWindowHeight(1, 10)
augroup END

command! -bar -nargs=* Jump cexpr system('git jump ' . expand(<q-args>))
command! FormatJSON :execute "%!jq '.'"
command! FormatJSONalt2 :execute '%!python -m json.tool'
command! FormatXML :execute '%!xmllint --format %'
command! CountLastSearch :execute '%s///gn'
command! ReloadVim :execute ':source $MYVIMRC'
command! Today :execute ":put =strftime('%Y-%m-%d')"
command! LineReference :execute ':let @+=expand("%") . ":" . line(".")'
command! CopyFullPath :execute ':let @* = expand("%:p")'
command! CopyFileName :execute ':let @* = expand("%:t")'
command! CopyProjectPath :execute ':let @+=expand("%")'

" Requires "set hlsearch". Enable/disable with yoh
command! ShowTrailingWhitespace :execute '/\s\+$'
command! DeleteTrailingWhitespace :s/\s\+$//e
" Print sum of all lines at the bottom, requires awk
command! SumLines :execute "%!awk '{print; total+=$1}END{print \"==\";print total}'"
command! EchoRoot :echo FindRootDirectory()

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" Execute this file
function! s:save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :lua require("plenary.reload").reload_module'%'
    :luafile %
  endif

  return
endfunction
" save and resource current file
nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>

" Quickly search and open sessions
command! OpenSessionFzf call fzf#run(fzf#wrap({
            \ 'source': 'rg --files ~/.vim/sessions | grep -v .lock | rev | cut -d "/" -f 1 | rev | cut -d "." -f1',
            \ 'sink': funcref('s:open_session'),
            \ 'window': {'height': 0.4, 'width': 0.4
            \ }}))

function! s:open_session(name) abort
    execute 'OpenSession ' . a:name
endfunction

" Delete current buffer and trash the file
command! -bar -bang Trash
  \ let s:file = fnamemodify(bufname(<q-args>),':p') |
  \ execute 'bdelete<bang>' |
  \ execute 'silent !trash ' . s:file |
  \ unlet s:file

" rg including hidden files (but not .git folder), respects .gitignore
" command! -bang -nargs=* RgWithHidden
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>1)

" rg including hidden files (not .git folder), ignores .gitignore
" command! -bang -nargs=* RgAll
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs --glob "!.git" -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>1)

" https://stackoverflow.com/questions/42905008/quickfix-list-how-to-add-and-remove-entries
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()

" Adjust quickfix height
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! s:defaultGrepPrg()
  set grepprg=grep\ -n\ $*\ /dev/null
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
endfunction

function! s:Rg(args)
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --glob\ \"!.git\"
  set grepformat^=%f:%l:%c:%m
  execute 'silent grep! ' . a:args
  :cwindow
  call s:defaultGrepPrg()
endfunction
command! -nargs=1 -complete=file Rg call s:Rg(<f-args>)

function! s:RgAll(args)
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --no-ignore-vcs\ --follow\ --glob\ \"!.git\"
  set grepformat^=%f:%l:%c:%m
  execute 'silent grep! ' . a:args
  :cwindow
  call s:defaultGrepPrg()
endfunction
command! -nargs=1 -complete=file RgAll call s:RgAll(<f-args>)

command! JournalToday :execute 'edit journal/'.strftime("%F").'.md'

function! s:NotesModeEnable()
  " :lua require("zen-mode").open()
  set linespace=6 " Seems to work in Neovide but not in the terminal
  " set nonumber
  set linebreak " Do not break line in the middle of a word
  if exists("g:neovide")
    let g:neovide_padding_top = 20
  endif
endfunction
command! NotesModeEnable call s:NotesModeEnable()

function! s:NotesModeDisable()
  " Have to close zen mode first, otherwise the other settings will be set on
  " the ZenMode window only
  set linespace=0
  " set number
  set linebreak!
  if exists("g:neovide")
    let g:neovide_padding_top = 0
  endif
  " :lua require("zen-mode").close()
endfunction
command! NotesModeDisable call s:NotesModeDisable()

if exists("g:neovide")
  " Make paste work in insert mode with cmd-v
  " https://github.com/neovide/neovide/issues/113#issuecomment-826091133
  inoremap <D-v> <c-r>+
  cnoremap <D-v> <c-r>+
endif

" :e -> Show file list
" :cd -> Make it possible to search for files in the notes dir directly
command! -bar -bang Notes
  \ call s:NotesModeEnable() |
  \ :e ~/.notes |
  \ :cd ~/.notes

command! -bar -bang NotesPrivate
  \ call s:NotesModeEnable() |
  \ :e ~/.private |
  \ :cd ~/.private
