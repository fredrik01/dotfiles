return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      -- I don't find the panel useful.
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        -- Use alt to interact with Copilot.
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  }
}
