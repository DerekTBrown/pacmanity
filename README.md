# Pacmanity
Keeps a list of installed packages in a Gist at your GitHub account.

## Installation

**1. Download and install:**

- From [AUR](https://aur.archlinux.org/packages/pacmanity/) using an AUR helper:
```bash
$ <aur_helper> -S pacmanity
```
Some popular AUR helpers are [`yaourt`](https://github.com/archlinuxfr/yaourt), [`trizen`](https://github.com/trizen/trizen) and [`yay`](https://github.com/Jguer/yay).

- From [AUR](https://aur.archlinux.org/packages/pacmanity/) using `makepkg`:
```bash
$ wget https://github.com/derektbrown/pacmanity/tarball/master -O - | tar xz
$ cd DerekTBrown-pacmanity-*/
$ makepkg -si
```

**2. Setup:**

During the installation of the package you will be prompted to log in to your GitHub account.


## Usage

Once installed, Pacmanity automatically maintains a list of your installed packages in a private Gist at your GitHub account.

The list gets updated every time you install, update or remove packages, keeping track of the current explicitly installed packages from both Arch [official repos](https://www.archlinux.org/packages/) and [AUR](https://aur.archlinux.org/). They are listed in the Gist in that particular order (official, then AUR), separated by a blank line.

No hassle: just install Pacmanity, follow the prompts and you are done.
A pacman hook will be installed and conveniently run when needed to.

## Recovery

By cloning the Gist file to your fresh Arch installation you can easily bulk-install them:

![gist-clone](https://image.prntscr.com/image/ObTqDXicRk6a9h7alSIVMw.png)

```bash
$ git clone git@gist.github.com:<gist_repo>.git
$ cd <gist_repo>
```

- Using `pacman` to install only official packages:

```bash
$ sed -e '/^$/q' $(hostname).pacmanity | sudo pacman -S -
```

- Using an AUR helper to install all packages:

```bash
$ <aur_helper> -S $(tr '\n' ' ' < $(hostname).pacmanity)
```

- Using an AUR helper to install only AUR packages:

```bash
$ <aur_helper> -S $(sed -e '/^$/d' $(hostname).pacmanity | tr '\n' ' ')
```

## Screenshots

Navigate to your [Gist](https://gist.github.com) in GitHub and you will find:
- List of currently installed packages from official repos:
![pacman](http://image.prntscr.com/image/cf15521e7b794acdb37b2a8bc5e4455c.png)
- List of currently installed packages from AUR:
![AUR](http://image.prntscr.com/image/d5bb89e7020d4b18a236d94adf3eb32f.png)
- Every package installation will be automatically added to the Gist:
![after_installation](http://image.prntscr.com/image/65eeb152529e4b1dbab78de777074679.png)
- Every package removal will also be reported in the Gist:
![after_removal](http://image.prntscr.com/image/3d945ff4d17e460a99dd1382cfb8689d.png)

