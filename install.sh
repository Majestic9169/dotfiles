#!/usr/bin/env bash

LOG="${HOME}/Logs/dotfiles.log"
GITHUB_USER=Majestic9169
GITHUB_REPO=dotfiles
DIR="/home/${USER}/dotfiles"

mkdir -p "${HOME}/Logs"

_process() {
  echo "$(date) PROCESSING: $@" >> $LOG
  printf "$(tput setaf 6) %s...$(tput sgr0)\n" "$@"
}

_success() {
  local message=$1
  printf "%s✓ Success:%s\n" "$(tput setaf 2)" "$(tput sgr0) $message"
}

download_dotfiles() {
  _process "→ Creating directory at ${DIR} and setting permissions"
  mkdir -p "${DIR}"

  _process "→ Downloading repository to "${DIR}" directory"
  git clone https://github.com/Majestic9169/dotfiles.git "${DIR}"

  
  [[ $? ]] && _success "${DIR} created, repository downloaded and extracted"

  # Change to the dotfiles directory
  cd "${DIR}"
}

download_packages() {
  if [[ -f "${DIR}/opt/packages" ]]; then
    _process "→ installing pacman packages"

    pacman -S --needed - < "${DIR}/opt/packages"
  fi
}

link_dotfiles() {
  # symlink files to the HOME directory.
  if [[ -f "${DIR}/files" ]]; then
    _process "→ Symlinking dotfiles in /configs"

    # Set variable for list of files
    files="./files"
    cat ${files}

    # Store IFS separator within a temp variable
    OIFS=$IFS
    # Set the separator to a carriage return & a new line break
    # read in passed-in file and store as an array
    IFS=$'\r\n'
    links=($(cat "${files}"))

    # Loop through array of files
    for index in ${!links[*]}
    do
      for link in ${links[$index]}
      do
        _process "→ Linking ${links[$index]}"
        # set IFS back to space to split string on
        IFS=$' '
        # create an array of line items
        file=(${links[$index]})
        # Create symbolic link
	cat ${file}
	echo ${DIR}/${file[0]}
	echo ${HOME}/${file[2]}
        ln -fs "${DIR}/${file[0]}" "~/.config/${file[2]}"
      done
      # set separater back to carriage return & new line break
      IFS=$'\r\n'
    done

    # Reset IFS back
    IFS=$OIFS

    source "${HOME}/.bash_profile"

    [[ $? ]] && _success "All files have been copied"
  fi
}

new_linked() {
  mv "${HOME}/.config" "${HOME}/.config-backup"
  rm -rf "${HOME}/.config/*"
  ln -sf "${HOME}/dotfiles/configs" "${HOME}/.config"
}

install() {
  echo ${DIR}
  #download_dotfiles
  #download_packages
  #link_dotfiles
  new_linked
}

install
