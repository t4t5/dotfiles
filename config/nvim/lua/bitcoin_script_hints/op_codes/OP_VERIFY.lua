local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for VERIFY", state)
  end
  local new_state = vim.deepcopy(state)
  local val = table.remove(new_state.main)
  local num_val = to_number(val)

  if num_val == 0 then
    return make_error("Verification failed", state)
  end

  return new_state
end
