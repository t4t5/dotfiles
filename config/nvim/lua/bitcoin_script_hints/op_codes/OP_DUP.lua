local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main == 0 then
    return make_error("Stack underflow", state)
  end
  local new_state = vim.deepcopy(state)
  local val = new_state.main[#new_state.main]
  table.insert(new_state.main, val)
  return new_state
end
