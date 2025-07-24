# ~/.zshrc

# Load aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Setup Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"  # or use starship if you prefer

# plugins=(
#   git
#   github
#   colored-man-pages
#   zsh-syntax-highlighting
#   zsh-autosuggestions
#   pyenv
# )
#
# fpath+=${ZSH_CUSTOM:-${ZSH}/custom}/plugins/zsh-completions/src
#
# source $ZSH/oh-my-zsh.sh

# Prompt (starship)
eval "$(starship init zsh)"

# History settings
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_find_no_dups

# Shell integrations
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source ~/.cargo/env
eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

# Load local user configs
[ -f ~/.zsh_local ] && source ~/.zsh_local

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

