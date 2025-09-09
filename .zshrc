export EDITOR=nvim

# Needed to make curly undercurls work
export TERM=xterm-kitty

ZSH_THEME=""

# https://www.soberkoder.com/better-zsh-history/
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history
setopt HIST_FIND_NO_DUPS
# following should be turned off, if sharing history via setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# cd without "cd" :P
setopt auto_cd

# Auto complete without cd
autoload -Uz compinit
compinit

# Auto suggestions

export BAT_THEME="Dracula"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

[ -f ~/.dotfiles/zsh/.custom ] && source ~/.dotfiles/zsh/.custom 

# Search stackoverflow
alias so='googler --site stackoverflow.com'
# Change directory
alias cf='fzf_change_directory'
alias cg='cd $(git rev-parse --show-toplevel)'
# Search file and open in editor
alias vf='fzf_find_edit'
# Tmux
alias tf='tmux-sessionizer'
alias ta='tmux attach -t "$(tmux ls | cut -d : -f1 | fzf)"'
# Git
alias gcm='git checkout $(git main-branch)'
alias ga='git-add-fzf'
alias gaa='git add .'
alias gu='git-unadd-fzf'
alias gd='git difftool'
alias gds='git difftool --staged'
alias gdf='fzf_git_diff'
alias gcb='git checkout-branch'
alias gc-='git checkout -'
alias gbd='fzf_git_delete_branch'
alias gw='fzf_git_change_worktree'
alias gwd='fzf_git_delete_worktree'
alias gl='git log --graph --stat --decorate -p' # "Git log with diffs"
alias glf='fzf_git_log'
alias gls='fzf_git_log_search'
alias gs='git status -sb' # Git status without the noice
alias gsf='fzf_git_stash'
alias gc='git commit -v'
alias greflog='fzf_git_reflog'
alias gpull='git pull'
alias gr='git-restore-fzf'
# Fungerar inte
# alias gr='tmux new-window && tmux select-window -t :"$(tmux list-windows | awk -F: '{print $1}' | tail -n1)" && copy-to-tmp && git review'
alias gg='git log --graph --abbrev-commit --decorate --date=relative --all'
# Gitlab
alias gps='glab pipe status --live'
alias gpsw='sleep 10; glab pipe status --live'
alias gmo='glab mr list --author=@me'
# Docker
alias d='docker'
alias dc='docker compose'
alias dcuf='fzf_docker_compose_up'
alias dcul='docker-compose-up-and-log'
alias de='fzf_docker_exec'
alias deg='docker_exec_grep'
alias dl='docker_logs_all'
alias dls='docker_logs_all_separate'
alias dsa='docker_stop_all'
alias dse='docker_stop_all_except'
alias ds='fzf_docker_stop'
alias drmi='fzf_docker_remove_image'
alias dlf='fzf_docker_logs'
alias dlfa='fzf_docker_logs_all'
alias dr='docker run --rm -it -v "${PWD}":/app -w /app'
# Shell
alias ls='ls -G'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias ct='clear && tmux clear-history'
alias na='notes-daily-append'
alias nd='notes-daily-edit'
alias nn='notes-new'
alias ns='notes-search-content'
alias nsf='notes-search-file'
# Open
alias od='open "$(most_recent_file_in_dir ~/Downloads)"'
alias o='open $(fd --no-ignore | fzf)' # Search for a file with fzf and open it
# Taskwarrior
alias tt="taskwarrior-tui"
# Jira
alias jo='jira issue list -q "project IS NOT EMPTY and status not in (Released, \"🤝 Released\", Closed, Done, \"Done\", \"❌ Closed\")" -a$(jira me)' # Ongoing issues in all projects
alias jm='jira issue list -q "project IS NOT EMPTY" -a$(jira me)' # All mine
# Bookmarks
alias b="bookmarks ~/.config/.bookmarks"
alias be="nvim ~/.config/.bookmarks"
# Laravel
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
# Ripgrep
alias rgf='rg --files --no-ignore | rg --no-ignore' # Search for file by filename (incl ignored by git)
# Just
alias jf='just --choose'
# Neovide
alias nv='open -n -a Neovide --args ' # Use this to open neovide
# Hurl
alias hurlenvfile='export HURL_VARS_FILE=$(fd "\.env$" --no-ignore --exclude "cdk" --exec basename {} | fzf)'
# Codex
alias codex-gemini='codex --auto-edit --provider gemini --model gemini-2.5-pro-exp-03-25'
alias codex-openai='codex --auto-edit --provider openai --model o4-mini'
# Aider
alias a='aider --no-gitignore --no-auto-commits --notifications --yes'
# Claude
# alias claude="/Users/fredrik/.claude/local/claude"

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}
current-branch() {
    git branch | grep \* | cut -d ' ' -f2
}
gpush() {
    git push -u origin $(current-branch);
}
gshow() {
    GIT_EXTERNAL_DIFF=difft DFT_DISPLAY=inline git show $1 --ext-diff
}
gpush-ci-skip() {
    git push -u origin $(current-branch) --push-option=ci.skip;
}
git-clean-branches() {
    git branch -d $(git branch --merged=master | grep -v master)
    git fetch --prune
}

cb() {
  current-branch | pbcopy
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
# https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

mysqlClientFolder="/usr/local/opt/mysql-client/bin"
if [ -d "$mysqlClientFolder" ]; then
  path+="$mysqlClientFolder"
fi

goBin="$HOME/go/bin"
if [ -d "$goBin" ]; then
  path+="$goBin"
fi

path+=$HOME/.dotfiles/cli-tools

# Pure prompt
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Should be at the bottom of this file
fpath=( ~/.dotfiles/zshfn "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

