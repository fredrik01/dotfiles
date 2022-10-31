_G.fzf_diff_against_main = function()
  require'fzf-lua'.fzf_exec("git diff --name-only $(git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4)", {
		-- Diff against the main branch
    preview = "git diff $(git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4) {} | delta",
    fzf_opts = { ['--preview-window'] = 'nohidden' },
    actions = require'fzf-lua'.defaults.actions.files,
  })
end

-- Map to a user command
vim.cmd([[command! -nargs=* FzfLuaDiffAgainsMainBranch lua _G.fzf_diff_against_main()]])
