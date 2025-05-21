# alias defination
alias rm='rm -i'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -la'
## get rid of command not found ##
alias cd..='cd ..'
## a quick way to get out of current directory ##
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias h='history'
alias ports='netstat -tulanp'
alias path='echo -e ${PATH//:/\\n}'
alias d='date +%F'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias ping='ping -c 5'
alias sc='source ~/.bashrc'

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# become root #
alias root='sudo -i'
alias su='sudo -i'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'
alias tess='tesseract -l chi_sim '

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias dstat='dstat -cdlmnpsy'

# open in multiple tab page
alias vim='vim -p'

# fzf alias
alias fcd='cd $(fd --type f $FD_OPTIONS | fzf)'
alias dcd='cd $(fd --type d $FD_OPTIONS | fzf)'
alias rf='rg --files | fzf'
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"

# z 
alias j='zcd'

# open file in explor
alias of=xdg-open

# edit with emacs
alias e='/usr/bin/emacsclient --no-wait'
alias ew=/usr/bin/emacsclient

# sudo apt-get install 
alias ins='sudo apt-get install $1'

# copy current path
alias up='pwd | xclip -selection clipboard'

# format json
alias jf='f(){ echo "$@" | jq;  unset -f f; }; f'

alias curlx='curl -x socks5://127.0.0.1:1080 '
alias wgetx='tsocks wget '

alias v='vim -p '
alias sd='shutdown now'
alias st='/home/ronghusong/software/tools/terminal/start-wechat.sh'

# search by google
#alias s=gsearch

# tmux alias start
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tls='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias tc='clear; tmux clear-history; clear'
alias tl='tmux clear-history;'
# tmux alias end

# git alias start
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gb='git branch'
alias gcheckout='git checkout'
alias gm='git merge'
alias gpull='git pull'
alias gpush='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gg='git grep'
alias gstash='git stash'
alias gremote='git remote'
alias grebase='git rebase'
# git alias end

