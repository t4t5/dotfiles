local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main == 0 then
    return make_error("Need one item for IFDUP", state)
  end
  local new_state = vim.deepcopy(state)
  local val = new_state.main[#new_state.main]

  local num_condition = to_number(val)

  if num_condition ~= 0 then
    table.insert(new_state.main, val)
  end

  return new_state
end
