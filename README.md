# Dotfiles

Install with

	./install

## Terminal

zsh-autosuggestions

	brew install zsh-autosuggestions

zsh-history-substring-search

	brew install zsh-history-substring-search

Pure prompt

	brew install pure

tmux

	brew install tmux

fzf

	brew install fzf

	# To install useful key bindings and fuzzy completion:
	$(brew --prefix)/opt/fzf/install

loop

	brew tap miserlou/loop https://github.com/Miserlou/Loop.git
	brew install loop --HEAD

## Neovim dependencies for this setup

Install plugins with

	:PlugInstall

rg

	brew install ripgrep

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

	brew install neovim

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

PHP

	# phpcbf is not compatible with php 8.1 yet
	brew install php@8.0
	brew link php@8.0
