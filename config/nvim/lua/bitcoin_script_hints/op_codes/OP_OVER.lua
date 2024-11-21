local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 2 then
    return make_error("Need two items for OVER", state)
  end
  local new_state = vim.deepcopy(state)
  local second = new_state.main[#new_state.main - 1]   -- peek second item
  table.insert(new_state.main, second)                 -- copy it to top
  return new_state
end
