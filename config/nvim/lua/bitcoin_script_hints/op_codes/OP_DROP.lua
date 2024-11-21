local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 1 then
    return make_error("Need one item for DROP", state)
  end
  local new_state = vim.deepcopy(state)
  table.remove(new_state.main)

  return new_state
end
