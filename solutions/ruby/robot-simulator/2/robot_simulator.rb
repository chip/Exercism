class Robot
  DIRECTIONS = %i[east west north south].freeze

  attr_reader :coordinates, :bearing

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    @bearing = direction
  end

  def turn_right
    @bearing = case @bearing
               when :east then :south
               when :west then :north
               when :north then :east
               when :south then :west
               end
  end

  def turn_left
    @bearing = case @bearing
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
    @coordinates = case @bearing
                   when :east then [x + 1, y]
                   when :west then [x - 1, y]
                   when :north then [x, y + 1]
                   when :south then [x, y - 1]
                   end
  end
end

class Simulator
  COMMANDS = { 'R' => :turn_right, 'L' => :turn_left, 'A' => :advance }.freeze

  def instructions(str)
    str.chars.map(&COMMANDS)
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, commands)
    instructions(commands).each { |cmd| robot.public_send(cmd.to_s) }
  end
end
