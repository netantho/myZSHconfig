# MyZSH

# color export
source $HOME/.zsh/colors

# your personal export/shorcut ...
source $HOME/.zsh/personalrc

# default editor, rvm, macport ...
source $HOME/.zsh/mayenablerc

# If not running interactively, don't do anything
	[ -z "$PS1" ] && return

# completion related

	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
	zstyle ':completion:*' max-errors 0 numeric
	zstyle ':completion:*' menu select=1
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' verbose false

	setopt autocd
	#setopt correctall
	unsetopt beep
	bindkey -e

	bindkey '^[[3~' delete-char             # touche Suppr
	bindkey '^[[2~' overwrite-mode          # touche Inser
	bindkey '^[OF' history-search-backward	# touche pgUp
	bindkey '^[[5~' history-search-forward  # touche PgDn

# fix some anoying completion and non-completion

	zstyle ':completion:*:rm:*' ignore-line yes
	#zstyle ':completion:*:mv:*' ignore-line yes
	#zstyle ':completion:*:cp:*' ignore-line yes

	autoload -Uz compinit
	compinit

# history related

	HISTFILE=~/.zsh/histfile
	HISTSIZE=1000
	SAVEHIST=1000

	setopt append_history
	setopt share_history  # partage de l'historique
	setopt inc_append_history

# common shorcuts

	alias l='ls --color=auto'
	alias ls='ls -G --color=auto'
	alias ll='ls -A --color=auto'
	alias lll='ls -Alh --color=auto'
	alias back='$OLDPWD'

# some colors for grep

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

# a little more personal shorcut

	alias search='lll | grep'
	alias psearch='ps -ae | grep'
	alias sl='ls'

# load colors
	autoload -U colors
	colors

# Allow for functions in the prompt.
	setopt PROMPT_SUBST

# Autoload zsh functions.
	fpath=(~/.zsh/functions $fpath)
	autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions.
	typeset -ga preexec_functions
	typeset -ga precmd_functions
	typeset -ga chpwd_functions

# Append git functions needed for prompt.
	preexec_functions+='preexec_update_git_vars'
	precmd_functions+='precmd_update_git_vars'
	chpwd_functions+='chpwd_update_git_vars'

# Completition pour killall
zstyle '*:processes-names' command 'ps -e -o comm='

# Completition pour kill
zstyle '*:processes' command 'ps -au$USER'
zstyle '*:**:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

# Movement
	bindkey ';5D' emacs-backward-word
	bindkey ';5C' emacs-forward-word

# and eventually the prompt !

setopt printeightbit

PROMPT="${fg_green}%n${fg_blue}@${fg_red}`hostname`${fg_white}[${fg_blue}%~${fg_white}]\$(prompt_git_info)${fg_brown}${fg_white}[${fg_cyan}%T${fg_white}]
${fg_brown}%#${fg_white} "
