
export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# nvm autoload
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export GITHUB_ACCESS_TOKEN=''
export GITHUB_USERNAME=''
export NEXUS_PASSWORD=$GITHUB_ACCESS_TOKEN
export NEXUS_USERNAME=$GITHUB_USERNAME

alias cls='clear'

alias dkc='docker-compose'
alias dk='docker'

alias goto='git checkout'
alias create='git checkout -b'
alias dropb='git branch | grep -v "develop" | grep -v "master" | grep -v "main" | xargs git branch -D'