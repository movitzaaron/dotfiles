# ~/.zshrc

# Load aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Setup Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

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

# Load local user configs
# source $HOME/.dotfiles/.zsh_local

# Load local user configs
source $HOME/.dotfiles/.zsh_aliases

# Load local user configs
source $HOME/.dotfiles/.zsh_profile

# Shell integrations
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init --cmd cd zsh)"
source ~/.cargo/env
source <(fzf --zsh)


# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

