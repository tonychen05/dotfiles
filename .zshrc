# zmodload zsh/zprof

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTION="true"
DISABLE_COMPFIX="true"

# Cache completions aggressively
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export ZSH="$HOME/.oh-my-zsh"

# --- PLUGINS ---
plugins=(
  git
  sudo
  # web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  dirhistory
	ssh-agent
  virtualenv
  nvm
)

# Load zoxide lazily
function load_zoxide() {
  eval "$(zoxide init zsh)"
}
autoload -U load_zoxide


# Powerline10k has an instant prompt setting that doesn't like when this plugin writes to the console.
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

zstyle ':omz:plugins:nvm' lazy yes

source $ZSH/oh-my-zsh.sh

# ZSH History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# Starship
bindkey -v
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"

# rbenv
eval "$(rbenv init -)"

# Yazi Shell Wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# zoxide
alias nzo="~/.config/hypr/scripts/zoxide_openfiles_nvim.sh"

# fzf
eval "$(fzf --zsh)"

# fzf with git by Junegunn
source ~/.config/hypr/scripts/fzf-git.sh

# --- ALIASES ---
# For a full list of active aliases, run `alias`.
alias c='clear'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias vim='$EDITOR'
alias dots='cd ~/dotfiles/'
alias pulse-close="sudo /opt/pulsesecure/bin/startup.sh stop && kill -9 $(ps aux | grep pulseUI | awk '{print $2}')"
alias pulse-start='sudo /opt/pulsesecure/bin/startup.sh start'
alias pulse-restart='sudo /opt/pulsesecure/bin/startup.sh restart'

# how: Generate exact shell command from natural language; reasoning off; no execution; globbing disabled; inserts into buffer
# Adapted from github/iannuttall
how() {
  emulate -L zsh
  setopt NO_GLOB
  local query="$*"
  local prompt="You are a command line expert. The user wants to run a command but they don't know how. Here is what they asked: ${query}. Return ONLY the exact shell command needed. Do not prepend with an explanation, no markdown, no code blocks - just return the raw command you think will solve their query."
  gemini -p "$prompt" -m gemini-2.5-flash-lite --output-format text --no-telemetry
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof
