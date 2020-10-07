#!/bin/bash
# Pacmanity
# Keeps a list of installed packages in a Gist at your GitHub account.

pacmanity_build() {
    echo "A list of installed packages will be automatically maintained"
    echo "by Pacmanity in a private Gist at your GitHub account."

    echo -e "\n- Step 1: Log in to Gist using your GitHub account:"
    [[ -f ~/.gist ]] || gist --login # dont save login details in package, due to securiry concerns

    # if file is present, assume it is maanged externally (via a build system)
    [[ -r /etc/pacmanity ]] && source /etc/pacmanity
    if [ -z "$GIST_ID" ]; then
        echo -e "\n- Step 2: Save list of currently installed packages to Gist:"
        GIST_URL=$(echo . | gist -p -f $HOSTNAME.pacmanity -d "$HOSTNAME: List of installed packages")
        GIST_ID=$(echo "$GIST_URL" | sed "s|https://gist.github.com/||g")
        echo $GIST_ID > "$srcdir/gist_id"
    else
        pacmanity_update
    fi

    echo "An automatically mantained list of installed packages"
    echo "has been successfully created in your GitHub Gist."
    echo "Visit https://gist.github.com or the direct link below:"
    echo "$GIST_URL"
}

pacmanity_update() {
    [[ -n "$GIST_ID" ]] || source /etc/pacmanity
    if (pacman -Qqen; echo; pacman -Qqem) | gist -u "$GIST_ID" -f $HOSTNAME.pacmanity; then
        echo "Pacmanity: Gist successfully updated."
    else
        echo "Pacmanity: ERROR!"
        echo "1. Try running 'sudo gist --login'"
        echo "2. Ensure the gist exists, if specified"
    fi
}