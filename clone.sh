#!/bin/bash

# Exit script if using unset variable
set -o nounset

# Exit script on un-handled non-true statement
set -o errexit

# Load defaults for script if file exists
[ -e "${HOME}/default/dotfiles" ] && . "$HOME/default/dotfiles"

: ${DOTFILES_GIT_REPO?"Need to specify the location of your dotfiles git repo"} ${DOTFILES_LOC?"Need to specify where to clone the repo to"}

l_CURRENT_DIR=${PWD}

# Set trap to clean up on error
trap 'rm -f "${DOTFILES_LOC}"; exit' INT TERM

# Install the GIT Repo
if [[ ! -d ${DOTFILES_LOC} ]]; then
  git clone ${DOTFILES_GIT_REPO} ${DOTFILES_LOC}

  [[ ! -d ${DOTFILES_LOC} ]] && echo "Clone failed, aborting ..." && exit 1

  cd ${DOTFILES_LOC}

  # Update submodules
  git submodule update --recursive --init
  cd ${l_CURRENT_DIR}
fi
