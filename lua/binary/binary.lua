local function to_decimal(input)
  if input:match("[a-zA-Z]") then
    return 0
  end

  local sum = 0

  for i=#input,1,-1 do
    local bit = tonumber(input:sub(i,i))
    if bit == 1 then
      local power = #input - i
      local result = 2 ^ power
      sum = sum + result
    end
  end

  return sum
end

return {
  to_decimal = to_decimal
}
