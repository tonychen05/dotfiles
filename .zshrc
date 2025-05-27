export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
ZSH_THEME="robbyrussell"

# --- PLUGINS ---
plugins=(
    git
    sudo
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    dirhistory
)

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
