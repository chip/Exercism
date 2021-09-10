local animals = { "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" }

local function swallowedUntil(n, answer)
  if n == 1 then
    return answer
  else
    if n == 3 then
      answer = answer .. "She swallowed the %s to catch the %s that wriggled and jiggled and tickled inside her%s"
    else
      answer = answer .. "She swallowed the %s to catch the %s%s"
    end
    answer = answer:format(animals[n], animals[n-1], ".\n")

    return swallowedUntil(n - 1, answer)
  end
end

local function swallowed(n)
  return swallowedUntil(n, "")
end

local function first(n)
  local know = "I know an old lady who swallowed a %s."
  return know:format(animals[n])
end

local function second(n)
  local wriggled = "%s wriggled and jiggled and tickled inside her."
  if n == 2 then
    return wriggled:format("It")
  elseif n == 3 then
    return "How absurd to swallow a bird!"
  elseif n == 4 then
    local s = "Imagine that, to swallow a %s!"
    return s:format(animals[n])
  elseif n == 5 then
    local s = "What a hog, to swallow a dog!"
    return s:format(animals[n])
  elseif n == 6 then
    local s = "Just opened her throat and swallowed a goat!"
    return s:format(animals[n])
  elseif n == 7 then
    local s = "I don't know how she swallowed a cow!"
    return s:format(animals[n])
  elseif n == 8 then
    return ""
  else
    return wriggled:format("that")
  end
end

local function last(n)
  if n == #animals then
    return "She's dead, of course!\n"
  else
    return "I don't know why she swallowed the fly. Perhaps she'll die."
  end
end

local function verse(which)
  local buffer = first(which) .. "\n"
  if which > 1 then
    if which < 8 then
      buffer = buffer .. second(which) .. "\n"
      buffer = buffer .. swallowed(which)
    end
  end
  buffer = buffer .. last(which)
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
