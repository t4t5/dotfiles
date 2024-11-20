local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.alt == 0 then
    return make_error("Alt stack underflow", state)
  end
  local new_state = vim.deepcopy(state)
  local val = table.remove(new_state.alt)
  table.insert(new_state.main, val)
  return new_state
end
