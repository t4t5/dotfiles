local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 1 then
    return make_error("Need index for PICK", state)
  end
  local new_state = vim.deepcopy(state)
  local n = table.remove(new_state.main) -- get index

  local num_n, err_n = to_number(n)
  if not num_n then
    return make_error(err_n, state)
  end

  if #new_state.main < num_n + 1 then
    return make_error("Stack too small for PICK", state)
  end

  -- Copy the n-th item from top (0 = top item)
  local item = new_state.main[#new_state.main - num_n]
  table.insert(new_state.main, item)
  return new_state
end
