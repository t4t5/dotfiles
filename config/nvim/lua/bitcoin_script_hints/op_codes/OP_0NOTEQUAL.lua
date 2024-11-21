local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for 0NOTEQUAL", state)
  end
  local new_state = vim.deepcopy(state)
  local val = table.remove(new_state.main)

  local num_val, err_val = to_number(val)
  if not num_val then
    return make_error(err_val, state)
  end

  -- Returns 0 if input is 0, 1 otherwise
  table.insert(new_state.main, num_val == 0 and 0 or 1)
  return new_state
end
