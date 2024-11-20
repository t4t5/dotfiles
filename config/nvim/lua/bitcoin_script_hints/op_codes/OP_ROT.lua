local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 3 then
    return make_error("Need three items for ROT", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main) -- top
  local b = table.remove(new_state.main) -- second
  local c = table.remove(new_state.main) -- third
  table.insert(new_state.main, b)        -- second -> bottom
  table.insert(new_state.main, a)        -- top -> middle
  table.insert(new_state.main, c)        -- third -> top
  return new_state
end
