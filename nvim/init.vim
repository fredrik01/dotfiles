let mapleader = ","

" Search for all workspace files
nmap <leader>fa :Files!<CR>
" Git files (git ls-files)
nmap <leader>p :GFiles!<CR>
" Git files (git status) (edited files)
nmap <leader>e :GFiles!?<CR>
" Files in buffers
nmap <leader>b :Buffers!<CR>
" Files in history
nmap <leader>h :History!<CR>

" Search lines in current buffer
nmap <leader>lc :BLines!<CR>
" Lines in loaded buffers
nmap <leader>lb :Lines!<CR>
" Search in all workspace files, respects .gitignore (ripgrep)
nmap <leader>lg :RgWithHidden<CR>
" Search in all workspace files (The Silver Searcher)
" TODO: Change to some sort of rg command
nmap <leader>la :Ag!<CR>

" c-6 is the same as c-^ => go to previous buffer
nnoremap <silent>§ <c-^><cr>

" Up and down in the jump list
" Regular tab already equals to <c-i>
nnoremap <silent><s-tab> <c-o><cr>

" Close current buffer
nmap <leader>q :bd<CR>
" Save all edited buffers
nmap <Space> :wa<CR>
" New empty buffer
nmap <leader>n :enew<CR>

" Find symbol of current document
nnoremap <silent><nowait><leader>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait><leader>s :<C-u>CocList -I symbols<cr>
" Go to definition
nmap <leader>gd <Plug>(coc-definition)
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Clear last used search pattern (clear search)
nmap <leader>cs :let @/ = ""<CR>

" Move selection up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Reveal current file
nmap <leader><leader> :Fern . -reveal=% -wait<CR>

" Notational FZF
nnoremap <silent><leader>ww :NV<CR>

" Generate .spl files on startup
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gh :Glog! -- %<CR>
nnoremap <Leader>gl :Glog!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Adjust split size
nnoremap <c-Left> :vertical resize +3<CR>
nnoremap <c-Right> :vertical resize -3<CR>
nnoremap <c-Up> :resize +3<CR>
nnoremap <c-Down> :resize -3<CR>

" Change 2 split windows form horizontal to vertical or the other way around
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Search for a term and replace it
nnoremap <Leader>r :%s///g<left><left><left>
nnoremap <Leader>rc :%s///gc<left><left><left>

" Same as above but restict to a visual selection.
" First search for something and then visually select a range.
xnoremap <Leader>r :%s///g<left><left><left>
xnoremap <Leader>rc :%s///gc<left><left><left>

" Type replacement term and press . to repeat the replacement again
" (comparable to multiple cursors)
nnoremap <Leader>s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <Leader>s* "sy:let @/=@s<CR>cgn

" Don't yank with these
nnoremap x "_x
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
" replace currently selected text with default register without yanking it
vnoremap p "_dP

" Yank to the end of the line
nnoremap Y y$

set ignorecase                  " Case-insensitive searching
set smartcase                   " But case-sensitive if expression contains a capital letter
set number                      " Regular line numbers since relative are slow
set nohlsearch                  " Don't highlight search matches
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
set nobackup                    " This is recommended by coc
set nowritebackup               " This is recommended by coc
set shortmess+=c                " A coc thing
set spelllang=en,sv

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-signify'
Plug 'honza/vim-snippets' " Pre made snippets

" Cache file stored in ~/.cache/nvim
Plug 'ii14/exrc.vim'
let exrc#names = ['.exrc']

Plug 'tomtom/tcomment_vim'
let g:tcomment#filetype#guess_php = 1 " I think treesitter broke comments for php, but this solves that problem

Plug 'junegunn/goyo.vim'
nmap <leader>go :Goyo<CR>

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'antoinemadec/FixCursorHold.nvim' " https://github.com/lambdalisue/fern.vim/issues/120
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
let g:fern#renderer = "nerdfont"
let g:fern#default_hidden = 1

Plug 'chaoren/vim-wordmotion'
" Add mappings for vims original word definition
xnoremap io iw
xnoremap ao aw
onoremap io iw
onoremap ao aw

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enhances the . operator to work with vim-surround
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-highlightedyank' " Briefly highlight which text was yanked
Plug 'nelstrom/vim-visual-star-search' " Allows * and # searches to occur on the current visual selection
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jkramer/vim-checkbox'

" Plug 'tpope/vim-sleuth' " Automatically adjust tab settings
Plug 'sheerun/vim-polyglot' " Includes a version of vim-sleuth
let g:polyglot_disabled = ['php', 'vue', 'javascript', 'typescript', 'json', 'python', 'yaml', 'bash', 'dart', 'html', 'css', 'ruby', 'rust', 'go']

Plug 'mhinz/vim-grepper'
nnoremap <leader>gr :Grepper -tool git<cr>

" Themes
Plug 'bluz71/vim-moonfly-colors'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install bat <- Enable syntax highlight in preview

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
" let g:indent_guides_enable_on_vim_startup = 1

Plug 'dense-analysis/ale'
let g:ale_linters = {'php': ['phpcs']}
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_linters_explicit = 1
let g:ale_virtualenv_dir_names = []
let g:ale_cache_executable_check_failures = 1

Plug 'vim-test/vim-test'
let test#strategy = 'kitty'
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>
" To scroll in test results
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

Plug 'simnalamburt/vim-mundo'
nnoremap <Leader>u :MundoToggle<CR>

Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_smart_case        = 1

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

Plug 'puremourning/vimspector'
nmap <Leader>dd :call vimspector#Continue()<CR>
nmap <Leader>dq :call vimspector#Reset()<CR>
nmap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nmap <Leader>dc :call vimspector#ClearBreakpoints()<CR>
nmap <Leader>dk :call vimspector#StepOut()<CR>
nmap <Leader>dl :call vimspector#StepInto()<CR>
nmap <Leader>dj :call vimspector#StepOver()<CR>
" 'di' = 'debug inspect'
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval

Plug 'https://github.com/alok/notational-fzf-vim'
let g:nv_search_paths = ['~/.notes']
let g:nv_create_note_window = 'tabedit'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

let g:coc_global_extensions = [
  \'coc-phpls',
  \'coc-tsserver',
  \'coc-json',
  \'coc-snippets',
  \'coc-pairs',
\]

imap <C-l> <Plug>(coc-snippets-expand) " Expand snippet
vmap <C-j> <Plug>(coc-snippets-select) " Jump to next selection

if (has('termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax on
colorscheme moonfly

let g:moonflyCursorColor = 1
let g:moonflyUnderlineMatchParen = 1
let g:lightline = {
  \ 'colorscheme': 'moonfly',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

" Make vim-highlightedyank work with this color theme
highlight HighlightedyankRegion cterm=reverse gui=reverse

if has('persistent_undo')
    let target_path = expand('~/.config/vim-persisted-undo/')

    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    let &undodir = target_path
    set undofile
endif

" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

augroup autocmds
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
  " Show fern when opening a dir
  autocmd BufEnter * ++nested call s:hijack_directory()
  " IndentGuides colors
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=black
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey6
  " exrc.vim - Trust .exrc on save
  autocmd BufWritePost .exrc ExrcTrust
  " Open files at last position
  autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

command! FormatJSON :execute '%!python -m json.tool'
command! FormatXML :execute '%!xmllint --format %'
command! CountLastSearch :execute '%s///gn'
command! ShowTrailingWhitespace :execute '/\s\+$'
command! ReloadVim :execute ':source $MYVIMRC'
command! Today :execute ":put =strftime('%Y-%m-%d')"
command! LineReference :execute ':let @+=expand("%") . ":" . line(".")'

" rg including hidden files (but not .git folder), respects .gitignore
command! -bang -nargs=* RgWithHidden
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)
