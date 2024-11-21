local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 3 then
    return make_error("Need number, pubkey, and signature for CHECKSIGADD", state)
  end
  local new_state = vim.deepcopy(state)

  table.remove(new_state.main)           -- pubkey
  table.remove(new_state.main)           -- signature
  local n = table.remove(new_state.main) -- current count

  local num_n, err_n = to_number(n)
  if not num_n then
    return make_error(err_n, state)
  end

  -- Always add 1 to simulate successful signature check
  table.insert(new_state.main, num_n + 1)
  return new_state
end
