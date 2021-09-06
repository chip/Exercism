local beer = {}

local function bottles(n)
  local number_with_bottle = n.." bottles"

  if n == 0 then
    number_with_bottle = "No more bottles"
  end
  if n == 1 then
    number_with_bottle = "1 bottle"
  end

  return number_with_bottle.." of beer on the wall, "..number_with_bottle:lower().." of beer.\n"
end

local function take_one(n)
  if n == 0 then
    return "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end
  local bottle_count = n - 1
  local bottle_or_bottles = bottle_count == 1 and "1 bottle" or bottle_count.." bottles"
  local one_or_it = n == 1 and "it" or "one"
  local n_or_no_more = n == 1 and "no more bottles" or bottle_or_bottles

  return "Take "..one_or_it.." down and pass it around, "..n_or_no_more.." of beer on the wall.\n"
end

function beer.verse(number)
  return bottles(number)..take_one(number)
end

function beer.sing(start, finish)
  local verse = {}
  finish = finish or 0

  for number=start,finish,-1 do
    local result = bottles(number)..take_one(number)
    table.insert(verse, result)
  end

  return table.concat(verse, "\n")
end

return beer
