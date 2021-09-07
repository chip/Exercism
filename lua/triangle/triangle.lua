local triangle = {}

local function sum_of_sides_are_unacceptable(a, b, c)
  return a + b < c or b + c < a or c + a < b
end

local function side_lengths_are_unacceptable(a, b, c)
  return a <= 0 or b <= 0 or c <= 0
end
function triangle.kind(a, b, c)
  if sum_of_sides_are_unacceptable(a, b, c) then error'Input Error' end

  if side_lengths_are_unacceptable(a, b, c) then error'Input Error' end

  if a == b and b == c then
    return "equilateral"
  elseif a == b or b == c or a == c then
    return "isosceles"
  else
    return "scalene"
  end
end

return triangle
