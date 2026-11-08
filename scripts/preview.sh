# Preview hook for .github/scripts/render-previews.sh: delta renders the diff
# between the two fixtures with each variant.
# shellcheck shell=bash
name=delta

setup() {
  # delta ignores BAT_* variables but follows XDG, so a throwaway tree isolates bat.
  export XDG_CONFIG_HOME="$work/xdg" XDG_CACHE_HOME="$work/cache"
  mkdir -p "$XDG_CONFIG_HOME/bat/themes"
  git clone -q --depth 1 https://github.com/kanagawa-community/bat "$work/bat-port"
  cp "$work"/bat-port/themes/*.tmTheme "$XDG_CONFIG_HOME/bat/themes/"
  bat cache --build >/dev/null
}

capture() {
  # git exits 1 when the files differ. A missing fixture gives empty output, which
  # render-previews.sh rejects.
  git -C "$root/scripts/fixtures" diff --no-index --color=always before.rs after.rs >"$work/diff" || true
  delta --config "$root/themes/kanagawa-$1.gitconfig" --features "kanagawa-$1" \
    --width 80 --paging never <"$work/diff" >"$2"
}
