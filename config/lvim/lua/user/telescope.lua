-- find files = <C-f>
lvim.keys.normal_mode["<C-f>"] = ":Telescope git_files<cr>"

-- fuzzy grep = <C-p>
lvim.keys.normal_mode["<C-p>"] = ":Telescope live_grep<cr>"

-- buffers = <C-b>
lvim.keys.normal_mode["<C-b>"] = ":Telescope buffers<cr>"

-- move through suggestions = <C-j>/<C-k>
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<esc>"] = actions.close,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- filter results:
lvim.builtin.telescope.pickers = {
  -- don't show all files
  find_files = { find_command = {
    "rg", "--files", "--hidden", "-g", "!.git",
  } },
  buffers = { sort_lastused = true, ignore_current_buffer = true },
}

-- better selector for references:
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "ui-select")
end

lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "vendor/*",
  "%.lock",
  "__pycache__/*",
  "%.sqlite3",
  "%.ipynb",
  "node_modules/*",
  "%.jpg",
  "%.jpeg",
  "%.png",
  "%.otf",
  "%.ttf",
  ".git/",
  "%.webp",
  ".dart_tool/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".vscode/",
  "__pycache__/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "target/",
  "%.pdb",
  "%.dll",
  "%.class",
  "%.exe",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
  "smalljre_*/*",
  ".vale/",
  ".lint-todo/*"
}
