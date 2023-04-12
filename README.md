# dotfiles

**For ArchWSL**

## How to install
```
git clone https://github.com/obi-3/dotfiles.git
cd dotfiles/setup
./setup.sh
```

## Main packages
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
