-- vitest:
require('nvim-test.runners.jest'):setup {
  command = "./node_modules/.bin/vitest",
}

-- rspec:
require('nvim-test.runners.rspec'):setup({
  command = "bundle",
  args = { "exec", "rspec" },
})
