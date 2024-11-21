local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 4 then
    return make_error("Need four items for 2SWAP", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)   -- top
  local b = table.remove(new_state.main)   -- second
  local c = table.remove(new_state.main)   -- third
  local d = table.remove(new_state.main)   -- fourth

  table.insert(new_state.main, b)          -- second
  table.insert(new_state.main, a)          -- first
  table.insert(new_state.main, d)          -- fourth
  table.insert(new_state.main, c)          -- third
  return new_state
end
