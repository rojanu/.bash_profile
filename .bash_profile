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

[[ -r ${__WORKSPACE}/.bash_alias_process-management ]] && . ${__WORKSPACE}/.bash_alias_process-management
[[ -r ${__WORKSPACE}/.bash_alias_searching ]] && . ${__WORKSPACE}/.bash_alias_searching
[[ -r ${__WORKSPACE}/.bash_better-terminal ]] && . ${__WORKSPACE}/.bash_better-terminal
[[ -r ${__WORKSPACE}/.bash_env_conf ]] && . ${__WORKSPACE}/.bash_env_conf
[[ -r ${__WORKSPACE}/.bash_files-folders-management ]] && . ${__WORKSPACE}/.bash_files-folders-management
[[ -r ${__WORKSPACE}/.bash_networking ]] && . ${__WORKSPACE}/.bash_networking
[[ -r ${__WORKSPACE}/.bash_web-development ]] && . ${__WORKSPACE}/.bash_web-development

[[ "$OSTYPE" == "darwin"* ]] && [[ -r ${__WORKSPACE}/.bash_mac ]] && . ${__WORKSPACE}/.bash_mac
