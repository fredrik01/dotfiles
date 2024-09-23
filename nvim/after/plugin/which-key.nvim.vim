lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

  local wk = require("which-key")

  wk.register({
    ["<leader>"] = { name = "+leader" },
    ["<leader>u"] = { ":MundoToggle<cr>", "Toggle undo tree" },
    ["<leader>-"] = { ":Lf<cr>", "Start lf" },
    ["<leader>m"] = { ":Make<cr>", "Run make async" },
    ["<leader>/"] = { ":let @/=''<left>", "Highlight search term without moving the cursor" },
    ["<leader>y"] = { ":lua require('neoclip.fzf')()<cr>", "Clipboard manager" },
  })

  wk.register({
    ["<leader>f"] = {
      name = "+find files and buffers",
      p = { ":lua require('fzflua-config').project_files()<cr>", "Search project files" },
      f = { "<cmd>lua require'fzf-lua'.files({ cmd = 'fd --hidden --exclude .git'})<cr>", "Files" }, -- Can be useful in some cases. Works with rooter plugin and ignores gitignored files
      b = { ":lua require('fzf-lua').buffers()<cr>", "Search open buffers" },
      e = { ":FzfLua git_status<cr>", "Search edited file" },

      d = { ":FzfLuaDiffAgainsMainBranch<cr>", "Files that diff from the main branch" },
			-- Another attempt, with Telescope
      -- d = { "<cmd>Telescope find_files find_command=git,diff,--name-only,master<cr>", "Files that diff from the main branch (WIP)" },

      h = { ":FzfLua oldfiles<cr>", "File history" },
      a = { "<cmd>lua require'fzf-lua'.files({ cmd = 'fd --hidden --no-ignore --exclude .git'})<cr>", "All files" },
      l = { ":FzfLua resume<cr>", "FzfLua resume/last" },
    },
    ["<leader>b"] = {
      name = "+buffer",
      s = { ":Grapple toggle<CR>", "Toggle bookmark (star)" },
      e = { ":Grapple open_tags<CR>", "Show bookmarks (edit)" },
      f = { ":Telescope grapple tags<CR>", "Search bookmarks" },
      dt = { ":bd! term://<C-a><CR><CR>", "Delete all terminal buffers" },
    },
    ["<leader>q"] = {
      name = "+quickfix",
      q = { ":call ToggleQuickFix()<cr>", "Toggle quickfix" },
      e = { ":lua require('replacer').run()<cr>", "Edit in quickfix list" },
      s = { ":FzfLua quickfix_stack<cr>", "Quickfix stack" },
    },
    ["<leader>l"] = {
      name = "+line",
      f = { ":FzfLua blines<cr>", "Line in current buffer (file)" },
      b = { ":FzfLua lines<cr>", "Line in open buffers" },
      -- Tried to make a command that is fuzzy and excludes the filename - RgWithHidden with no match on filename
      g = { "<cmd>lua require'fzf-lua'.grep_project({ cmd = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob \"!.git\"'})<cr>", "Line in git repo" },
      -- g = { "<cmd>RgWithHidden<cr>", "Line in git repo" },
      a = { "<cmd>lua require'fzf-lua'.grep_project({ cmd = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs --glob \"!.git\"'})<cr>", "Line in git repo" },
      -- a = { "<cmd>RgAll<cr>", "Line in all files" },
      s = { ":FzfLua lsp_document_symbols<cr>", "Find symbol in current buffer" },
      r = { ":FzfLua lsp_references<cr>", "References" },
      t = { "<cmd>lua require('telescope.builtin').treesitter()<cr>", "Treesitter" },
      d = { ":FzfLua lsp_document_diagnostics<cr>", "Diagnostics" },
      m = { ":FzfLua marks<cr>", "Go to mark" },
      w = { ":FzfLua grep_cword<cr>", "Grep word under cursor" },
      t = { ":FzfLua tags_grep_cword<cr>", "Grep tag under cursor" },
      l = { ":FzfLua live_grep<cr>", "Live grep" },
      q = { ":FzfLua quickfix<cr>", "Fuzzy search quickfix list" },
    },
    ["<leader>g"] = {
      name = "+grep",
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
      b = { "<cmd>Git blame<CR>", "Blame" },
      h = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", "Buffer commits" },
      H = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Project commits" },
      c = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "List and checkout branch" },
      p = { ":lua MiniDiff.toggle_overlay()<cr>", "Toggle diff overlay" },
    },
    ["<leader>x"] = {
      name = "debug",
      p = { ":execute 'normal g?p'<cr>", "Print debug line" },
      v = { ":execute 'normal g?v'<cr>", "Print debug line with variable" },
      t = { ":ToggleCommentDebugPrints<cr>", "Toggle debug lines" },
      d = { ":DeleteDebugPrints<cr>", "Delete debug lines" },
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
    },
    ["<leader>e"] = {
      name = "+execute",
      f = { ":!%:p<cr>", "Execute current file" },
    },
    ["<leader>n"] = {
      name = "+notes",
      d = { ":JournalToday<cr>", "Todays journal" },
      s = { "<cmd>lua require'fzf-lua'.grep_project({ cmd = 'rg --column --line-number --no-heading --color=always --smart-case --glob \"!.git\"', cwd = '~/.notes'})<cr>", "Search in notes" },
      f = { "<cmd>lua require'fzf-lua'.files({ cmd = 'fd --exclude .git', cwd = '~/.notes'})<cr>", "Search notes files" },
    },
    ["<leader>r"] = {
      name = "+request",
      r = { ':call VimuxRunCommand("clear; hurlh " . expand("%:p"))<CR>', "Run requests" },
      l = { ":VimuxRunLastCommand<cr>", "Run last (command)" },
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
      r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { ":FzfLua lsp_code_actions<cr>", "Code actions" },
    },
    ["<leader>v"] = {
      name = "+vimux",
      p = { ":VimuxPromptCommand<cr>", "Run command" },
      l = { ":VimuxRunLastCommand<cr>", "Run last command" },
      c = { ":VimuxClearTerminalScreen<cr>", "Clear terminal" },
      i = { ":VimuxInspectRunner<cr>", "Inspect runner pane" },
    },
    ["<leader>a"] = {
      name = "ChatGPT / AI",
      t = { "<cmd>AvanteToggle<CR>", "Avante toggle", mode = { "n", "v" } },
      -- e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
      -- g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
      -- ts = { "<cmd>ChatGPTRun translate swedish<CR>", "Translate to Swedish", mode = { "n", "v" } },
      -- te = { "<cmd>ChatGPTRun translate english<CR>", "Translate to english", mode = { "n", "v" } },
      -- k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
      -- d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
      -- a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
      -- o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
      -- s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
      -- f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
      -- x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
      -- l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
      },
  })
EOF

" nnoremap <Leader>gh :Glog! -- %<CR>
" nnoremap <Leader>gl :Glog!<CR>

" Clear last used search pattern (clear search)
" nmap <leader>cs :let @/ = ""<CR>
