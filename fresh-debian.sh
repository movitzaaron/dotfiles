sudo apt update && sudo apt upgrade

# check if we have zsh
if test ! $(which zsh); then
  sudo apt install zsh
fi

# check if we have omz
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# check if we have stow
if test ! $(which stow); then
  sudo apt-get install stow
fi

# check if we have nvim
if test ! $(which nvim); then
  sudo apt-get install neovim
fi

# check if we have nvim
if test ! $(which starship); then
  curl -sS https://starship.rs/install.sh | sh
fi

# check if we have nvim
if test ! $(which pyenv); then
  curl -fsSL https://pyenv.run | bash
fi

# check if we have nvim
if test ! $(which zoxide); then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# check if we have nvim
if test ! $(which cargo); then
  curl https://sh.rustup.rs -sSf | sh
fi

# check if we have nvim
if test ! $(which delta); then
  cargo install git-delta
fi

# check if we have nvim
if test ! $(which fzf); then
  sudo apt install fzf
fi

# check if we have gcc
if test ! $(which gcc); then
  sudo apt install build-essential
fi

# check if we have npm
if test ! $(which npm); then
  sudo apt install -y curl
  curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
  sudo -E bash nodesource_setup.sh
  sudo apt install -y nodejs
  node -v
fi
