return function(s)
  local alphabet_size = 26
  if s == '' or #s < alphabet_size then return false end

  s = string.lower(s)
  local letter_counts = {}
  for i = 1, #s, 1 do
    local letter = string.sub(s, i, i)
    if string.match(letter, "[%a]+") then
      local count = (letter_counts[letter] or 0) + 1
      letter_counts[letter] = count
    end
  end

  local table_count = 0
  for letter, _ in pairs(letter_counts) do
    table_count = table_count + 1
    if letter_counts[letter] >= alphabet_size then return false end
  end
  if table_count < alphabet_size then return false end

  return true
end
