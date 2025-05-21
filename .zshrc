# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# 载入 zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
function z() {
    # 使用 fzf 显示目录并允许模糊匹配，加入排序选项
    local selected_dir
    selected_dir=$(zoxide query --list | fzf --height 40% --reverse --preview 'echo {}' --preview-window=up:3:wrap --sort)
    # 如果选中了目录，则进入该目录
    if [[ -n "$selected_dir" ]]; then
       cd "$selected_dir"
    fi
}
                       
export FD_OPTIONS="--follow --exclude .git --exclude node_modules --exclude .npm --exclude .m2 --exclude .local"
#export FZF_DEFAULT_COMMAND="rg --files --hidden -g'!.git'"
#export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type $FD_OPTIONS"
#export FZF_DEFAULT_OPTS="--previw='less' --height 60% --layout=reverse"
export FZF_DEFAULT_OPTS="--no-height --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview 'batcat {} --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export FZF_DEFAULT_COMMAND="fd --type f"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
compdef sshrc=ssh
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# or for everything
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# # switch group using `,` and `.`
# zstyle ':fzf-tab:*' switch-group ',' '.'
# zstyle :omz:plugins:ssh-agent identities ~/.config/ssh/id_rsa ~/.config/ssh/id_rsa2 ~/.config/ssh/id_github
# which can be simplified to
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting tmux fzf-tab)
plugins=(git zsh-autosuggestions tmux fzf-tab zsh-syntax-highlighting)
ZSH_TMUX_AUTOSTART=true
# User configuration
# Always work in a tmux session if tmux is installed
# https://github.com/chrishunt/dot-files/blob/master/.zshrc
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/completions/fzf ]; then
#      . /usr/share/bash-completion/completions/fzf
#  elif [ -f /etc/bash_completion ]; then
#      . /usr/share/bash-completion/completions/fzf
#  fi
#fi
source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/key-bindings.zsh
source ~/.fzf/shell/completion.zsh
#source /usr/share/bash-completion/completions/fzf

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim='vim -p'
alias fcd='cd $(find . -type d | fzf)'
alias rf='rg --files | fzf'
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias cdf='cd $(ls | fzf)'
alias ai='sudo apt-get install $1'
alias bat='batcat'
# copy current path
alias up='pwd | xclip -selection clipboard'
#alias bf="echo $1 | batcat -p -l json"
alias jf='f(){ echo "$@" | jq;  unset -f f; }; f'
alias curlx='curl -x socks5://127.0.0.1:1080 '
alias wgetx='tsocks wget '
alias tc='clear; tmux clear-history; clear'
alias tl='tmux clear-history;'
# git alias
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias gpull='git pull'
alias gpush='git push'

alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gg='git grep'

alias gstash='git stash'
alias gremote='git remote'

alias grebase='git rebase'
bindkey \^U backward-kill-line
#if [ "$TMUX" = "" ]; then tmux; fi
if [[ ! $(tmux list-sessions) ]]; then 
 tmux
fi
