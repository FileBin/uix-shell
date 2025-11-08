# Uix shell

Uix shell is wrapper around nix-shell, to work with it without terminal.

## Features

* Reports build fails with a notification using libnotify

## Planned

* Confirmation dialog to allow unfree packages
* Build progress indicator

## Usage

First step is to install uix-shell package with the home-manager (or system configuration if you need) 

```nix
# home-manager.nix
{ pkgs, ... }:
let uix-shell = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner  = "FileBin";
    repo   = "uix-shell";
    rev    = "eacc75993cf79bf45357babdd432ed581b1dea32";
    sha256 = "hpEQPOYbfRcTNGFWU7fjzPeLuJE2HAXaQaVRqdABnk8=";
  }) {};
in
{
  home.packages = [
    uix-shell
  ];
}
```

### Option 1. Shebang

Add this shebang to your `shell.nix`

```sh
#!/usr/bin/env uix-shell
```

Then you can change extension to `.sh` to execute it by double clicking from your file manager

### Option 2. Mime type

> This way, the shell file will have a dedicated `nix-snowflake` icon 

Add `text/x-uix` mime type to your home manager

```nix 
# home-manager.nix
{
  xdg.dataFile."mime/packages/uix.xml".text = ''
    <?xml version="1.0" encoding="utf-8"?>
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
    <mime-type type="text/x-uix">
      <glob pattern="*.uix"/>
      <comment>Uix-shell file</comment>
      <sub-class-of type="text/plain"/>
      <icon name="nix-snowflake" />
    </mime-type>
    </mime-info>
  '';
}
```

Then you can change `shell.nix` extension to `.uix` and execute it by double clicking from your file manager


## Uix shell examples

- [steam-run.uix](examples/steam-run.uix)
- [vscode-embedded.uix](examples/vscode-embedded.uix)
- [vscode-nix.uix](examples/vscode-nix.uix)
- [vscode-python.uix](examples/vscode-python.uix)
- [warthunder-fhsenv.uix](examples/warthunder-fhsenv.uix)