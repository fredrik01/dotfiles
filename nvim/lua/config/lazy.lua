-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
-- vim.g.maplocalleader = "\\"

vim.g.polyglot_disabled = {'php', 'vue', 'javascript', 'typescript', 'json', 'python', 'yaml', 'bash', 'dart', 'html', 'css', 'ruby', 'rust', 'go'}

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Stuff
vim.g['exrc#names'] = {'.exrc'}


-- dkarter/bullets.vim
vim.g.bullets_enabled_file_types = {'markdown'}

vim.keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
vim.keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRepeat<CR>") -- repeat with last searched query

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
