# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
unsetopt correct_all
# export TERM=rxvt-unicode-256color
# export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias lla='ls -lah'
alias v='vim'
alias pico='nano'
alias p5='cd /home/soren/svn/project5'
alias rep='cd /home/soren/svn/project5/rep'
alias g='gvim --remote-tab-silent'
alias v='vim --remote-tab-silent'
alias picoasm='picoasm -t ~/.picoasm/ROM_form.vhd'
alias dirclip='pwd|xclip'
alias octave='octave --silent'
alias xfiglatex='xfig -specialtext -latexfonts -startlatexFont default'
alias enda='gtrans.pl en da'
alias daen='gtrans.pl da en'
alias enfr='gtrans.pl en fr'
alias fren='gtrans.pl fr en'
alias rpn='~/bin/local/c_rpn/rpn'
alias b269music='ncmpcpp'
alias aaucies='cd /home/soren/Dropbox/AAU/cies/'
alias aausp='cd /home/soren/Dropbox/AAU/sp/'
alias aaumc='cd /home/soren/Dropbox/AAU/mc/'


# Git svn
alias Ci="git commit -a"
alias Up="git svn rebase"
alias Pu="git svn dcommit"

export EDITOR=vim
export WINEDEBUG=-all
export GIT_AUTHOR_EMAIL="soerenbnoergaard@gmail.com"
export GIT_COMMITTER_EMAIL="soerenbnoergaard@gmail.com"
# export LD_PRELOAD=/home/soren/bin/src/usb-driver/libusb-driver.so

# Prompt/PS1
# PROMPT="%{$fg[cyan]%}[%~]$ %{$reset_color%}"
PROMPT="[%~] %{$reset_color%}"
