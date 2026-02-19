class TwoBucket
  attr_reader :bucket_one, :bucket_two, :goal, :start_bucket

  def initialize(bucket_one, bucket_two, goal, start_bucket)
    @bucket_one = bucket_one
    @bucket_two = bucket_two
    @goal = goal
    @start_bucket = start_bucket
  end

  def moves
    result[:moves]
  end

  def goal_bucket
    result[:bucket]
  end

  def other_bucket
    result[:other]
  end

  private

  def result
    @result ||= simulate
  end

  # Simulate moves following the canonical two-bucket algorithm
  def simulate
    if start_bucket == 'one'
      from_capacity = bucket_one
      to_capacity = bucket_two
      from_name = 'one'
      to_name = 'two'
    else
      from_capacity = bucket_two
      to_capacity = bucket_one
      from_name = 'two'
      to_name = 'one'
    end

    from = from_capacity
    to = 0
    moves = 1

    loop do
      # Check goal in either bucket
      return { moves:, bucket: from_name, other: to } if from == goal
      return { moves:, bucket: to_name, other: from } if to == goal

      # Pour from 'from' to 'to'
      transfer = [from, to_capacity - to].min
      from -= transfer
      to += transfer
      moves += 1

      # Check goal after pouring
      return { moves:, bucket: from_name, other: to } if from == goal
      return { moves:, bucket: to_name, other: from } if to == goal

      # Refill or empty buckets as per canonical rules
      if from.zero?
        from = from_capacity
        moves += 1
      end

      if to == to_capacity
        to = 0
        moves += 1
      end
    end
  end
end
