class EliudsEggs
  def self.egg_count(num)
    num.to_s(2).count('1')
  end
end
