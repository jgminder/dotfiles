# Interactive zsh configuration.
# Managed by ~/Code/dotfiles/zsh — symlinked into place by install-zsh.sh.

# Homebrew (macOS arm64 or linuxbrew, whichever is present)
for _brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$_brew" ]]; then
    eval "$("$_brew" shellenv)"
    break
  fi
done
unset _brew

# Environment
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="${LANG:-en_US.UTF-8}"
export LESS="-FRX"

typeset -U path PATH
path=("$HOME/.local/bin" $path)

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY

# Shell behaviour
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS NO_BEEP
unsetopt FLOW_CONTROL # free up ctrl-s / ctrl-q

# Completion
ZSH_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE"
autoload -Uz compinit
compinit -d "$ZSH_CACHE/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE"

# Keybindings: emacs, with prefix-aware history search on up/down
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Aliases
alias vi="nvim"
alias vim="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias gs="git status"
alias lg="lazygit"
command -v eza >/dev/null && {
  alias ls="eza --group-directories-first"
  alias ll="eza -lh --git --group-directories-first"
  alias la="eza -lha --git --group-directories-first"
  alias lt="eza --tree --level=2"
}
command -v bat >/dev/null && alias cat="bat"
! command -v fd >/dev/null && command -v fdfind >/dev/null && alias fd="fdfind"

# Tool integrations
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v fzf >/dev/null && source <(fzf --zsh)

# Machine-local overrides, not tracked in the dotfiles repo
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
