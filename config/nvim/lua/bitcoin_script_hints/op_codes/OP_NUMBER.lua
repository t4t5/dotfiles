return function(num)
  return function(state)
    local new_state = vim.deepcopy(state)
    table.insert(new_state.main, num)
    return new_state
  end
end
