local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for TUCK", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)   -- top
  local b = table.remove(new_state.main)   -- second
  table.insert(new_state.main, a)          -- insert top item third
  table.insert(new_state.main, b)          -- restore second
  table.insert(new_state.main, a)          -- restore top
  return new_state
end
