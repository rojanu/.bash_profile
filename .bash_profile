#!/bin/sh

function get_prompt_dir() {
  if [ -z "$__WORKSPACE" ]; then
    local SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
      local DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    __WORKSPACE="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  fi
}

get_prompt_dir

# Bash customisation file

##########################################################################
#General configuration starts: stuff that you always want executed
[[ -r ${__WORKSPACE}/.bash_alias_process-management ]] && . ${__WORKSPACE}/.bash_alias_process-management
[[ -r ${__WORKSPACE}/.bash_alias_searching ]] && . ${__WORKSPACE}/.bash_alias_searching
[[ -r ${__WORKSPACE}/.bash_better-terminal ]] && . ${__WORKSPACE}/.bash_better-terminal
[[ -r ${__WORKSPACE}/.bash_env_conf ]] && . ${__WORKSPACE}/.bash_env_conf
[[ -r ${__WORKSPACE}/.bash_files-folders-management ]] && . ${__WORKSPACE}/.bash_files-folders-management
[[ -r ${__WORKSPACE}/.bash_networking ]] && . ${__WORKSPACE}/.bash_networking
[[ -r ${__WORKSPACE}/.bash_web-development ]] && . ${__WORKSPACE}/.bash_web-development

[[ -d ${__WORKSPACE}/.bin ]] && export PATH="${__WORKSPACE}/.bin:$PATH"

[[ "$OSTYPE" == "darwin"* ]] && [[ -r ${__WORKSPACE}/.bash_mac ]] && . ${__WORKSPACE}/.bash_mac

#General configuration ends
##########################################################################

if [[ -n $PS1 ]]; then
    : # These are executed only for interactive shells
    echo "interactive"
else
    : # Only for NON-interactive shells
fi

if shopt -q login_shell ; then
    : # These are executed only when it is a login shell
    echo "login"
else
    : # Only when it is NOT a login shell
    echo "nonlogin"
fi
