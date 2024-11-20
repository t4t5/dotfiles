return function(state)
  local new_state = vim.deepcopy(state)
  table.insert(new_state.main, #new_state.main)
  return new_state
end
