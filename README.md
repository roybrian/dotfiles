# dotfiles

Set up a new Mac quickly.

## Usage

``` shell
dotfiles.sh

Usage:
  dt <command> [options...]

Commands:
  standard
  installations [--cleanup | --status] [default: --standard]
  symlinks
  preferences [-f]
  app <app or preference pane>
  weeklymaintenance
  ignition_pre
  ignition_post

Options:
  -f          executes preferences scripts even a given script saw no changes since last execution
  --standard  missing programs will be installed, extraneous ones only printed
  --status    print both missing programs and extraneous ones
  --cleanup   installs missing programs, uninstalls extraneous ones
```
