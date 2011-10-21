# Mon zshrc

# If not running interactively, don't do anything
	[ -z "$PS1" ] && return

# la table des couleurs
	fg_black=%{$'\e[0;30m'%}
	fg_red=%{$'\e[0;31m'%}
	fg_green=%{$'\e[0;32m'%}
	fg_brown=%{$'\e[0;33m'%}
	fg_blue=%{$'\e[0;34m'%}
	fg_purple=%{$'\e[0;35m'%}
	fg_cyan=%{$'\e[0;36m'%}
	fg_white=%{$'\e[0;37m'%}	
	
	fg_gray=%{$'\e[1;30m'%}
	fg_lred=%{$'\e[1;31m'%}
	fg_lgreen=%{$'\e[1;32m'%}
	fg_yellow=%{$'\e[1;33m'%}
	fg_lblue=%{$'\e[1;34m'%}
	fg_pink=%{$'\e[1;35m'%}
	fg_lcyan=%{$'\e[1;36m'%}

#Text Background Colors
	bg_red=%{$'\e[0;41m'%}
	bg_green=%{$'\e[0;42m'%}
	bg_brown=%{$'\e[0;43m'%}
	bg_blue=%{$'\e[0;44m'%}
	bg_purple=%{$'\e[0;45m'%}
	bg_cyan=%{$'\e[0;46m'%}
	bg_gray=%{$'\e[0;47m'%}

#Attributes
	at_normal=%{$'\e[0m'%}
	at_bold=%{$'\e[1m'%}
	at_italics=%{$'\e[3m'%}
	at_underl=%{$'\e[4m'%}
	at_blink=%{$'\e[5m'%}
	at_outline=%{$'\e[6m'%}
	at_reverse=%{$'\e[7m'%}
	at_nondisp=%{$'\e[8m'%}
	at_strike=%{$'\e[9m'%}
	at_boldoff=%{$'\e[22m'%}
	at_italicsoff=%{$'\e[23m'%}
	at_underloff=%{$'\e[24m'%}
	at_blinkoff=%{$'\e[25m'%}
	at_reverseoff=%{$'\e[27m'%}
	at_strikeoff=%{$'\e[29m'%}

# lié à l'autocomplétion

	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
	zstyle ':completion:*' max-errors 0 numeric
	zstyle ':completion:*' menu select=1
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' verbose false

# pour qu'on repropose pas le même nom de destination pour ces commandes
	
	zstyle ':completion:*:rm:*' ignore-line yes
	#zstyle ':completion:*:mv:*' ignore-line yes
	#zstyle ':completion:*:cp:*' ignore-line yes

	autoload -Uz compinit
	compinit

# lié à l'historique

	HISTFILE=~/.zsh/histfile
	HISTSIZE=10000
	SAVEHIST=10000

	setopt append_history
	setopt share_history  # partage de l'historique
	setopt inc_append_history

# lié à l'autocompletion
	setopt autocd
	#setopt correctall
	unsetopt beep
	bindkey -e

	bindkey '^[[3~' delete-char             # touche Suppr
	bindkey '^[[2~' overwrite-mode          # touche Inser
	bindkey '^[OF' history-search-backward	# touche pgUp
	bindkey '^[[5~' history-search-forward  # touche PgDn

# raccourcis courant

	alias ls='ls -G'
	alias ll='ls -A'
	alias lll='ls -Alh'
	alias back='$OLDPWD'

# alias un peu plus personnel

	alias search='lll | grep'
	alias psearch='ps -ae | grep'
	alias sl='ls'

# l'éditeur par défaut
	export EDITOR=vim

# pour utiliser les macports
	export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# pour utiliser rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# initialise les couleurs
	autoload -U colors
	colors

# support des types mimes

	#autoload -U zsh-mime-setup
	#autoload -U zsh-mime-handler
	#zsh-mime-setup

	#zstyle ':mime:*' mailcap $HOME/.mailcap
	#alias -s pdf='evince'

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

# et enfin le prompt

	PROMPT="${fg_brown}${fg_green}%n${fg_red}@${fg_purple}%m${fg_black}[${fg_blue}%~${fg_black}]\$(prompt_git_info)
${fg_brown}${fg_black}[${fg_cyan}%T${fg_black}]:"

