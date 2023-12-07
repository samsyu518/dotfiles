eval "$(/opt/homebrew/bin/brew shellenv)"
#eval "$(/usr/local/bin/brew shellenv)"

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

alias ibrew="arch -x86_64 /usr/local/bin/brew"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="~/development/flutter/bin:$PATH"
export LOCATE_PATH="/var/db/locate.database"


source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
