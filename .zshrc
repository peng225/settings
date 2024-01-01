# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1
PROMPT='%n@%m:%~%% '

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' special-dirs true
 
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct # _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' # 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
 
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export EDITOR=vim


# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete  

# コマンドのスペルを訂正する
setopt correct
# 補完キー連打で補完候補を順に表示する(d)
setopt auto_menu               

# my aliases
alias mv='mv -i'
alias rm='rm -I'
alias cp='cp -i'
alias vgxp='javaws ~/g2.jnlp'
alias sl='ls'
alias sdp='ssh -D localhost:10005'
# alias valgrind='valgrind -v --leak-check=full'
alias gp='gnuplot'
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -A'
alias ls="ls --color"
alias gopen="gnome-open"

# wild cardをbashと同じように展開する
unsetopt no_match

# allow core dump output
ulimit -c unlimited

export SCREENDIR=$HOME/.screen
export PATH=$PATH:$HOME/go/bin:$HOME/bin::/usr/local/go/bin

source <(kubectl completion zsh)
