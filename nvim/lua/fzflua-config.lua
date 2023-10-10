local M = {}
M.project_files = function()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end

  if is_git_repo() then
    require('fzf-lua').git_files()
  else
    require('fzf-lua').files()
  end
end
return M

