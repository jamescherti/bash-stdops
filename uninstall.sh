#!/usr/bin/env bash

if [[ $PREFIX = "" ]]; then
  PREFIX=/usr/local
fi

set -euf -o pipefail
set -o xtrace

rm "${PREFIX}/bin/haide"
rm "${PREFIX}/bin/over"
rm "${PREFIX}/bin/cbwatch"
rm "${PREFIX}/bin/xocrshot"
rm "${PREFIX}/bin/esa"
rm "${PREFIX}/bin/outonerror"
rm "${PREFIX}/bin/autoperm"
rm "${PREFIX}/bin/path-lowercase"
rm "${PREFIX}/bin/path-tr"
rm "${PREFIX}/bin/path-uppercase"
rm "${PREFIX}/bin/path-is"
rm "${PREFIX}/bin/qparallel"
rm "${PREFIX}/bin/walk"
rm "${PREFIX}/bin/walk-run"
rm "${PREFIX}/bin/sre"
rm "${PREFIX}/bin/git-sre"
rm "${PREFIX}/bin/git-squash"
rm "${PREFIX}/bin/git-dcommit"
rm "${PREFIX}/bin/git-ourstheir"
rm "${PREFIX}/bin/git-sync-upstream"
rm "${PREFIX}/bin/sshwait"
rm "${PREFIX}/bin/cbcopy"
rm "${PREFIX}/bin/cbpaste"
rm "${PREFIX}/bin/tmux-cbpaste"
rm "${PREFIX}/bin/tmux-run"
rm "${PREFIX}/bin/tmux-session"
rm "${PREFIX}/bin/largs"
rm "${PREFIX}/bin/git-finder"
rm "${PREFIX}/bin/git-finder-exec"
rm "${PREFIX}/bin/git-checkout-default"
rm "${PREFIX}/bin/git-author"
rm "${PREFIX}/bin/git-ls-files-dates"
rm "${PREFIX}/bin/emacs-diff"
rm "${PREFIX}/bin/osid"
rm "${PREFIX}/bin/git-is-dirty"
