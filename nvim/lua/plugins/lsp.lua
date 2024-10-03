return {
  {"williamboman/mason.nvim", commit = 'df1dd889b72ddcf63e262c22b8e69087560c698d'},
  {"williamboman/mason-lspconfig.nvim", commit = 'aa25b4153d2f2636c3b3a8c8360349d2b29e7ae3'},
  {'neovim/nvim-lspconfig', commit = '0687eaacc634a82f4832599653ad1305fdf0c941'},
  {'hrsh7th/cmp-nvim-lsp', commit = '59224771f91b86d1de12570b4070fe4ad7cd1eeb'},
  {'hrsh7th/cmp-buffer', commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa'},
  {'hrsh7th/cmp-path', commit = '91ff86cd9c29299a64f968ebb45846c485725f23'},
  {'hrsh7th/cmp-cmdline', commit = '23c51b2a3c00f6abc4e922dbd7c3b9aca6992063'},
  {'hrsh7th/nvim-cmp', commit = 'c49ad26e894e137e401b1d294948c46327877eaf'},
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {'saadparwaiz1/cmp_luasnip', commit = '18095520391186d634a0045dacaa346291096566'},
  {'jose-elias-alvarez/null-ls.nvim', commit = 'd09d7d82cc26d63673cef85cb62895dd68aab6d8'},
  -- Bridge between mason and null-ls, enables "ensure installed" for null-ls sources, installed with mason
  { "jayp0521/mason-null-ls.nvim", commit = 'c4b4a6fe3cb8d8590b831c22b3475166dc9a894e'},
}
