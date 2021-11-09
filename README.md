# Dotfiles

Install with

	./install

## Neovim dependencies for this setup

Install plugins with

	:PlugInstall

fd

	brew install fd

jq - Required by rest.nvim

	brew install jq

bc - For calculations

	brew install bc

delta - git pager

	brew install git-delta

tree

	brew install tree

coc.nvim requires node

	brew install node

neovim 0.5

	brew install neovim --head

trash-cli

	brew install trash-cli

universal-ctags

	brew install --HEAD universal-ctags/universal-ctags/universal-ctags

shellcheck - Lint shell files with ALE

	brew install shellcheck

hadolint - Lint dockerfiles (uses shellcheck)

	brew install hadolint

vint - Lint vimscript with ALE

	brew install vint

MySQL client - Used by vim-dadbod

	brew install mysql-client
