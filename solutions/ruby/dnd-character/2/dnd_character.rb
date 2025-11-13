class DndCharacter
  ABILITIES = %i[strength dexterity constitution intelligence wisdom charisma].freeze
  attr_reader(*ABILITIES)

  def self.modifier(value)
    (value - 10) / 2
  end

  def initialize
    ABILITIES.each { |a| instance_variable_set("@#{a}", assign_score) }
  end

  def hitpoints
    10 + self.class.modifier(constitution)
  end

  private

  def assign_score
    die_rolls.max(3).sum
  end

  def die_rolls
    4.times.map { rand(1..6) }
  end
end
