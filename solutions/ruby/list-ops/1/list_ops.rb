class ListOps
  def self.arrays(args)
    return 0 if args.empty?

    count = 0
    until args.empty?
      args.shift
      count += 1
    end
    count
  end

  def self.reverser(args)
    return [] if args.empty?

    reversed = []
    reversed << args.pop until args.empty?
    reversed
  end

  def self.concatter(*args)
    args.each_with_object([]) do |a, memo|
      a.each { |ele| memo << ele }
    end
  end

  def self.mapper(args, &block)
    return [] if args.empty?

    memo = []
    args.each { |arg| memo << block.call(arg) }
    memo
  end

  def self.filterer(args, &block)
    return [] if args.empty?

    memo = []
    args.each { |arg| memo << arg if block.call(arg) }
    memo
  end

  def self.sum_reducer(args)
    return 0 if args.empty?

    sum = 0
    args.each { |arg| sum += arg }
    sum
  end

  def self.factorial_reducer(args)
    return 1 if args.empty?

    sum = 1
    args.each { |arg| sum *= arg }
    sum
  end
end
