# Contributing to Kanagawa for delta

Thanks for helping. This port follows the
[Kanagawa community contributing guide](https://github.com/kanagawa-community/.github/blob/main/.github/CONTRIBUTING.md),
which explains conventional commits, the checks every pull request runs, and how
changes are reviewed. This page covers only what is specific to this port.

## Where to report what

- Problems with the theme in delta, such as wrong colors, poor
  contrast, or a missing variant, belong in this repository's
  [issue tracker](https://github.com/kanagawa-community/delta/issues).
- Problems in delta itself belong with its maintainers, not here. Start
  from the [application's page](https://github.com/dandavison/delta).
- Changes to the colors themselves belong in the
  [shared palette](https://github.com/kanagawa-community/.github/blob/main/docs/PALETTE.md),
  not in this port. Open an issue in the
  [.github repository](https://github.com/kanagawa-community/.github/issues)
  so every port stays in step.

## Colors

Take colors from the shared [palette](https://github.com/kanagawa-community/.github/blob/main/docs/PALETTE.md)
and follow the [style guide](https://github.com/kanagawa-community/.github/blob/main/docs/STYLE-GUIDE.md).
Do not sample colors from screenshots or add new ones. Every change must work in
Wave, Dragon, and Lotus.

To read the colors from a script, use the machine-readable
[palette.json](https://raw.githubusercontent.com/kanagawa-community/.github/main/palette.json).

## Working on this port

Try a change with a throwaway bat cache, so your own is untouched (delta reads
bat's XDG paths, not `BAT_*`):

```sh
export XDG_CONFIG_HOME=$(mktemp -d) XDG_CACHE_HOME=$(mktemp -d)
mkdir -p "$XDG_CONFIG_HOME/bat/themes"
git clone --depth 1 https://github.com/kanagawa-community/bat "$XDG_CACHE_HOME/bat-port"
cp "$XDG_CACHE_HOME"/bat-port/themes/*.tmTheme "$XDG_CONFIG_HOME/bat/themes/"
bat cache --build
git -c core.pager=cat diff --no-index --color=always scripts/fixtures/before.rs scripts/fixtures/after.rs |
  delta --config themes/kanagawa-wave.gitconfig --features kanagawa-wave
```

Repeat with `kanagawa-dragon` and `kanagawa-lotus`.

The syntax themes live in the
[bat port](https://github.com/kanagawa-community/bat), not here. Change them
there. `themes/*.gitconfig` are edited directly, with colors mapped by palette
role.

The images in `assets/` are rendered, not captured by hand. After changing a
theme, run this from the repository root and commit the new images:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/kanagawa-community/.github/main/scripts/render-previews.sh)
```

It fetches the shared preview scripts from the
[.github repository](https://github.com/kanagawa-community/.github). `scripts/preview.sh` holds the delta-specific
part and needs `delta`, `bat` and `git`, and it clones the bat port for the
syntax themes. See the
[preview standard](https://github.com/kanagawa-community/.github/blob/main/docs/PREVIEWS.md)
for the rest.

## Pull requests

- Keep each pull request to one change, and include a screenshot of each variant
  it affects.
- Update the README when installation or usage changes.
