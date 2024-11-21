local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error

return function(state)
  if #state.main < 4 then
    return make_error("Need four items for 2OVER", state)
  end
  local new_state = vim.deepcopy(state)
  local third = new_state.main[#new_state.main - 2]    -- peek third item
  local fourth = new_state.main[#new_state.main - 3]   -- peek fourth item
  table.insert(new_state.main, fourth)                 -- copy fourth to top
  table.insert(new_state.main, third)                  -- copy third to top
  return new_state
end
