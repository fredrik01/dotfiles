export EDITOR=nvim

export ZSH=~/.oh-my-zsh
ZSH_THEME=""
plugins=(git jump zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export BAT_THEME="Dracula"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

[ -f ~/.dotfiles/zsh/.custom ] && source ~/.dotfiles/zsh/.custom 

alias ssh="kitty +kitten ssh"
# Search stackoverflow
alias so="googler --site stackoverflow.com"
# Change directory
alias cf='fzf_change_directory'
alias cg='cd $(git rev-parse --show-toplevel)'
# Search file and open in editor
alias vf='fzf_find_edit'
# Git
alias ga='fzf_git_add'
alias gd='fzf_git_diff'
unalias gb # Replace gb from oh my zsh
alias gb='fzf_git_change_branch'
alias gbd='fzf_git_delete_branch'
alias gw="fzf_git_change_worktree"
alias gwd='fzf_git_delete_worktree'
alias gl='fzf_git_log'
alias gls='fzf_git_log_search'
alias gld='git log --graph --stat --decorate --all -p' # "Git log diff"
alias gst='git status -sb' # Clean git status
# Docker
alias dc='docker-compose'

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}
current-branch() {
    git branch | grep \* | cut -d ' ' -f2
}
gpush() {
    git push -u origin $(current-branch);
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

path+=$HOME/.dotfiles/cli-tools

# Pure prompt
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Should be at the bottom of this file
fpath=( ~/.dotfiles/zshfn "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)
