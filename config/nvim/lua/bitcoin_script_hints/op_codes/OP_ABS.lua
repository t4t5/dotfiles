local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for ABS", state)
  end
  local new_state = vim.deepcopy(state)
  local val = table.remove(new_state.main)

  local num_val, err_val = to_number(val)
  if not num_val then
    return make_error(err_val, state)
  end

  table.insert(new_state.main, math.abs(num_val))
  return new_state
end
