#!/usr/bin/env bash
#
# Author: James Cherti
# URL: https://github.com/jamescherti/bash-stdops
#
# Description:
# ------------
# Install or uninstall bash-stdops scripts.
#
# License:
# --------
# Copyright (C) 2012-2026 James Cherti
#
# Distributed under terms of the GNU General Public License version 3.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

PREFIX="${PREFIX:-/usr/local}"

set -eu -o pipefail

main() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: $0 {install|uninstall}" >&2
    exit 1
  fi

  local action="$1"
  if [[ "$action" != "install" && "$action" != "uninstall" ]]; then
    echo "Error: Invalid argument '$action'." >&2
    echo "Usage: $0 {install|uninstall}" >&2
    exit 1
  fi

  local script_dir
  script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

  local script_name
  script_name=$(basename "${BASH_SOURCE[0]}")

  if ! [[ -f haide ]]; then
    echo "Error: Invalid directory." >&2
    exit 1
  fi

  if [[ "$action" == "install" ]]; then
    install -d "${PREFIX}/bin"
  fi

  shopt -s dotglob nullglob
  local base_file
  for file in "$script_dir"/*; do
    base_file="${file##*/}"

    # Check if it is a regular file, is executable, and is not an installer script
    if [[ -f "$file" && -x "$file" && "$base_file" != "$script_name" &&
      "$base_file" != "install.sh" && "$base_file" != "uninstall.sh" ]]; then
      if [[ "$action" == "install" ]]; then
        printf "%s\n" "[INSTALL] ${PREFIX}/bin/$base_file"
        install -m 755 "$file" "${PREFIX}/bin/"
      elif [[ "$action" == "uninstall" ]]; then
        if [[ -f "${PREFIX}/bin/$base_file" ]]; then
          printf "%s\n" "[UNINSTALL] ${PREFIX}/bin/$base_file"
          rm -f "${PREFIX}/bin/$base_file"
        fi
      fi
    fi
  done
  shopt -u dotglob nullglob

  echo "Success."
}

main "$@"
