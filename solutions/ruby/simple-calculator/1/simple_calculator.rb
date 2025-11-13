class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation unless ALLOWED_OPERATIONS.include?(operation)
    raise ArgumentError unless first_operand.instance_of?(Integer)
    raise ArgumentError unless second_operand.instance_of?(Integer)

    equation = "#{first_operand} #{operation} #{second_operand}"
    "#{equation} = #{eval(equation)}"
  rescue ZeroDivisionError
    'Division by zero is not allowed.'
  end
end
