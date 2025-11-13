class DndCharacter
  attr_reader :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :hitpoints

  def self.modifier(value)
    (value - 10) / 2
  end

  def initialize
    @strength = set_ability
    @dexterity = set_ability
    @constitution = set_ability
    @intelligence = set_ability
    @wisdom = set_ability
    @charisma = set_ability
    @hitpoints = 10 + DndCharacter.modifier(constitution)
  end

  private

  def set_ability
    die_values.max(3).sum
  end

  def die_values
    values = []
    4.times { values.push(roll_die) }
    values
  end

  def roll_die
    Random.new.rand(1..6)
  end
end
