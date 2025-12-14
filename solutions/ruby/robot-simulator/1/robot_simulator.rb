class Robot
  DIRECTIONS = %i[east west north south].freeze

  attr_reader :coordinates

  def initialize
    @direction = nil
  end

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    @direction = direction
  end

  def turn_right
    @direction = case @direction
                 when :east then :south
                 when :west then :north
                 when :north then :east
                 when :south then :west
                 end
  end

  def turn_left
    @direction = case @direction
                 when :east then :north
                 when :west then :south
                 when :north then :west
                 when :south then :east
                 end
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def advance
    x, y = @coordinates
    @coordinates = case @direction
                   when :east then [x + 1, y]
                   when :west then [x - 1, y]
                   when :north then [x, y + 1]
                   when :south then [x, y - 1]
                   end
  end

  def bearing
    @direction
  end
end

class Simulator
  def instructions(str)
    str.chars.map do |s|
      case s
      when 'R' then :turn_right
      when 'L' then :turn_left
      when 'A' then :advance
      end
    end
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, sequence)
    instructions(sequence).each { |cmd| robot.public_send(cmd.to_s) }
  end
end
