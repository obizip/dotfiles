# dotfiles

**For Ubuntu-22.04 in WSL**

## How to install
```
git clone https://github.com/obi-3/dotfiles.git
cd dotfiles/install
./dotinstaller.sh
```

## Main packages
* homebrew (package manager)
* nvim
* tmux
* fzf
* ripgrep
* exa
* bat
* ghq

## Shell
* prezto
* starship

## After installation

### Change shell
```
chsh -s /bin/zsh
```

### Update nvim
```bash
nvim --headless "+Lazy! sync" +qa
```
