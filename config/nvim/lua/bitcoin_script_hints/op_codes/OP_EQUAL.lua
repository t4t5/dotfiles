local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for EQUAL", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)
  local b = table.remove(new_state.main)

  table.insert(new_state.main, a == b and 1 or 0)
  return new_state
end
