autoload -U promptinit; promptinit
prompt pure antigen bundle zsh-users/zsh-autosuggestions

# Easier navigation: .., ..., ...., .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias projects="cd ~/projects"
alias jd="cd ~/projects/jaas-dashboard"
alias bc="cd ~/projects/bcommerce"
alias ys="yarn start"
alias yt="yarn test"
alias rs="./run serve"
alias gd="gatsby develop"
alias g="git"

# Serve simple web server with reloading
export LOCAL_IP=`ipconfig getifaddr en0`
alias serve="browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 9000"

# Misc
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
