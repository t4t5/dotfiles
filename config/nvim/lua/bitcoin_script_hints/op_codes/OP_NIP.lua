local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for NIP", state)
  end
  local new_state = vim.deepcopy(state)
  local top = table.remove(new_state.main)   -- save top item
  table.remove(new_state.main)               -- remove second item
  table.insert(new_state.main, top)          -- restore top item
  return new_state
end
