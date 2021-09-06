return function(number)
  if number <= 0 then error'Only positive numbers are allowed' end
  if number == 1 then return 0 end

  local count = 0

  local function is_even(n)
    return n % 2 == 0
  end

  local function collatz(n)
    count = count + 1

    local num = is_even(n) and (n / 2) or ((n * 3) + 1)

    if num == 1 then
      return count
    else
      return collatz(num)
    end
  end

  return collatz(number)
end
