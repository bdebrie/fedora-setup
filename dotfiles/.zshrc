# Created by newuser for 5.8.1
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups

PROMPT='%F{green}%n%f@%F{yellow}%m%f %F{red}%B%~%b%f %# '
RPROMPT='[%F{yellow}%?%f]'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Double-escape to add sudo at the beginning of previous line
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

# Use `copydir` to copy the path of current folder to clipboard
zinit snippet OMZ::plugins/copyfile/copyfile.plugin.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

bindkey '^l' history-substring-search-up
bindkey '^k' history-substring-search-down
bindkey '^:' autosuggest-execute
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
