## 🧿 dots

<img src="./assets/screenshot_1.png">

dotfiles for my daily driver. i run arch with hyprland as my wm. config
currently includes:
- hyprland (wm)
- foot (terminal)
- zsh (shell)
- neovim (editor)
- yazi (file manager)
- waybar (status bar)
- rofi (picker)
- & more


### gallery

<img width=50% src="./assets/screenshot_6.png"><img width=50% src="./assets/screenshot_5.png">

### installation

```bash
git clone https://github.com/mellowcoffee/dots.git
cd dots
```

a script is provided to install the configurations. any existing config is
backed up, and the present dotfiles are symlinked.

```bash
./install.sh nvim dunst fastfetch # install individual configurations by directory name
./install.sh -a # install all configurations
./install.sh -f .vimrc .bashrc # install standalone config files into $HOME
```

zsh has to know about ~/.config/zsh, which is achieved by linking to
zsh/.zshenv from ~/.zshenv. this can be performed via the following command:

```bash
./install.sh -l zsh/.zshenv $HOME/.zshenv
```

### notes

this config uses a number of shell scripts, which may be found [🐚 here](https://github.com/mellowcoffee/scripts)
