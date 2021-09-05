return function(s)
  local mtx = {}
  local i=1

  for line in string.gmatch(s, "[^\n]+") do
    mtx[i] = {}
    local j=1

    for element in string.gmatch(line, "[^%s]+") do
      mtx[i][j] = element
      j = j + 1
    end
    i = i + 1
  end

  local function row(n)
    local t = {}

    for k,v in pairs(mtx[n]) do
      t[k] = tonumber(v)
    end

    return t
  end

  local function column(n)
    local t = {}

    for m=1,#mtx do
      t[m] = tonumber(mtx[m][n])
    end

    return t
  end

  return {
    row = row,
    column = column
  }
end
