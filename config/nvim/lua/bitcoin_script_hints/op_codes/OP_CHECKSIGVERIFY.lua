local utils = require('bitcoin_script_hints.utils')
local make_error = utils.make_error
local to_number = utils.to_number

return function(state)
  if #state.main < 2 then
    return make_error("Need pubkey and signature for CHECKSIGVERIFY", state)
  end
  local new_state = vim.deepcopy(state)
  -- Remove pubkey and signature from stack
  table.remove(new_state.main) -- pubkey
  table.remove(new_state.main) -- signature

  -- Always push 1 to simulate successful verification
  table.insert(new_state.main, 1)

  -- TODO: extract this:
  local val = table.remove(new_state.main)
  local num_val = to_number(val)

  if num_val == 0 then
    return make_error("Verification failed", state)
  end

  return new_state
end
