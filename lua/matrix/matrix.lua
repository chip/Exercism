local inspect = require('inspect')

return function(s)
  print("s:")
  print(s)
  local mtx = {}

  local i=1
  -- local j=1

  for line in string.gmatch(s, "[^\n]+") do
    print('\n')
    print('line:'..line)
    print('i:'..i)
    -- local r = {}
    mtx[i] = {}
    -- mtx[i][j] = {}
    print(inspect(mtx))
    local j=1

    for element in string.gmatch(line, "[^%s]+") do
      print('element:'..element.."*")
      -- mtx[i][j] = element
      mtx[i][j] = element
      j = j + 1
      -- require 'pl.pretty'.dump(mtx)
      print(inspect(mtx))
    end
    i = i + 1
  end
  print(inspect(mtx))
  -- require 'pl.pretty'.dump(mtx)

  local function row(n)
    print("row n:"..n)
    -- table.sort(mtx)
    -- require 'pl.pretty'.dump(mtx)
    print("inspect mtx")
    print(inspect(mtx))
    local t = {}

    for k,v in ipairs(mtx[n]) do
      print('v = ')
      print(v)
      t[k] = tonumber(v)
      -- table.insert(t, tonumber(v))
    end
    print("inspect t")
    print(inspect(t))
    return t
  end

  local function column(n)
    print("\n")
    print("column n:"..n)
    local t = {}

    -- for k,v in pairs(mtx[n]) do
    for m=1,#mtx do
      -- table.insert(t, tonumber(v))
      t[m] = tonumber(mtx[m][n])
    end
    return t
  end

  return {
    row = row,
    column = column
  }
end
