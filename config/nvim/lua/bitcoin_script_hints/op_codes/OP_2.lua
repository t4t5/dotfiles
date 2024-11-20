return function(state)
  local new_state = vim.deepcopy(state)
  table.insert(new_state.main, 2)
  return new_state
end
