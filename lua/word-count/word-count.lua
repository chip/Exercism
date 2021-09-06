local function word_count(s)
  local words = {}

  local function sanitize(current_token)
    local word = current_token:lower()

    word = word:gsub("^'", "")
    word = word:gsub("'$", "")

    return word
  end

  for token in s:gmatch("[%w']+") do
    local word = sanitize(token)

    words[word] = words[word] and (words[word] + 1) or 1
  end

  return words
end

return {
  word_count = word_count,
}
