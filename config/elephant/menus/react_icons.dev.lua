Name = "reacticons-dev"
NamePretty = "React Icons"
Cache = false

function GetEntries(query)
	local entries = {}

	local datadir = "/usr/share/elephant-react-icons"
	local names_file = datadir .. "/names.txt"
	local preview_dir = datadir .. "/previews"
	local copy_svg = datadir .. "/bin/react-icons-copy-svg"

	local nf = io.open(names_file, "r")
	if not nf then
		return entries
	end

	query = (query or ""):lower()

	for name in nf:lines() do
		if query == "" or name:lower():find(query, 1, true) then
			table.insert(entries, {
				Text = name,
				Subtext = "React Icon",
				Icon = preview_dir .. "/" .. name .. ".png",
				Actions = {
					activate = copy_svg .. " " .. name,
				},
			})
		end
	end

	nf:close()
	return entries
end
