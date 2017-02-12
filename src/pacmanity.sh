#!/bin/bash
#
# pacmanity generates a list of packages installed via pacman GitHub

pacmanity(){
    # Add Ruby to PATH
    PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

    # Load Config
    [[ -r '/etc/pacmanity' ]] && source $pkgdir/etc/pacmanity

    # Determine if gist or pure git.
    if [ -z "$GIT_REMOTE" ]; then
        echo -e "[Pacmanity]: Pure git remote not yet set."
        echo -e '[Pacmanity]: You need to set $GIT_REMOTE in /etc/pacmanity or alternatively set $GIST_ID to use Gist as a backend.'
    # Determine if Fresh Install is Needed
    else if [ -z "$GIST_ID" ]; then
        echo -e "[Pacmanity]: Gist backup for pacman-installed apps not setup."
        echo -e "[Pacmanity]: You need to use your GitHub credentials to log into GitHub Gist."
      else
        pacmanity_update;
      fi
    fi
}

pacmanity_install(){
  echo -e "\nApps installed via 'pacman -S' command will be"
  echo -e "saved to the first package list privately to your GitHub Account.";

  echo -e "\nStep 1: use GitHub™’s Gist (y/n)?";
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    gist --login;
    mkdir -p $pkgdir/root;
    cp ~/.gist $pkgdir/root/.gist;
    echo -e "\nStep 2: Creating list with pacman-installed apps";
    GIST_URL=$(pacman -Qqen | gist -p -f $HOSTNAME.pacman -d "$HOSTNAME: Packages installed via pacman")
    echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/pacmanity;
  else
    if [ ! -d $HOME/Packages ]; then mkdir $HOME/Packages; fi
    echo -e "\n Using a pure Git remote instead."
    read -p "\nPlease enter a valid blank Git remote: " GIT_REMOTE
    echo "GIT_REMOTE=$GIT_REMOTE" >> $pkgdir/etc/pacmanity;
    pacmanity_update;
  fi

  echo -e "\nYour package list is safely backed up, and will be updated"
  echo -e "automatically every time you install/remove a package using the pacman."
  echo -e "You can view your backup lists at https://gist.github.com/user"
  echo -e "or directly at the link below:\n";
  echo "$GIST_URL";
}

pacmanity_update(){
  cd $HOME/Packages;
  if [ "$GIT_REMOTE" ]; then
    echo -e "[Pacmanity]: Updating package list backup on $GIT_REMOTE";
    if pacman -Qqen > pkglist.dat && git init && git add pkglist.dat && git commit -m "[Pacmanity]: updated pacman packages." && git remote add origin $GIT_REMOTE && git push -u origin master:$HOSTNAME; then
      echo -e "Success!\n";
    else
      echo -e "An error occured.\nTry running the commands yourself.";
    fi
  else
    echo -e "[Pacmanity]: Updating package list backup on GitHub™ Gist";
    if pacman -Qqen | gist -u "$GIST_ID"; then
      echo -e "Success!\n";
    else
      echo -e "An error has occured.\nTry running sudo gist --login";
    fi
  fi
}

pacmanity
