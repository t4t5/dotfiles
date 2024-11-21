local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 6 then
    return make_error("Need six items for 2ROT", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)   -- top
  local b = table.remove(new_state.main)   -- second
  local c = table.remove(new_state.main)   -- third
  local d = table.remove(new_state.main)   -- fourth
  local e = table.remove(new_state.main)   -- fifth
  local f = table.remove(new_state.main)   -- sixth

  -- Rotate three pairs
  table.insert(new_state.main, d)   -- fourth
  table.insert(new_state.main, c)   -- third
  table.insert(new_state.main, b)   -- second
  table.insert(new_state.main, a)   -- first
  table.insert(new_state.main, f)   -- sixth
  table.insert(new_state.main, e)   -- fifth
  return new_state
end
