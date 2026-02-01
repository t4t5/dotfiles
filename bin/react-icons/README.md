# react-icons select

Search and copy [react-icons](https://react-icons.github.io/react-icons/) SVGs from the command line or via a GUI menu with icon previews.

## Setup

```bash
# 1. Install react-icons and build the names cache (automatic on first run)
react-icons/select

# 2. Generate all PNG previews (one-time, ~50k icons)
react-icons/build-previews
```

## Usage

```bash
# Terminal: interactive search
react-icons/select

# Terminal: search with query
react-icons/select arrow

# GUI: walker menu with icon previews
GUI=1 react-icons/select
```

The selected icon's SVG is copied to the clipboard.

## How it works

### Files

| File | Purpose |
|---|---|
| `select` | Main entrypoint. Prompts for a search query, then shows results via `menu` (terminal) or walker (GUI) |
| `react_icons.lua` | Elephant menu provider for walker. Reads the search query from a cache file, filters the icon names, and returns entries with PNG previews |
| `copy-svg` | Called by walker's activate action. Extracts the SVG for an icon and copies it to the clipboard |
| `to-svg.mjs` | Converts a react-icon name to an SVG string by parsing the GenIcon JSON tree from the npm package |
| `build-cache.mjs` | Extracts all icon names from the react-icons npm package |
| `build-previews` | One-time script to pre-generate all PNG previews |
| `build-all-previews.mjs` | Node script that generates white 64x64 PNGs from all icons using `rsvg-convert` |

### Data flow (GUI mode)

1. Walker (`--inputonly`) prompts for a search term
2. The query is written to `~/.cache/react-icons/query.txt`
3. Walker opens the `menus:reacticons` elephant provider
4. The Lua script reads the query, filters `names.txt`, and returns entries with pre-cached PNG icons
5. On selection, `copy-svg` extracts the SVG from the react-icons npm package and copies it to the clipboard

### Cache structure

```
~/.cache/react-icons/
├── pkg/                 # react-icons npm package
├── names.txt            # all icon names (one per line)
├── query.txt            # current search query (read by Lua)
└── previews/            # pre-generated PNGs
    ├── LuArrowRight.svg
    ├── LuArrowRight.png
    └── ...
```
