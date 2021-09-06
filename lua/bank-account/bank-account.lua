local BankAccount = {}

function BankAccount:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.current_balance = 0
  self.closed = false
  return o
end

function BankAccount:balance ()
  return self.current_balance
end

function BankAccount:deposit (amount)
  if self.closed then error"Cannot deposit funds into a closed account" end
  if amount <= 0 then error"must be a positive number" end
  self.current_balance = self.current_balance + amount
end

function BankAccount:withdraw (amount)
  if amount <= 0 then error"must be a positive number" end
  if amount > self.current_balance then error"insufficient funds" end
  self.current_balance = self.current_balance - amount
end

function BankAccount:close ()
  self.current_balance = 0
  self.closed = true
end

return BankAccount
