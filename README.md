# dotfiles

## Symbolic link

- link
```sh
./symlink link entries.json --extra mac
```

- unlink
```sh
./symlink unlink
```

Additional tables are applied in the order passed to `--extra`; later tables
override earlier ones. Relative source paths are based on the working directory.

Use `--simulate` with either command to preview actions without changing files.
`link --unlink-exists` replaces conflicting symbolic links, while
`link --move-exists` backs up conflicting files and directories under
`.symlink/backup/run-<unique-id>/`, preserving their absolute directory structure.

`unlink` and `link --autoremove` remove links only when their targets match the
recorded sources. Changed destinations are kept, along with their history entries.
Missing history is treated as empty; malformed history stops the command before
any link operations. History is saved by replacing it with a complete temporary
file.
