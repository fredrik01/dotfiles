let mapleader = ","

" Search for all workspace files
nmap <leader>fa :Files!<CR>
" Git files (git ls-files)
nmap <leader>p :GFiles!<CR>
" Git files (git status) (edited files)
nmap <leader>e :GFiles!?<CR>
" Buffers
nmap <leader>b :Buffers!<CR>
" Files in history
nmap <leader>fh :History!<CR>

" Search lines in current buffer (file)
nmap <leader>lf :BLines!<CR>
" Lines in loaded buffers
nmap <leader>lb :Lines!<CR>
" Search in all workspace files, respects .gitignore (ripgrep)
nmap <leader>lg :RgWithHidden<CR>
" Search in all workspace files (The Silver Searcher)
nmap <leader>la :RgAll<CR>

" c-6 is the same as c-^ => go to previous buffer
nnoremap <silent>§ <c-^><cr>

" Close all other windows
nmap <leader>wo :only<CR>
" Close all other tabs
nmap <leader>to :tabonly<CR>

" Up and down in the jump list
" Regular tab already equals to <c-i>
nnoremap <silent><s-tab> <c-o><cr>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" Toggle quickfix window
nmap <leader>q :call ToggleQuickFix()<cr>

" Delete all term buffers
nmap <silent><leader>td :bd! term://<C-a><CR><CR>

" Exit terminal mode
tnoremap <C-o> <C-\><C-n>

" Save all edited buffers
nmap <Space> :wa<CR>
" New empty buffer
nmap <leader>n :enew<CR>

" Find symbol of current document
nnoremap <silent><nowait><leader>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait><leader>s :<C-u>CocList -I symbols<cr>
" Go to definition
nmap <silent>gd <Plug>(coc-definition)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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
" nmap <leader><leader> :FloatermNew --opener=edit --floaterm_autoclose=1 vifm<CR>
" nmap <leader><leader> :FloatermNew --opener=edit --floaterm_autoclose=1 ranger<CR>
nmap <leader><leader> :Lf<CR>

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

" Keep cursor at the bottom of the visual selection after yanking it
vmap y ygv<Esc>

" Automatically fix the last misspelled word and jump back to where you were
" https://github.com/nickjj/dotfiles/blob/master/.vimrc
nnoremap <leader>sp :normal! mz[s1z=`z<CR>

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
set splitright
set splitbelow

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

Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets' " Pre made snippets

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'simeji/winresizer'

" Cache file stored in ~/.cache/nvim
Plug 'ii14/exrc.vim'
let exrc#names = ['.exrc']

Plug 'b3nj5m1n/kommentary'

Plug 'junegunn/goyo.vim'
nmap <leader>go :Goyo<CR>

" lf.vim should be loaded before vim-floaterm to override vim-floaterm's lf wrapper.
Plug 'ptzz/lf.vim'
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
let g:lf_command_override = 'lf -command "set hidden"'
Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
nnoremap <silent><leader>. :FloatermToggle<CR>
tnoremap <silent><leader>. <C-\><C-n>:FloatermToggle<CR>

Plug 'chaoren/vim-wordmotion'
" Add mappings for Vims original word definition
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
Plug 'rust-lang/rust.vim'

" Plug 'tpope/vim-sleuth' " Automatically adjust tab settings
Plug 'sheerun/vim-polyglot' " Includes a version of vim-sleuth
let g:polyglot_disabled = ['php', 'vue', 'javascript', 'typescript', 'json', 'python', 'yaml', 'bash', 'dart', 'html', 'css', 'ruby', 'rust', 'go']

packadd! Cfilter
Plug 'mhinz/vim-grepper'
" Grep git
" nnoremap <leader>gg :Grepper -tool git -grepprg git grep -nGIi<cr>
nnoremap <leader>gg :Grepper -tool rg -grepprg rg --smart-case --hidden --vimgrep --glob "!.git"<cr>
" Grep with context
nnoremap <leader>gc :Grepper -side -tool rg -grepprg rg --smart-case --hidden --vimgrep --glob "!.git"<cr>
" Grep all
nnoremap <leader>ga :Grepper -tool rg -grepprg rg --smart-case --hidden --no-ignore-vcs --vimgrep --glob "!.git"<cr>
" Examples: gsw or gsiW or gsi' (case sensitive)
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Themes
Plug 'bluz71/vim-moonfly-colors'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install bat <- Enable syntax highlight in preview

Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
let g:indent_blankline_enabled = v:false
let g:indent_blankline_char = '▏'
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['fern', 'man', 'help', 'markdown']
nmap <leader>ig :call IndendGuidesToggle()<CR>

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

Plug 'dense-analysis/ale'
let g:ale_linters = {'php': ['phpcs']}
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_linters_explicit = 1
let g:ale_virtualenv_dir_names = []
let g:ale_cache_executable_check_failures = 1

Plug 'skywind3000/asyncrun.vim'
Plug 'vim-test/vim-test'
let test#strategy = 'asyncrun_background_term'
" Easily change between test strategies
nmap <leader>ts1 :let test#strategy = 'asyncrun_background_term'<CR>
nmap <leader>ts2 :let test#strategy = 'asyncrun'<CR>
nmap <leader>ts3 :let test#strategy = 'neovim'<CR>

let test#neovim#term_position = "vert botright 100"

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
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF

" Config for lewis6991/gitsigns.nvim
lua <<EOF
  require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    ['n <leader>ht'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}
EOF

lua << EOF
  require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = false,
  })
  require('kommentary.config').configure_language("php", {
    -- default does not work so...
    prefer_single_line_comments = true,
  })
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

" Thin border on vertical splits
hi VertSplit ctermbg=NONE guibg=NONE

" Make vim-highlightedyank work with this color theme
highlight HighlightedyankRegion cterm=reverse gui=reverse

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
  " Open files at last position
  autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END

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

" rg including hidden files (not .git folder), ignores .gitignore
command! -bang -nargs=* RgAll
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs --glob "!.git" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)
