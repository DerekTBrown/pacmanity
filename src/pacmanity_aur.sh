#!/bin/bash
#
# pacmanity_aur generates a list of packages installed via yaourt (aur) GitHub

pacmanity_aur(){
    # Add Ruby to PATH
    PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

    # Load Config
    [[ -r '/etc/pacmanity_aur' ]] && source $pkgdir/etc/pacmanity_aur

    # Determine if Fresh Install is Needed
    if [ -z "$GIST_ID" ]; then
      echo -e "\nInfo: Gist backup for apps installed from AUR not setup."
      echo -e "\nplease fill in your GitHub credentials one more time to log into GitHub Gist."
    else
      pacmanity_aur_update;
    fi
}

pacmanity_aur_install(){
  echo -e "\nApps installed via 'yaourt' command will be"
  echo -e "saved to the second package list privately to your GitHub Account.";

  echo -e "\nStep 1: Fill in GitHub credentials one more time"
  echo -e "to create the second list with yaourt-installed apps";
  gist --login;
  mkdir -p $pkgdir/root;
  cp ~/.gist $pkgdir/root/.gist;

  echo -e "\nStep 2: Creating list with yaourt-installed apps";
  GIST_URL=$(pacman -Qqem | gist -p -f $HOSTNAME-yaourt -d "$HOSTNAME: Packages installed from AUR")

  echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/pacmanity_aur;

  echo -e "\nYour package list is safely backed up, and will be updated"
  echo -e "automatically every time you install/remove a package using the yaourt."
  echo -e "You can view your backup lists at https://gist.github.com/user"
  echo -e "or directly at the link below:\n";
  echo "$GIST_URL";
}

pacmanity_aur_update(){
  echo -e "\nUpdating package list backup on GitHub...";
  if pacman -Qqem | gist -u "$GIST_ID"; then
    echo -e "Success!\n";
  else
    echo -e "An error has occured.\nTry running sudo gist --login";
  fi

}

pacmanity_aur
