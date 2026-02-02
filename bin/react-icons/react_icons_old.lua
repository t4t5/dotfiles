Name = "reacticons"
NamePretty = "React Icons"
Cache = false

function GetEntries()
	local entries = {}

	local cache_dir = os.getenv("XDG_CACHE_HOME")
	if not cache_dir or cache_dir == "" then
		cache_dir = os.getenv("HOME") .. "/.cache"
	end
	cache_dir = cache_dir .. "/react-icons"

	local query_file = cache_dir .. "/query.txt"
	local names_file = cache_dir .. "/names.txt"
	local preview_dir = cache_dir .. "/previews"
	local copy_svg = os.getenv("HOME") .. "/.bin/react-icons/copy-svg"

	-- Read query
	local qf = io.open(query_file, "r")
	if not qf then
		return entries
	end
	local query = qf:read("*l")
	qf:close()
	if not query or query == "" then
		return entries
	end
	query = query:lower()

	-- Read names and filter
	local nf = io.open(names_file, "r")
	if not nf then
		return entries
	end

	local max_results = 200
	local count = 0

	for name in nf:lines() do
		if count >= max_results then
			break
		end
		if name:lower():find(query, 1, true) then
			count = count + 1
			table.insert(entries, {
				-- Text = name,
				Subtext = name,
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
