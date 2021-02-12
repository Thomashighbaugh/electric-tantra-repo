# Bhairava

Minimalist grub theme inspired by Matter, which in turn was inspired by Google's Material Design!

# Installation

```bash
git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme

cd Bhairava-Grub-Theme

sudo chmod +x svg2png.sh
./svg2png.sh

sudo chmod +x set-grub.sh
./set-grub.sh


```

Or you can always download the repo as a zip too.

### Highlight color

During installation you can choose a theme color to be displayed with the theme.

`sudo ./set-grub.sh -p <color>` (`./set-grub.sh -h` for list of available
colors)

# Removal

Executing `sudo ./set-matter.sh -u` will remove the theme's folder and remove it from the grub configuration.

**Note:** Grub is fickle about changes and removing the folder in other ways may break your installation or worse, please do use the uninstallation feature instead. If you would like to modify the theme to your taste, please do it by modifying these files unless **you absolutely know what you are doing** or at least don't say I didn't warn you.
