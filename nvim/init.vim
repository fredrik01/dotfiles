let mapleader = ","

" Search files
nmap <leader>a :Files<CR>
" Git files (git ls-files)
nmap <leader>p :GFiles<CR>
" Git files (git status) (edited files)
nmap <leader>e :GFiles?<CR>
" Files in buffer
nmap <leader>b :Buffers<CR>
" Files in history
nmap <leader>h :History<CR>

" Search lines in current buffer
nmap <leader>f :BLines<CR>
" Search in all workspace files, respects .gitignore (ripgrep)
nmap <leader>rg :Rg<CR>
" Search in all workspace files (The Silver Searcher)
nmap <leader>ag :Ag<CR>

" <tab> for next buffer and shift+<tab> for previous
nnoremap <silent><tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap <silent><s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nmap <leader>w :bd<CR> " Close current buffer

" Find symbol of current document
nnoremap <silent><nowait><leader>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait><leader>s :<C-u>CocList -I symbols<cr>
" Go to definition
nmap <leader>gd <Plug>(coc-definition)

" Disable search highlighting until the next search
nmap <leader>l :noh<CR>

" Insert new line without leaving normal mode
nmap ö m`o<Esc>``
nmap Ö m`O<Esc>``

" Move selection up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Reveal current file
nmap <leader><leader> :Fern . -reveal=%<CR>

" Notational FZF
nnoremap <silent><leader>n :NV<CR>

" Toggle spellcheck
nmap <leader>sc :setlocal spell! spelllang=en,sv<CR>

" Git blame current line
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

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

set ignorecase                  " Case-insensitive searching
set smartcase                   " But case-sensitive if expression contains a capital letter
set number                      " Regular line numbers since relative are slow
set hlsearch                    " highlight all search matches
set laststatus=2                " make lightline work with single window
set noshowmode                  " hide mode since lightline handles that
set autoread                    " Automatically re-read files changed outside Vim
set updatetime=300
set signcolumn=yes              " Always show sign column
set clipboard+=unnamedplus      " Use clipboard for y and p
set noswapfile
set exrc
set secure
" set cmdheight=2                         " More space for displaying messages (is this useful?)
set hidden                              " Required to be able to open another buffer without saving the current one
set background=dark                     " tell vim what the background color looks like
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth' " Automatically adjust tab settings
Plug 'farmergreg/vim-lastplace' " Remember last place in files
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'

Plug 'junegunn/goyo.vim'
nmap <leader>go :Goyo<CR>

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'antoinemadec/FixCursorHold.nvim' " https://github.com/lambdalisue/fern.vim/issues/120
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
let g:fern#renderer = "nerdfont"

Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enhances the . operator to work with vim-surround
Plug 'wellle/targets.vim'
Plug 'machakann/vim-highlightedyank' " Briefly highlight which text was yanked
Plug 'nelstrom/vim-visual-star-search' " Allows * and # searches to occur on the current visual selection
Plug 'sheerun/vim-polyglot' " Slow?
Plug 'zivyangll/git-blame.vim'

" Themes
Plug 'bluz71/vim-moonfly-colors'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install bat <- Enable syntax highlight in preview

Plug 'tmsvg/pear-tree'
let g:pear_tree_repeatable_expand = 0

Plug 'Yggdroot/indentLine'
let g:indentLine_char       = '▏'
let g:indentLine_setConceal = 1
let g:indentLine_enabled = 1

Plug 'dense-analysis/ale'
let g:ale_linters = {'php': ['phpcs']}
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_linters_explicit = 1
let g:ale_virtualenv_dir_names = []
let g:ale_cache_executable_check_failures = 1

Plug 'vim-test/vim-test'
let test#strategy = 'shtuff'
let g:shtuff_receiver = 'tests'
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>
" To scroll in test results
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" Plug 'mbbill/undotree'
" let g:undotree_HighlightChangedWithSign = 0
" let g:undotree_WindowLayout             = 4
" let g:undotree_SetFocusWhenToggle       = 1
" nnoremap <Leader>u :UndotreeToggle<CR>
"

Plug '907th/vim-auto-save'
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_smart_case        = 1

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1

Plug 'vim-vdebug/vdebug'
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
" Example: let g:vdebug_options.path_maps = {'/app': '/Users/Username/Apps/MyApp'}

Plug 'https://github.com/alok/notational-fzf-vim'
let g:nv_search_paths = ['~/.notes']
let g:nv_create_note_window = 'tabedit'
call plug#end()

let g:coc_global_extensions = [
  \'coc-phpls',
  \'coc-tsserver',
  \'coc-markdownlint',
  \'coc-vetur',
  \'coc-json',
  \'coc-snippets',
\]

imap <C-l> <Plug>(coc-snippets-expand) " Expand snippet
vmap <C-j> <Plug>(coc-snippets-select) " Jump to next selection

if (has('termguicolors'))
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

" Make buftabline more discrete
hi TabLineFill guibg=#000
hi TabLine guibg=#000
hi TabLineSel guibg=#000

" vdebug breakpoint color
hi default DbgBreakptLine term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=none
hi default DbgBreakptSign term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=none

" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" Show fern when opening a dir
augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

command! FormatJSON :execute '%!python -m json.tool'
command! FormatXML :execute '%!xmllint --format %'
command! CountLastSearch :execute '%s///gn'
command! ShowTrailingWhitespace :execute '/\s\+$'
command! ReloadVim :execute ':source $MYVIMRC'

