return function(str)
  local s = str:lower()
  local uniques = {}

  for i=1,#s do
    local char = s:sub(i,i)

    if char:match("[a-z]+") then
      if uniques[char] then
        return false
      else
        uniques[char] = true
      end
    end
  end

  return true
end
