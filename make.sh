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

if [ "$(id -u)" -ne "0" ]; then
  PREFIX="$HOME/.local"
else
  PREFIX="${PREFIX:-/usr/local}"
fi

set -euo pipefail

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
  script_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

  local script_name
  script_name=$(basename "${BASH_SOURCE[0]}")

  if [[ ! -f "$script_dir/haide" ]]; then
    echo "Error: Invalid directory." >&2
    exit 1
  fi

  local bin_dir="$PREFIX/bin"
  if [[ "$action" == "install" ]]; then
    /usr/bin/install -d -- "$bin_dir"
  fi

  shopt -s dotglob nullglob
  local file base_file
  for file in "$script_dir"/*; do
    base_file="${file##*/}"

    # Check if it is a regular file, is executable, and is not an installer
    # script
    [[ -f "$file" ]] || continue
    case "$base_file" in
    "$script_name" | install.sh | uninstall.sh | README.md | LICENSE)
      continue
      ;;

    # Exception
    .bash-stdops.inc.sh) ;;

    *)
      [[ -x "$file" ]] || continue
      ;;
    esac

    if [[ "$action" == "install" ]]; then
      printf '[INSTALL] %s/%s\n' "$bin_dir" "$base_file"
      /usr/bin/install -m 755 -- "$file" "$bin_dir/"
    elif [[ -f "$bin_dir/$base_file" ]]; then
      printf '[UNINSTALL] %s/%s\n' "$bin_dir" "$base_file"
      rm -f -- "$bin_dir/$base_file"
    fi
  done
  shopt -u dotglob nullglob

  echo "Success."
}

main "$@"
