# zsh-plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# rust
. "$HOME/.cargo/env"

# go
export GOPATH=$HOME/Developer/go
export PATH=$PATH:$GOPATH/bin

# java
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
export JAVA_HOME=/opt/homebrew/opt/openjdk@21

# node
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# # git satus
source /opt/homebrew/opt/gitstatus/gitstatus.prompt.zsh
PROMPT="%F{yellow}%$((-GITSTATUS_PROMPT_LEN-1))<…<%~%<<%f"
PROMPT+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} '
# PROMPT+=$'\n'  
PROMPT+='%F{%(?.yellow.red)}›%f '

