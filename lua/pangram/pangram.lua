return function(s)
  local alphabet_size = 26
  if s == '' or #s < alphabet_size then return false end

  s = string.lower(s)
  local table_size = 0
  local letter_counts = {}
  for i = 1, #s, 1 do
    local letter = string.sub(s, i, i)
    if string.match(letter, "[%a]+") then
      local count = (letter_counts[letter] or 0) + 1
      letter_counts[letter] = count
      table_size = table_size + 1
    end
  end

  local alphabet = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  }
  local is_pangram = true
  for _, letter in ipairs(alphabet) do
    if letter_counts[letter] == nil then is_pangram = false end
  end

  for letter, _ in pairs(letter_counts) do
    if letter_counts[letter] >= alphabet_size then is_pangram = false end
  end
  if table_size < alphabet_size then is_pangram = false end

  return is_pangram
end
