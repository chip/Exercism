return function(dna)
  local mapping = {G = 'C', C = 'G', T = 'A', A = 'U'}
  local converted = ''

  for i=1,#dna do
    local nucleotide = dna:sub(i,i)
    if nucleotide:match("[GCTA]") then
      converted = converted .. mapping[nucleotide]
    end
  end
  return converted
end
