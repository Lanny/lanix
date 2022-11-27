# LaNix: Lanny's Nix Config

Link up `home.nix` and you're good to go.

```
ln -s home.nix ~/.config/nixpkgs/home.nix
```

## "Server" installation

By default some graphical applications are included, e.g. qutebrowser. Link `nox.nix` instead of `home.nix` to exclude anything that assumes an X install.
