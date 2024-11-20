return function(state)
  -- Just remove the if_result flag, no stack changes
  local new_state = vim.deepcopy(state)
  new_state.if_result = nil
  return new_state
end
