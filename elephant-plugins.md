## Elephant Plugins (Walker menus)

Elephant is the data provider for Walker. Custom menus live in `config/elephant/menus/` (symlinked to `~/.config/elephant/menus/`).

### Plugin structure

Each `.lua` file exports a `Name`, `NamePretty`, and a `GetEntries()` function:

```lua
Name = "myplugin"
NamePretty = "My Plugin"

function GetEntries()
  local entries = {}
  table.insert(entries, {
    Text = "Display text",
    Subtext = "Optional subtitle",
    Actions = {
      activate = "shell-command-to-run",
    },
  })
  return entries
end
```

### Key details

- `GetEntries()` takes **no arguments** — Walker handles filtering/search
- `Name` determines the provider ID, used as `menus:<name>`
- Launch with: `omarchy-launch-walker -m menus:<name>`
- After changing a plugin, restart with `omarchy-restart-walker`
- Avoid `utf8.char()` for icon glyphs — pre-render them in bash and read from a cache file instead
- Use `os.execute()` for fire-and-forget commands, `io.popen()` when you need output

### Existing plugins

- `nerdfont.lua` — search/copy nerd font icons
- `react_icons.lua` — search/copy react icon components
- `omarchy_themes.lua` — switch Omarchy themes
