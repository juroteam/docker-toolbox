#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="/root/.bash_it"
export BASH_IT_THEME='candy'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Load Bash It
source $BASH_IT/bash_it.sh
bash-it enable plugin base dirs git aws history &> /dev/null
bash-it enable alias git general &> /dev/null

# Load bash-completion
[ -f /usr/share/bash-completion/bash_completion  ] && source /usr/share/bash-completion/bash_completion

alias k=kubectl
