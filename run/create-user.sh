#! /usr/bin/env sh
set -o errexit -o xtrace

useradd --create-home --groups sudo --shell "$( command -v bash )" "$USER_NAME"
echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USER_NAME"
