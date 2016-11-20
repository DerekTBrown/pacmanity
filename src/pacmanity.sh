#!/bin/bash
#
# pacmanity generates a list of packages installed via pacman GitHub

pacmanity(){
    # Add Ruby to PATH
    PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

    # Load Config
    [[ -r '/etc/pacmanity' ]] && source $pkgdir/etc/pacmanity

    # Determine if Fresh Install is Needed
    if [ -z "$GIST_ID" ]; then
      echo -e "\nInfo: Gist backup for pacman-installed apps not setup."
      echo -e "\nYou need to use your GitHub credentials to log into GitHub Gist."
    else
      pacmanity_update;
    fi
}

pacmanity_install(){
  echo -e "\nApps installed via 'pacman -S' command will be"
  echo -e "saved to the first package list privately to your GitHub Account.";

  echo -e "\nStep 1: Login to Gist GitHub";
  gist --login;
  mkdir -p $pkgdir/root;
  cp ~/.gist $pkgdir/root/.gist;

  echo -e "\nStep 2: Creating list with pacman-installed apps";
  GIST_URL=$(pacman -Qqen | gist -p -f $HOSTNAME.pacman -d "$HOSTNAME: Packages installed via pacman")

  echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/pacmanity;

  echo -e "\nYour package list is safely backed up, and will be updated"
  echo -e "automatically every time you install/remove a package using the pacman."
  echo -e "You can view your backup lists at https://gist.github.com/user"
  echo -e "or directly at the link below:\n";
  echo "$GIST_URL";
}

pacmanity_update(){
  echo -e "\nUpdating package list backup on GitHub...";
  if pacman -Qqen | gist -u "$GIST_ID"; then
    echo -e "Success!\n";
  else
    echo -e "An error has occured.\nTry running sudo gist --login";
  fi

}

pacmanity
