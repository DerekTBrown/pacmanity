#!/bin/bash
# Pacmanity
# Keeps a list of installed packages in a Gist at your GitHub account.

[[ -n "$GIST_ID" ]] || source /etc/pacmanity
if (pacman -Qqen; echo; pacman -Qqem) | gist -u "$GIST_ID" -f $HOSTNAME.pacmanity; then
    echo "Pacmanity: Gist successfully updated."
else
    echo "Pacmanity: ERROR!"
    echo "1. Try running 'sudo gist --login'"
    echo "2. Ensure the gist exists, if specified"
fi