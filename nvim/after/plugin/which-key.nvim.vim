lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

  local wk = require("which-key")

  wk.register({
    ["<leader>"] = { name = "+leader" },
    ["<leader>."] = { ":FloatermToggle<cr>", "Toggle terminal" },
    ["<leader>u"] = { ":MundoToggle<cr>", "Toggle undo tree" },
    ["<leader>-"] = { ":Lf<cr>", "Start lf" },
    ["<leader>m"] = { ":Make<cr>", "Run make async" },
    ["<leader>/"] = { ":let @/=''<left>", "Highlight search term without moving the cursor" },
  })

  wk.register({
    ["<leader>f"] = {
      name = "+find files and buffers",
      p = { ":lua require'telescope-config'.project_files()<cr>", "Search project files" },
      -- Telescope buffer list resets order when opening fern or lf, too bad...
      -- b = { "<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true, sorter = require'telescope.sorters'.get_substr_matcher() })<cr>", "Search open buffers" },
      b = { ":lua require('fzf-lua').buffers()<cr>", "Search open buffers" },
      e = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Search edited file" },
      h = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "File history" },
      a = { "<cmd>Telescope find_files find_command=rg,--smart-case,--hidden,--no-ignore-vcs,--glob,!.git,--files<cr>", "All files" },
      --a = { :Files!<CR>", "All files" },
    },
    ["<leader>b"] = {
      name = "+buffer",
      n = { ":enew<CR>", "New buffer" },
      d = { ":bd<CR>", "Delete buffer" },
      dt = { ":bd! term://<C-a><CR><CR>", "Delete all terminal buffers" },
    },
    ["<leader>q"] = {
      name = "+quickfix",
      q = { ":call ToggleQuickFix()<cr>", "Toggle quickfix" },
      s = { "<cmd>lua require('telescope.builtin').quickfix()<cr>", "Search in quickfix list" },
    },
    ["<leader>l"] = {
      name = "+line",
      -- f = { "<cmd>BLines!<cr>", "Line in current buffer (file)" },
      f = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Line in current buffer (file)" },
      b = { "<cmd>Lines!<cr>", "Line in open buffers" },
      g = { "<cmd>RgWithHidden<cr>", "Line in git repo" },
      a = { "<cmd>RgAll<cr>", "Line in all files" },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Find symbol of current document" },
      r = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "References" },
      t = { "<cmd>lua require('telescope.builtin').treesitter()<cr>", "Treesitter" },
      d = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Diagnostics" },
      m = { ":Marks<cr>", "Go to mark" },
      w = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Grep word under cursor" },
      q = { "<cmd>lua require('telescope.builtin').quickfix()<cr>", "Quickfix list in Telescope" },
    },
    ["<leader>g"] = {
      name = "+grep",
      l = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
      g = { ":Grepper -tool rg -grepprg rg --smart-case --hidden --vimgrep --glob '!.git'<cr>", "Git grep (rg)" },
      h = { ":Grepper -tool git -grepprg git grep -nGIi<cr>", "Git grep" },
      c = { ":Grepper -side -tool rg -grepprg rg --smart-case --hidden --vimgrep --glob '!.git'<cr>", "Grep with context" },
      a = { ":Grepper -tool rg -grepprg rg --smart-case --hidden --no-ignore-vcs --vimgrep --glob '!.git'<cr>", "Grep all" },
    },
    ["<leader>h"] = {
      name = "+git",
      g = { ":Git<CR>", "Git summary" },
			j = {
				name = "+Jump",
				m = { ":Jump merge<CR>", "Add conflicts to quickfix and jump to the first one" },
				d = { ":Jump diff<CR>", "Add diff hunks to quickfix and jump to the first one" },
			},
      p = { "<cmd>lua require'gitsigns'.preview_hunk()<CR>", "Preview hunk" },
      s = { "<cmd>lua require'gitsigns'.stage_hunk()<CR>", "Stage hunk" },
      u = { "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", "Undo stage hunk" },
      r = { "<cmd>lua require'gitsigns'.reset_hunk()<CR>", "Reset hunk" },
      R = { "<cmd>lua require'gitsigns'.reset_buffer()<CR>", "Reset buffer" },
      l = { "<cmd>lua require'gitsigns'.blame_line()<CR>", "Blame line" },
      f = { "<cmd>lua require'gitsigns'.refresh()<CR>", "Refresh gitsigns" },
      b = { "<cmd>Git blame<CR>", "Blame" },
      t = { "<cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>", "Toggle current line blame" },
      h = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", "Buffer commits" },
      H = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Project commits" },
      c = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "List and checkout branch" },
    },
    ["<leader>c"] = {
      name = "+tags",
      a = { ":lua require('fzf-lua').tags()<cr>", "Search all tags" },
      b = { ":BTags<cr>", "Search tags in buffer" },
    },
    ["<leader>s"] = {
      name = "+sessions",
      s = { ":OpenSessionFzf<cr>", "Search and open session" },
    },
    ["<leader>t"] = {
      name = "+test",
      n = { ":TestNearest<cr>", "Test nearest" },
      f = { ":TestFile<cr>", "Test file" },
      s = { ":TestSuite<cr>", "Test suite" },
      l = { ":TestLast<cr>", "Test last" },
      g = { ":TestVisit<cr>", "Go to last run test" },
      p = { ":vsplit<cr> :exec 'vertical resize '. string(&columns * 0.4)<cr> :lua require('harpoon.term').gotoTerminal(1)<cr> G<c-w>p", "Prepare for HarpoonStay strategy (open split with terminal)" },
      -- r = { ":lua require('telescope').extensions.asynctasks.all()<cr>", "Find task to run" },
      r = { ":lua require('telescope.builtin').resume()<cr>", "Telescope resume" },
      j = { "<c-w>wG<c-w>p", "Scroll down in test window" },
    },
    ["<leader>i"] = {
      name = "+indent guides",
      t = { ":call IndendGuidesToggle()<CR>", "Toggle indent guides" },
    },
    ["<leader>z"] = {
      name = "+spelling",
      -- https://github.com/nickjj/dotfiles/blob/master/.vimrc
      l = { ":normal! mz[s1z=`z<cr>", "Automatically fix the last misspelled word and jump back to where you were" },
			m = { ":ZenMode<cr>", "Zen Mode" },
    },
    ["<leader>e"] = {
      name = "+execute",
      f = { ":!%:p<cr>", "Execute current file" },
    },
    ["<leader>n"] = {
      name = "+notes",
      n = { ":NotesNew<cr>", "New note" },
      d = { ":NotesDaily<cr>", "Daily note" },
      s = { ":NotesSearch<cr>", "Search in notes" },
      f = { ":NotesFiles<cr>", "Search notes files" },
    },
    ["<leader>r"] = {
      name = "+request",
      r = { "<Plug>RestNvim", "Make request under cursor" },
      p = { "<Plug>RestNvimPreview", "Preview request" },
      l = { "<Plug>RestNvimLast", "Run previous request" },
    },
    ["<leader>j"] = {
      name = "jump to files / terminals",
      j = { ":lua require('harpoon.ui').nav_file(1)<cr>", "Go to file 1" },
      k = { ":lua require('harpoon.ui').nav_file(2)<cr>", "Go to file 2" },
      l = { ":lua require('harpoon.ui').nav_file(3)<cr>", "Go to file 3" },
      a = { ":lua require('harpoon.term').gotoTerminal(1)<cr>", "Go to terminal 1" },
      s = { ":lua require('harpoon.term').gotoTerminal(2)<cr>", "Go to terminal 2" },
      e = { ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Edit files" }, 
      w = { ":lua require('harpoon.mark').add_file()<cr>", "Add file" }, 
    },
	  ["<leader>k"] = {
      name = "LSP / formatting",
      j = { ":lua require('trevj').format_at_cursor()<cr>", "Opposite of join-line (J) of arguments" },
    }
  })
EOF

" nnoremap <Leader>gh :Glog! -- %<CR>
" nnoremap <Leader>gl :Glog!<CR>

" Clear last used search pattern (clear search)
" nmap <leader>cs :let @/ = ""<CR>

" Reveal current file
" nmap <leader><leader> :FloatermNew --opener=edit --floaterm_autoclose=1 vifm<CR>
" nmap <leader><leader> :FloatermNew --opener=edit --floaterm_autoclose=1 ranger<CR>
" nmap <leader><leader> :Lf<CR>
