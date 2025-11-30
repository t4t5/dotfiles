require("bunny"):setup({
	hops = {
		{ key = "R", path = "/", desc = "system root" },
		{ key = "h", path = "~", desc = "home" },
		{ key = ".", path = "~/dev/dotfiles", desc = "dotfiles" },
		{ key = ",", path = "~/dev", desc = "dev" },
		{ key = "d", path = "~/Downloads", desc = "downloads" },
		{ key = "i", path = "~/Pictures", desc = "images" },
		{ key = "v", path = "~/Videos", desc = "videos" },
		{ key = "s", path = "~/Documents/syncthing", desc = "syncthing" },
		{ key = "e", path = "/run/media/t4t5", desc = "external drives" },
	},
	desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
	ephemeral = true, -- Enable ephemeral hops, default is true
	tabs = true, -- Enable tab hops, default is true
	notify = false, -- Notify after hopping, default is false
	fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})
