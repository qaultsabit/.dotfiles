if [[ -o interactive && -z "$TMUX" && "$TERM_PROGRAM" != "vscode" && -t 1 ]]; then
  exec tmux
fi

# zsh-plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# rust
. "$HOME/.cargo/env"

# go
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH

# java
# export JAVA_HOME=$(/usr/libexec/java_home -v 21)
# export PATH="$JAVA_HOME/bin:$PATH"

# node
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# prompt
source /opt/homebrew/opt/gitstatus/gitstatus.prompt.zsh
PROMPT="%F{green}%$((-GITSTATUS_PROMPT_LEN-1))<…<%~%<<%f"
PROMPT+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT} '
# PROMPT+=$'\n'  
PROMPT+='%F{%(?.green.red)}%f '

export HOMEBREW_NO_AUTO_UPDATE=1
