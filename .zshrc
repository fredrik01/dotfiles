export EDITOR=nvim

export ZSH=~/.oh-my-zsh
ZSH_THEME=""
plugins=(git jump zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export BAT_THEME="Dracula"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

alias ssh="kitty +kitten ssh"

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

# Change git worktree
gw() {
  git_worktree_path=$(git worktree list | fzf | cut -d ' ' -f1)
  if [ ! -z "$git_worktree_path" ]
  then
    cd $git_worktree_path
  fi
}

# Replace gb from oh my zsh
unalias gb
# https://stackoverflow.com/a/37007733
gb() {
  is_in_git_repo &&
    git checkout $(git branch -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##')
}

weather() {
    if [ $1 = "-s" ]; then
        curl -s "wttr.in/{$2}?format=3"
    else
        curl wttr.in/$1
    fi
}

# Search stackoverflow
alias so="googler --site stackoverflow.com"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Git diff with fzf. Arguments are passed to git diff, so it can be used in the same way as git diff
# Examples:
#       fd (regular git diff)
#       fd 8387eff8..350500cb
fd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

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

