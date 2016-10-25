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
      echo -e "\nError: Gist Backup not Setup."
      echo -e "\nRun yaourt -S pacmanity and follow instructions."
    else
      pacmanity_update;
    fi
}

pacmanity_install(){
  echo -e "\nGist Backup is a alpm hook which saves an updated"
  echo -e "version of your package list privately to your GitHub Account"
  echo -e "with every package installation or removal.\n";

  echo -e "\nStep 1: Login to Gist";
  gist --login;
  mkdir -p $pkgdir/root;
  cp ~/.gist $pkgdir/root/.gist;

  echo -e "\nStep 2: Creating Backup";
  GIST_URL=$(pacman -Qqen | gist -p -f arch_pacman -d "Arch Packages installed via pacman")

  echo "GIST_ID=$GIST_URL" | sed 's/https:\/\/gist.github.com\///g' >> $pkgdir/etc/pacmanity;

  echo -e "\nYour package list is safely backed up, and will be updated automatically"
  echo -e "every time you install or remove a package using a package manager."
  echo -e "You can view your backup at the link below:\n";
  echo "$GIST_URL";
}

pacmanity_update(){
  echo -e "\nUpdating Package List Backup...";
  if pacman -Qqen | gist -u "$GIST_ID"; then
    echo -e "Success!\n";
  else
    echo -e "An error has occured.\nTry running sudo gist --login";
  fi
}

pacmanity
