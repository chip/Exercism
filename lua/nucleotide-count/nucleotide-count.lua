local DNA = {}

local function parse (s)
  local counts = { A = 0, T = 0, C = 0, G = 0 }
  for i=1,#s do
    local nucleotide = s:sub(i,i)
    if not nucleotide:match("[ATCG]+") then error"Invalid Nucleotide" end
    counts[nucleotide] = tonumber(counts[nucleotide]) + 1
  end
  return counts
end

function DNA:new (strand)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.strand = strand
  self.nucleotideCounts = parse(strand)
  return o
end

function DNA:count (nucleotide)
  if not nucleotide:match("[ATCG]+") then error"Invalid Nucleotide" end
  return self.nucleotideCounts[nucleotide]
end

return DNA
