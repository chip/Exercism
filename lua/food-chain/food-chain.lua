local animals = { "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" }
local phrases = {
  "that wriggled and jiggled and tickled inside her.",
  "It wriggled and jiggled and tickled inside her.",
  "How absurd to swallow a bird!",
  "Imagine that, to swallow a %s!",
  "What a hog, to swallow a dog!",
  "Just opened her throat and swallowed a goat!",
  "I don't know how she swallowed a cow!",
}

local function swallowedUntil(n, answer)
  if n == 1 then
    return answer
  else
    local s = "She swallowed the %s to catch the %s%s"
    if n == 3 then
      s = "She swallowed the %s to catch the %s that wriggled and jiggled and tickled inside her%s"
    end
    answer = answer .. s:format(animals[n], animals[n-1], ".\n")

    return swallowedUntil(n - 1, answer)
  end
end

local function swallowed_phrases(n)
  return swallowedUntil(n, "")
end

local function first_phrase(n)
  local know = "I know an old lady who swallowed a %s."
  return know:format(animals[n])
end

local function second_phrase(n)
  if n == 8 then
    return ""
  else
    return phrases[n]:format(animals[n])
  end
end

local function last_phrase(n)
  if n == #animals then
    return "She's dead, of course!\n"
  else
    return "I don't know why she swallowed the fly. Perhaps she'll die."
  end
end

local function verse(which)
  local buffer = first_phrase(which) .. "\n"
  if which > 1 and which < 8 then
    buffer = buffer .. second_phrase(which) .. "\n"
    buffer = buffer .. swallowed_phrases(which)
  end
  buffer = buffer .. last_phrase(which)
  if which < 8 then
    buffer = buffer .. "\n"
  end
  return buffer
end

local function verses(from, to)
  local buffer = ""
  for n=from, to do
    buffer = buffer .. verse(n) .. "\n"
  end
  return buffer
end

local function sing()
  return verses(1, 8)
end

return {
  verse = verse,
  verses = verses,
  sing = sing
}
