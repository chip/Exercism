class Cipher
  ALPHABET = ('a'..'z').to_a
  A = ALPHABET.first.ord
  Z = ALPHABET.last.ord

  attr_reader :key

  def initialize(key = :noop)
    @key = key == :noop ? 100.times.map { Random.rand(A..Z).chr }.join : key

    raise ArgumentError unless @key.match(/\A[a-z]+\z/)
  end

  def encode(str)
    translate(str, :+)
  end

  def decode(str)
    translate(str, :-)
  end

  private

  def translate(str, op)
    str.chars.map.with_index do |c, i|
      offset = c.ord.public_send(op, ALPHABET.index(key[i]))
      get_char(offset)
    end.join
  end

  def get_char(offset)
    if offset < A
      offset += ALPHABET.size
    elsif offset > Z
      offset = (offset % (Z + 1)) + A
    end
    offset.chr
  end
end
