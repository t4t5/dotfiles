local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for IF", state)
  end
  local new_state = vim.deepcopy(state)
  local condition = table.remove(new_state.main)

  local num_condition, err_condition = to_number(condition)
  if not num_condition then
    return make_error(err_condition, state)
  end

  -- Store the condition result in the state for ENDIF to use
  new_state.if_result = num_condition ~= 0
  return new_state
end
