# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/completions/fzf ]; then
    . /usr/share/bash-completion/completions/fzf
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
#fi
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GDAL_HOME=/usr/local/gdal
#export JAVA_HOME=/home/ronghusong/app/jdk1.8.0_333
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
#export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export MAVEN_HOME=/home/ronghusong/software/install_package/apache-maven-3.9.7

export PATH=$JAVA_HOME/bin:$GDAL_HOME/bin:$MAVEN_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#export LD_LIBRARY_PATH=$GDAL_HOME/lib64:$GDAL_HOME/lib:$GDAL_HOME/libexec:$JAVA_HOME/jre/lib/amd64/server:/usr/local/lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/share/i4tools/lib:$LD_LIBRARY_PATH
export GOROOT=~/software/go
export GOBIN=~/software/go/bin
export GOPATH=~/software/gopath
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export PATH=$PATH:$GOROOT/bin
export DATE=`date +"%Y%m%d%H%M%m"`
export PATH=$PATH:$GRADLE_HOME/bin
export PATH=$PATH:/home/libretranslate/.local/bin
export PATH=$PATH:/home/ronghusong/software/tools/bin
export PATH=$PATH:/home/ronghusong/.nvm/versions/node/v22.12.0/bin

# fzf
export FD_OPTIONS="--follow --exclude .git --exclude target --exclude node_modules --exclude .npm --exclude .m2 --exclude .local --exclude .emacs.d --exclude .emacs.ronghu --exclude .emacs.d.daviwil --exclude DoChat  --exclude 07_tiantu --exclude .guix-profile --exclude 1223243638"
export FZF_DEFAULT_OPTS="--no-height --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_COMMAND='fd --type f $FD_OPTIONS'
export FZF_CTRL_T_OPTS="--preview 'batcat {} --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='fd --type d $FD_OPTIONS'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R -N "
export SSLKEYLOGFILE="/home/ronghusong/software/tools/chrome_plugin/myssltest.txt"
export PATH=$PATH:/opt/TopSAP:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

## guix
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

TMOUT=6000
export VISUAL=vim
#export EDITOR=vim
export EDITOR=/usr/bin/emacsclient 
export QT_DEBUG_PLUGINS=1
bind '"\t": menu-complete'
#export http_proxy=socks5://localhost:1080
#export https_proxy=socks5://localhost:1080
gsearch() {
    google-chrome --new-tab "https://www.google.com/search?q=$*"
}

# fzf complete ssh host
_ssh_fzf_complete() {
    local ssh_config_hosts known_hosts all_hosts input matches selected_host

    # 1. 读取 ~/.ssh/config 中的主机列表
    ssh_config_hosts=$(awk '/^Host / {for (i=2; i<=NF; i++) print $i}' ~/.ssh/config 2>/dev/null)

    # 2. 读取 ~/.ssh/known_hosts 里连接过的主机
    known_hosts=$(awk '{print $1}' ~/.ssh/known_hosts | cut -d',' -f1 | sed -e '/^\[/d' 2>/dev/null)

    # 3. 生成去重后的所有主机列表
    all_hosts=$(echo -e "${ssh_config_hosts}\n${known_hosts}" | sort -u)

    # 4. 获取当前输入的命令行内容
    input=$(echo "${READLINE_LINE}" | awk '{print $2}')

    # 5. 进行模糊匹配
    matches=$(echo "$all_hosts" | grep -i "$input" || true)

    # 6. 统计匹配项数量
    local match_count=$(echo "$matches" | wc -l)

    if [ "$match_count" -eq 1 ]; then
        # 只有一个匹配项，自动补全
        READLINE_LINE="ssh $matches"
        READLINE_POINT=${#READLINE_LINE}
    elif [ "$match_count" -gt 1 ]; then
        # 多个匹配项，使用 fzf 选择
        selected_host=$(echo "$matches" | fzf --height=10 --reverse --border --exit-0)
        if [ -n "$selected_host" ]; then
            READLINE_LINE="ssh $selected_host"
            READLINE_POINT=${#READLINE_LINE}
        fi
    fi
}
# 绑定 C-x C-s 键到 SSH 补全，但不影响其他命令
bind -x '"\es\es": _ssh_fzf_complete'
[ -z "$TMUX" ] && tmux new-session
. ~/src/github/my-system-config/tools/z.sh
setxkbmap -layout cn -option ctrl:swapcaps
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#if command -v pyenv 1>/dev/null 2>&1; then
#    pyenv activate .venz
#fi
source /usr/share/doc/fzf/examples/key-bindings.bash
#xmodmap ~/.xmodmap 

# === [System Config - Enhance cd & History] ===
export PATH="$HOME/system-config/bin:$PATH"

# cd 增强：使用 fuzzy cd
function cd() {
    if [[ "$1" == "" ]]; then
        builtin cd
    elif [[ -d "$1" ]]; then
        builtin cd "$1"
    else
        # 从 .where 历史中模糊匹配
        local target=$(grep -i "$1" ~/.cache/.where | sort -u | head -n 1)
        if [[ -n "$target" ]]; then
            builtin cd "$target"
        else
            echo "No match found in .where"
        fi
    fi
    pwd >> ~/.cache/.where
}
# 历史记录增强：每次命令都立即写入并刷新
export PROMPT_COMMAND='history -a; history -c; history -r'

# 历史记录设置
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
if test -e ~/system-config/.bashrc; then
    . ~/system-config/.bashrc
    # hooked up for system-config
fi
#export TERM=xterm
export PATH=/usr/bin:$PATH
export MCS=/usr/bin/mcs
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib/mono/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH
