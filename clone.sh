#!/bin/bash

[[ -e "~/default/dotfiles" ]] && . "~/default/dotfiles" || echo "No default dotfiles settings found at ~/default/dotfiles"

: ${DOTFILES_GIT_REPO?"Need to specify the location of your dotfiles git repo"} ${DOTFILES_LOC?"Need to specify where to clone the repo to"}

l_CURRENT_DIR=${PWD}

# Install the GIT Repo
if [[ ! -d ${DOTFILES_LOC} ]]; then
  git clone ${DOTFILES_GIT_REPO} ${DOTFILES_LOC}

  cd ${DOTFILES_LOC}

  # Update submodules
  git submodule update --recursive --init
  cd ${l_CURRENT_DIR}
fi
