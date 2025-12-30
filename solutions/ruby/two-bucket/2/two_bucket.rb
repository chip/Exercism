class Bucket < Struct.new(:name, :size, :level); end

class TwoBucket
  attr_reader :moves, :goal_bucket, :other_bucket

  def initialize(size1, size2, target, fill_first)
    a = Bucket.new('one', size1, 0)
    b = Bucket.new('two', size2, 0)
    a, b = b, a if fill_first == 'two'

    0.step do |i|
      if a.level == target || b.level == target
        a, b = b, a if b.level == target
        @goal_bucket = a.name
        @other_bucket = b.level
        @moves = i
        return
      elsif a.level == 0
        a.level = a.size
      elsif b.size == target
        b.level = b.size
      elsif b.level == b.size
        b.level = 0
      else
        pour = [a.level, b.size - b.level].min
        a.level -= pour
        b.level += pour
      end
    end
  end
end
