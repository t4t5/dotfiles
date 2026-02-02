#!/bin/bash

# @vicinae.schemaVersion 1
# @vicinae.title Nerdfont icons - Search
# @vicinae.mode compact
# @vicinae.icon

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
cache_file="$cache_dir/nerdfont/icons.txt"

if [[ ! -f "$cache_file" ]]; then
  mkdir -p "$cache_dir/nerdfont"
  curl -sL 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json' \
    | jq -r 'del(.METADATA) | to_entries[] | "\(.value.char)\t\(.key)"' \
    > "$cache_file"
fi

selected=$(awk -F'\t' '{printf "%s    %s\n", $1, $2}' "$cache_file" | vicinae dmenu -p "Nerdfont:")

[[ -z "$selected" ]] && exit 0

icon="${selected%% *}"
printf '%s' "$icon" | wl-copy
echo "Copied $icon"
