module Port
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city.upcase.slice(0, 4).to_sym
  end

  def self.get_terminal(ship_identifier)
    %w[OIL GAS].include?(ship_identifier.to_s.slice(0, 3)) ? :A : :B
  end
end
