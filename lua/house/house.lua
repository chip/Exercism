local house = {}

local phrases = {
  { noun = 'house', verb = 'Jack built.' },
  { noun = 'malt', verb = 'lay in' },
  { noun = 'rat', verb = 'ate' },
  { noun = 'cat', verb = 'killed' },
  { noun = 'dog', verb = 'worried' },
  { noun = 'cow with the crumpled horn', verb = 'tossed' },
  { noun = 'maiden all forlorn', verb = 'milked' },
  { noun = 'man all tattered and torn', verb = 'kissed' },
  { noun = 'priest all shaven and shorn', verb = 'married' },
  { noun = 'rooster that crowed in the morn', verb = 'woke' },
  { noun = 'farmer sowing his corn', verb = 'kept' },
  { noun = 'horse and the hound and the horn', verb = 'belonged to' },
}

house.verse = function(which)
  local buffer = {}
  for i=which,1,-1 do
    local phrase = phrases[i]
    local separator = i == 1 and ' ' or '\n'
    table.insert(buffer, 'the '..phrase.noun..separator..'that '..phrase.verb)
  end
  return 'This is '..table.concat(buffer, ' ')
end

house.recite = function()
  local buffer = {}
  for i=1,#phrases do
    table.insert(buffer, house.verse(i))
  end
  return table.concat(buffer, '\n')
end

return house
