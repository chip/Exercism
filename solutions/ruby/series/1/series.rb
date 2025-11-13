class Series
  def initialize(str)
    raise ArgumentError if str.empty?

    @str = str
  end

  def slices(series)
    raise ArgumentError if series > @str.length

    @str.chars.each_cons(series).entries.map(&:join)
  end
end
