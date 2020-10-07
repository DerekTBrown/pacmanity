#!/bin/bash
# Pacmanity
# Keeps a list of installed packages in a Gist at your GitHub account.

pacmanity_install(){
    echo "A list of installed packages will be automatically maintained"
    echo "by Pacmanity in a private Gist at your GitHub account."

    echo -e "\n- Step 1: Log in to Gist using your GitHub account:"
    [[ -f ~/.gist ]] || gist --login
    mkdir -p $pkgdir/root
    cp -v ~/.gist $pkgdir/root/.gist

    echo -e "\n- Step 2: Save list of currently installed packages to Gist:"
    GIST_URL=$(
        (
            pacman -Qqen
            echo
            pacman -Qqem
        ) | gist -p -f $HOSTNAME.pacmanity -d "$HOSTNAME: List of installed packages"
    )

    echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/pacmanity

    echo "An automatically mantained list of installed packages"
    echo "has been successfully created in your GitHub Gist."
    echo "Visit https://gist.github.com or the direct link below:"
    echo "$GIST_URL"
}

pacmanity_update(){
    if (pacman -Qqen; echo; pacman -Qqem) | gist -u "$GIST_ID" -f $HOSTNAME.pacmanity; then
        echo "Pacmanity: Gist successfully updated."
    else
        echo "Pacmanity: ERROR! Try running"
        echo "sudo gist --login"
    fi
}

# Add Ruby to PATH
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# Load config
[[ -r '/etc/pacmanity' ]] && source /etc/pacmanity

# Determine if fresh install is needed
if [ -z "$GIST_ID" ]; then
    echo "Info: Gist is not set up for Pacmanity."
    echo "Reinstalling Pacmanity can solve this issue."
else
    pacmanity_update
fi
