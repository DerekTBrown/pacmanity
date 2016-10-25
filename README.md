# Pacmanity
List of packages installed via pacman and yaourt on your Arch machine automatically saved to GitHub.

## Installation
**1) Downloading and installing:**

- using yaourt [Aur](https://aur.archlinux.org/packages/pacmanity/)
```
$ yaourt pacmanity
```

- using makepkg
```
$ wget https://github.com/alexchernokun/pacmanity/tarball/master -O - | tar xz
$ cd to the downloaded directory (alexchernokun-pacmanity-xxxxxx)
$ makepkg
$ sudo pacman -U pacmanity-version
```

**2) Setup stage:**

On the installing stage you will be prompted to fill in GitHub credentials two times;
1) first time it is needed to create gist for pacman-installed packages on GItHub;
2) second time gist with AUR-installed packages should be set up, that is why the login details should be filled in once again

## Usage

Every time you install or remove a package using official Arch repository or unofficial (AUR)





*P.S.: and now for something completely different:*
![bachmanity](https://pbs.twimg.com/media/Cjegi2dVAAEOU2n.jpg)
