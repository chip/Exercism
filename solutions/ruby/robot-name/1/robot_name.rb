class Robot
  LETTERS = ('A'..'Z').to_a.freeze

  @available_names = nil

  class << self
    attr_accessor :available_names
  end

  def self.forget
    self.available_names = nil
  end

  def initialize
    @name = self.class.next_name
  end

  def reset
    @name = self.class.next_name
  end

  attr_reader :name

  def self.build_name_list
    names = []
    LETTERS.each do |a|
      LETTERS.each do |b|
        1000.times do |n|
          names << "#{a}#{b}#{format('%03d', n)}"
        end
      end
    end
    names.shuffle!
    names
  end

  def self.next_name
    self.available_names ||= build_name_list
    raise 'No more names available' if available_names.empty?

    available_names.pop
  end
end
