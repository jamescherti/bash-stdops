#!/usr/bin/env bash

if [[ $PREFIX = "" ]]; then
  PREFIX=/usr/local
fi

set -euf -o pipefail
set -o xtrace

install -d "${PREFIX}/bin"
install -m 755 ./haide "${PREFIX}/bin/"
install -m 755 ./over "${PREFIX}/bin/"
install -m 755 ./cbwatch "${PREFIX}/bin/"
install -m 755 ./xocrshot "${PREFIX}/bin/"
install -m 755 ./esa "${PREFIX}/bin/"
install -m 755 ./outonerror "${PREFIX}/bin/"
install -m 755 ./autoperm "${PREFIX}/bin/"
install -m 755 ./path-lowercase "${PREFIX}/bin/"
install -m 755 ./path-tr "${PREFIX}/bin/"
install -m 755 ./path-uppercase "${PREFIX}/bin/"
install -m 755 ./path-is "${PREFIX}/bin/"
install -m 755 ./qparallel "${PREFIX}/bin/"
install -m 755 ./walk "${PREFIX}/bin/"
install -m 755 ./walk-run "${PREFIX}/bin/"
install -m 755 ./sre "${PREFIX}/bin/"
install -m 755 ./git-sre "${PREFIX}/bin/"
install -m 755 ./git-squash "${PREFIX}/bin/"
install -m 755 ./git-dcommit "${PREFIX}/bin/"
install -m 755 ./sshwait "${PREFIX}/bin/"
install -m 755 ./cbcopy "${PREFIX}/bin/"
install -m 755 ./cbpaste "${PREFIX}/bin/"
install -m 755 ./tmux-cbpaste "${PREFIX}/bin/"
install -m 755 ./tmux-run "${PREFIX}/bin/"
install -m 755 ./tmux-session "${PREFIX}/bin/"
install -m 755 ./largs "${PREFIX}/bin/"
install -m 755 ./git-finder "${PREFIX}/bin/"
