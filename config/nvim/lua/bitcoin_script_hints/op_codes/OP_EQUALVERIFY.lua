local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for EQUALVERIFY", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)
  local b = table.remove(new_state.main)

  table.insert(new_state.main, a == b and 1 or 0)

  local val = table.remove(new_state.main)
  local num_val = to_number(val)

  if num_val == 0 then
    return make_error("Verification failed", state)
  end

  return new_state
end
