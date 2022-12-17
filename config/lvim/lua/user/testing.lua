-- vitest:
require('nvim-test.runners.jest'):setup {
  command = "./node_modules/.bin/vitest",
}

-- rspec:
require('nvim-test.runners.rspec'):setup({
  command = "bundle",
  args = { "exec", "rspec" },
})

-- <leader>t mapping:
lvim.builtin.which_key.mappings["t"] = {
  name = "test",
  f = { "<cmd>TestFile<cr>", "test current file" },
  n = { "<cmd>TestNearest<cr>", "test nearest" },
}
