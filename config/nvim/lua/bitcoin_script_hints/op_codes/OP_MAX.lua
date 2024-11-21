local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for MAX", state)
  end
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)
  local b = table.remove(new_state.main)

  local num_a, err_a = to_number(a)
  if not num_a then
    return make_error(err_a, state)
  end
  local num_b, err_b = to_number(b)
  if not num_b then
    return make_error(err_b, state)
  end

  table.insert(new_state.main, math.max(num_a, num_b))
  return new_state
end
