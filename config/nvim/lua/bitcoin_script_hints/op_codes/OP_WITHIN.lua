local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 3 then
    return make_error("Need three items for WITHIN", state)
  end
  local new_state = vim.deepcopy(state)
  local max = table.remove(new_state.main)   -- top item is maximum
  local min = table.remove(new_state.main)   -- next item is minimum
  local x = table.remove(new_state.main)     -- value to test

  local num_max, err_max = to_number(max)
  if not num_max then
    return make_error(err_max, state)
  end
  local num_min, err_min = to_number(min)
  if not num_min then
    return make_error(err_min, state)
  end
  local num_x, err_x = to_number(x)
  if not num_x then
    return make_error(err_x, state)
  end

  -- Returns 1 if min <= x < max, 0 otherwise
  table.insert(new_state.main, (num_x >= num_min and num_x < num_max) and 1 or 0)
  return new_state
end
