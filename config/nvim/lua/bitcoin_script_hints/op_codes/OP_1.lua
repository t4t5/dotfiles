return function(state)
  local new_state = vim.deepcopy(state)
  table.insert(new_state.main, 1)
  return new_state
end
