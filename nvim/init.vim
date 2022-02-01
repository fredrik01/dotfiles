let mapleader = ","

" Save all edited buffers
nmap <Space> :wa<CR>

" c-6 is the same as c-^ => go to previous buffer
nnoremap <silent>§ <c-^><cr>

nnoremap s :HopChar2<cr>
nnoremap S :HopWord<cr>

" Up and down in the jump list
" Regular tab already equals to <c-i>
nnoremap <silent><s-tab> <c-o><cr>

" Terminal maps
tnoremap <silent><leader>. <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent><leader>n <C-\><C-n>:FloatermNew<CR>
tnoremap <silent><leader>l <C-\><C-n>:FloatermNext<CR>
tnoremap <silent><leader>d <C-\><C-n>:FloatermKill<CR>
" Exit terminal mode
tnoremap <C-o> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

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

" Search for a term and replace it
nnoremap <Leader>r :%s///g<left><left><left>
nnoremap <Leader>rc :%s///gc<left><left><left>

" Same as above but restict to a visual selection.
" First search for something and then visually select a range.
xnoremap <Leader>r :%s///g<left><left><left>
xnoremap <Leader>rc :%s///gc<left><left><left>

vnoremap <leader>m :call Calculate()<cr>

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

" Keep cursor at the bottom of the visual selection after yanking it
vmap y ygv<Esc>

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
set nobackup                    " This was recommended by coc
set nowritebackup               " This was recommended by coc
set shortmess+=c                " A coc thing
set spelllang=en,sv
set splitright
set splitbelow
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

call plug#begin('~/.vim/plugged')

Plug 'fredrik01/notes.vim'
let g:notes_path = '~/.notes'

" Required by vim-crunch
Plug 'arecarn/vim-selection'
Plug 'arecarn/vim-crunch'

" Requires: universal-ctags
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_executable = '`brew --prefix`/bin/ctags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root  = ['.git', 'Makefile', 'docker-compose.yml', 'composer.json']
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_exclude = ['*.git', 'node_modules', 'vendor']

Plug 'xolox/vim-misc'
" This is a maintained version of xolox/vim-session
Plug 'romgrk/vim-session'
let g:session_autosave = 'yes'
let g:session_menu = 0

Plug 'airblade/vim-rooter'
" Files that trigger rooter
let g:rooter_targets = '/,*'
" Root patterns
let g:rooter_patterns = ['.git', 'Makefile', 'docker-compose.yml', 'composer.json']

Plug 'nvim-lualine/lualine.nvim'

" Used by lualine and telescope
Plug 'kyazdani42/nvim-web-devicons'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'windwp/nvim-autopairs'

" Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets' " Pre made snippets

Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

Plug 'NTBBloodbath/rest.nvim'

" Required by telescope, gitsigns, rest.nvim, null-ls
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Requires:
" nvim-lua/plenary.nvim
" nvim-lua/popup.nvim
Plug 'ThePrimeagen/harpoon'

Plug 'lewis6991/gitsigns.nvim'

" Show marks
Plug 'kshenoy/vim-signature'

Plug 'simeji/winresizer'

" Cache file stored in ~/.cache/nvim
Plug 'ii14/exrc.vim'
let exrc#names = ['.exrc']

Plug 'numToStr/Comment.nvim'

Plug 'tommcdo/vim-exchange'

" Plugins in this block has to be BEFORE folke/which-key.nvim
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
" Adds `iv` and `av` text objects. Requires kana/vim-textobj-user
Plug 'Julian/vim-textobj-variable-segment'

Plug 'folke/which-key.nvim'

" lf.vim should be loaded before vim-floaterm to override vim-floaterm's lf wrapper.
Plug 'ptzz/lf.vim'
let g:lf_map_keys = 0
" let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
let g:lf_command_override = 'lf -command "set hidden"'
Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
" Folders at top
let g:dirvish_mode = ':sort ,^.*[\/],'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat' " Enhances the . operator to work with vim-surround
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch' " Use :Make to compile asynchronously

Plug 'nelstrom/vim-visual-star-search' " Allows * and # searches to occur on the current visual selection
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jkramer/vim-checkbox'
Plug 'rust-lang/rust.vim'

" Plug 'tpope/vim-sleuth' " Automatically adjust tab settings
Plug 'sheerun/vim-polyglot' " Includes a version of vim-sleuth
let g:polyglot_disabled = ['php', 'vue', 'javascript', 'typescript', 'json', 'python', 'yaml', 'bash', 'dart', 'html', 'css', 'ruby', 'rust', 'go']

packadd! Cfilter
Plug 'mhinz/vim-grepper'
" Examples: gsw or gsiW or gsi' (case sensitive)
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Themes
Plug 'bluz71/vim-moonfly-colors'
Plug 'projekt0n/github-nvim-theme'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install bat <- Enable syntax highlight in preview

Plug 'lukas-reineke/indent-blankline.nvim'
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

Plug 'skywind3000/asyncrun.vim'
Plug 'vim-test/vim-test'
let test#strategy = 'harpoon_stay'
" Easily change between test strategies
nmap <leader>ts1 :let test#strategy = 'floaterm'<CR>
nmap <leader>ts2 :let test#strategy = 'asyncrun_background_term'<CR>
nmap <leader>ts3 :let test#strategy = 'asyncrun'<CR>
nmap <leader>ts4 :let test#strategy = 'neovim'<CR>
nmap <leader>ts5 :let test#strategy = 'harpoon'<CR>
nmap <leader>ts6 :let test#strategy = 'harpoon_stay'<CR>

function! HarpoonStay(cmd)
  let g:cmd = a:cmd . "\n"
  if(exists("g:test#harpoon_term"))
    lua require("harpoon.term").sendCommand(vim.g["test#harpoon_term"] ,vim.g.cmd)
  else
    lua require("harpoon.term").sendCommand(1 ,vim.g.cmd)
  endif
endfunction

let g:test#custom_strategies = {'harpoon_stay': function('HarpoonStay')}

let test#neovim#term_position = "vert botright 100"

" To scroll in test results
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

Plug 'simnalamburt/vim-mundo'

Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_smart_case        = 1

Plug 'phaazon/hop.nvim', {'branch': 'v1'}

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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'christoomey/vim-tmux-navigator'
call plug#end()

if (has('termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax on
colorscheme moonfly
" colorscheme github_dark_default

let g:moonflyCursorColor = 1
let g:moonflyUnderlineMatchParen = 1

" Thin border on vertical splits
hi VertSplit ctermbg=NONE guibg=NONE

" Highlight current line: https://vimtricks.com/p/highlight-specific-lines/
" define line highlight color
highlight LineHighlight ctermbg=darkgrey guibg=#222222
" highlight the current line
nnoremap <silent> <Leader>ll :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>lc :call clearmatches()<CR>

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
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
  " Open files at last position
  autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  " Override background color
  " autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=lightgrey guibg=black
augroup END

command! FormatJSON :execute "%!jq '.'"
command! FormatJSONalt2 :execute '%!python -m json.tool'
command! FormatXML :execute '%!xmllint --format %'
command! CountLastSearch :execute '%s///gn'
command! ReloadVim :execute ':source $MYVIMRC'
command! Today :execute ":put =strftime('%Y-%m-%d')"
command! LineReference :execute ':let @+=expand("%") . ":" . line(".")'
command! CopyFullPath :execute ':let @* = expand("%:p")'
command! CopyFileName :execute ':let @* = expand("%:t")'
" Requires "set hlsearch". Enable/disable with yoh
command! ShowTrailingWhitespace :execute '/\s\+$'
command! DeleteTrailingWhitespace :s/\s\+$//e
" Print sum of all lines at the bottom, requires awk
command! SumLines :execute "%!awk '{print; total+=$1}END{print \"==\";print total}'"

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
command! -bang -nargs=* RgWithHidden
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)

" rg including hidden files (not .git folder), ignores .gitignore
command! -bang -nargs=* RgAll
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs --glob "!.git" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)
