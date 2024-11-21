local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 1 then
    return make_error("Stack underflow", state)
  end
  local new_state = vim.deepcopy(state)
  local val = table.remove(new_state.main)
  -- Create hashed representation by wrapping in H()
  table.insert(new_state.main, "H(" .. tostring(val) .. ")")
  return new_state
end
