local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for 2DROP", state)
  end
  local new_state = vim.deepcopy(state)
  table.remove(new_state.main)
  table.remove(new_state.main)

  return new_state
end
