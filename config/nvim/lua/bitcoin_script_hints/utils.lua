local M = {}

-- Helper to create error state
function M.make_error(message, prev_state)
  return {
    error = message,
    main = prev_state.main, -- keep previous state for context
    alt = prev_state.alt
  }
end

-- Helper to safely convert to number
function M.to_number(val)
  if type(val) == "number" then
    return val
  end
  local num = tonumber(val)
  if num then
    return num
  end
  return nil, "Cannot convert '" .. tostring(val) .. "' to number"
end

return M
