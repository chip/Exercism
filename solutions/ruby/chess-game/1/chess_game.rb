module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    RANKS.to_a.include?(rank) && FILES.to_a.include?(file)
  end

  def self.nickname(first_name, last_name)
    "#{first_name[0..1]}#{last_name[-2..]}".upcase
  end

  def self.move_message(first_name, last_name, square)
    rank = square[1].to_i
    file = square[0]
    if valid_square?(rank, file)
      "#{nickname(first_name, last_name)} moved to #{square}"
    else
      "#{nickname(first_name, last_name)} attempted to move to #{square}, but that is not a valid square"
    end
  end
end
