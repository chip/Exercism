local house = {}

house.phrases = {
  [[]],
  [[the malt
that lay in]],
  [[the rat
that ate]],
  [[the cat
that killed]],
  [[the dog
that worried]],
  [[the cow with the crumpled horn
that tossed]],
  [[the maiden all forlorn
that milked]],
  [[the man all tattered and torn
that kissed]],
  [[the priest all shaven and shorn
that married]],
  [[the rooster that crowed in the morn
that woke]],
  [[the farmer sowing his corn
that kept]],
  [[the horse and the hound and the horn
that belonged to]],
}

house.verse = function(which)
  local buffer = {}

  for i=which,1,-1 do
    table.insert(buffer, house.phrases[i])
  end
  local result = 'This is '..table.concat(buffer, ' ')..'the house that Jack built.'
  return result
end

house.recite = function()
  local buffer = {}
  for i=1,#house.phrases do
    table.insert(buffer, house.verse(i))
  end
  return table.concat(buffer, '\n')
end

return house
