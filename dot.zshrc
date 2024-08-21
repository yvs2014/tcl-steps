
bindkey \
	'\e[2~' quoted-insert		\
	'\e[3~' delete-char		\
	'\e[H'	beginning-of-line	\
	'\e[F'	end-of-line		\
	'\e[5~'	beginning-of-history	\
	'\e[6~'	end-of-history

setopt CORRECT AUTO_MENU EXTENDED_GLOB

set_term() { echo -en "\033]0;$(hostname -s)\a"; }
#preexec() { print -Pn "\e]0;$*\a"; }
#preexec() { print -Pn "\e]0;$1\a"; }

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir

alias readme='less [A-Z]*~*.[ch](.)'
alias vi=vim
alias x=exit
alias l="less -R"
#alias ls=exa
alias ll="ls -l"
alias sx="screen -x"
alias chgrep='fnchg() { grep "$@" **/*.[ch]; }; fnchg'

export LESSHISTFILE=-
export EDITOR=vim
export VISUAL=vim
export EXA_COLORS="da=36:di=36"
#export LANG=uk_UA.UTF-8
export LANG=C.UTF-8

#PROMPT='%m%# '    # default prompt
#RPROMPT=' %~'     # prompt for right side of screen
# bindkey -v             # vi key bindings
# bindkey -e             # emacs key bindings
bindkey ' ' magic-space  # also do history expansino on space

autoload -U compinit
compinit
autoload -U colors
colors
#autoload -U zmv

case $TERM in
  xterm*)
    precmd() { print -Pn "\e]0;%n@%m:%l" }
  ;;
esac

PS1="[%{$fg[yellow]%}%T%{$fg[white]%}/%{$fg[green]%}%0(?..%{$fg_bold[red]%})%!%{$fg[white]%}] %{$fg_bold[lightgrey]%}%n%{$fg_no_bold[cyan]%}@%{$fg_no_bold[white]%}%m%{$fg_bold[lightgrey]%}:%l%{$fg_no_bold[white]%} %# "
RPROMPT="%20<..<%B%~%b"

#path=(/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ~/.local/bin)

set_term
[[ -f ~/.message ]] && /bin/cat ~/.message

