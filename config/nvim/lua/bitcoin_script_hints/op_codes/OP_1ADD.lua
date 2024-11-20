local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  local new_state = vim.deepcopy(state)
  local a = table.remove(new_state.main)

  local num_a, err_a = to_number(a)
  if not num_a then
    return make_error(err_a, state)
  end

  table.insert(new_state.main, num_a + 1)
  return new_state
end
