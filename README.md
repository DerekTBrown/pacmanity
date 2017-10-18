# Pacmanity
List of packages installed via pacman and yaourt on your Arch machine automatically saved to GitHub.
> *all ideas and improvments are always welcome!*


## Installation

**1) Downloading and installing:**

I don't know why, but owner of plist-gist (the repo where I took the source code) requested pacmanity removal from AUR, that is why, unfortunately, the only way to install is using the makepkg method below.
- using yaourt [Aur](https://aur.archlinux.org/packages/pacmanity/)
```
$ yaourt pacmanity
```

- using makepkg
```
$ wget https://github.com/alexchernokun/pacmanity/tarball/master -O - | tar xz
```

navigate to the downloaded directory (alexchernokun-pacmanity-xxxxxx):

```
$ makepkg
$ sudo pacman -U
```

**2) Setup stage:**
On the installation stage you will be prompted to fill in GitHub credentials two times;
1) first time it is needed to create gist for pacman-installed packages on GItHub;
2) second time gist with AUR-installed packages should be set up, that is why the login details should be filled in once again


## Usage

Every time you install or remove a package using [official Arch repository](https://www.archlinux.org/packages/) or unofficial [AUR](https://aur.archlinux.org/) all the changes will be saved privately to your GitHub account.
You have nothing to do, just install the pacmanity, and that's all.
Two hooks will be created and run everytime the pacman command is used.

### recovery

By cloning the gist files to your fresh installed machine you can import them into pacman rather easy;

![gist-clone](https://image.prntscr.com/image/ObTqDXicRk6a9h7alSIVMw.png)

* pacman package list:

```bash
$ git clone git@gist.github.com:#############.git
$ cd #############
$ sudo pacman -S - < $(hostname).pacman
```

* AUR package list:

```bash
$ git clone git@gist.github.com:#############.git
$ cd #############
$ xargs <$(hostname).yaourt pacaur -S --noedit
```

**Screenshots:**
Navigate to your Gist GitHub account here and you will see:
- list of packages installed with 'pacman -S' command:
![pacman](http://image.prntscr.com/image/cf15521e7b794acdb37b2a8bc5e4455c.png)
- list of packages installed from AUR with yaourt:
![AUR](http://image.prntscr.com/image/d5bb89e7020d4b18a236d94adf3eb32f.png)
- every installation will be automatically added to the gist:
![after_installation](http://image.prntscr.com/image/65eeb152529e4b1dbab78de777074679.png)
- every removal also will be mentioned on the list:
![after_removal](http://image.prntscr.com/image/3d945ff4d17e460a99dd1382cfb8689d.png)

<details>
  <summary>*P.S.: : *And now for something completely different:</summary>
    ![bachmanity](https://pbs.twimg.com/media/Cjegi2dVAAEOU2n.jpg)
</details>
