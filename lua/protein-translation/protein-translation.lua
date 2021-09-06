local mapping = {
  AUG = 'Methionine',
  UUU = 'Phenylalanine',
  UUC = 'Phenylalanine',
  UUA = 'Leucine',
  UUG = 'Leucine',
  UCU = 'Serine',
  UCC = 'Serine',
  UCA = 'Serine',
  UCG = 'Serine',
  UAU = 'Tyrosine',
  UAC = 'Tyrosine',
  UGU = 'Cysteine',
  UGC = 'Cysteine',
  UGG = 'Tryptophan',
  UAA = 'STOP',
  UAG = 'STOP',
  UGA = 'STOP',
}

local function translate_codon(codon)
  if not mapping[codon] then error'Invalid codon' end
  return mapping[codon]
end

local function translate_rna_strand(rna_strand)
  local translation = {}

  local last_index = #rna_strand - 2
  for i=1,last_index,3 do
    local codon = rna_strand:sub(i,i+2)
    local protein = mapping[codon]

    if not protein then error'Invalid protein' end

    if protein == 'STOP' then
      break
    end
    table.insert(translation, protein)
  end
  return translation
end

return {
  codon = translate_codon,
  rna_strand = translate_rna_strand
}
