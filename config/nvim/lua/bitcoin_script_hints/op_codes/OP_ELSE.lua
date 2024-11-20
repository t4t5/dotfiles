local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if state.if_result == nil then
    return make_error("ELSE without matching IF", state)
  end
  local new_state = vim.deepcopy(state)
  -- Just invert the if_result flag
  new_state.if_result = not new_state.if_result
  return new_state
end
