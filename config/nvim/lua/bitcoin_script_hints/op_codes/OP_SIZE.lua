local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for SIZE", state)
  end
  local new_state = vim.deepcopy(state)
  -- Don't remove top item, just peek at it
  local val = tostring(new_state.main[#new_state.main])
  table.insert(new_state.main, #val) -- Push length of item's string representation
  return new_state
end
