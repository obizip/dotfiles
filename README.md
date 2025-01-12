# dotfiles

## Requirements
- [GNU stow](https://www.gnu.org/software/stow/)
- [mise](https://mise.jdx.dev/getting-started.html)

## Commands

- check
```sh
stow --simulate common desktop mac
```

- link
```sh
stow -vR common desktop mac
```

- unlink
```sh
stow -D common desktop mac
```
