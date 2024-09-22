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

bat - Used in some zsh aliases/functions together with fzf

	brew install bat

tmux

	brew install tmux

fzf

	brew install fzf

	# To install useful key bindings and fuzzy completion:
	$(brew --prefix)/opt/fzf/install

loop

	brew tap miserlou/loop https://github.com/Miserlou/Loop.git
	brew install loop --HEAD

nvm

	https://github.com/nvm-sh/nvm#install--update-script

## Neovim dependencies for this setup

Install plugins with

	:Lazy

rg

	brew install ripgrep

fd

	brew install fd

hyperfine - Nice command-line benchmarking tool

	brew install hyperfine

jq - Required by rest.nvim

	brew install jq

bc - For calculations

	brew install bc

delta - git pager

	brew install git-delta

tree

	brew install tree

neovim

	brew install neovim
	# To install nightly
	brew install --HEAD neovim

trash-cli

	brew install trash-cli

universal-ctags

	brew install --HEAD universal-ctags/universal-ctags/universal-ctags

PHP

	# phpcbf is not compatible with php 8.1 yet
	brew install php@8.0
	brew link php@8.0

Taskwarrior

	brew install task
	brew install taskwarrior-tui

### Debuggers

PHP

	cd ~/.local/share/nvim/debuggers
	git clone https://github.com/xdebug/vscode-php-debug.git && cd vscode-php-debug
	npm install && npm run build

### Fonts

Jetbrains Mono

	brew install font-jetbrains-mono-nerd-font

### Other

adr

	brew install adr-tools


pomodoro cli

	go install github.com/open-pomodoro/openpomodoro-cli/cmd/pomodoro@latest

cloc - count lines of code - (cloc --vcs git)

	brew install cloc
