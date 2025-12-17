class Crypto
  attr_reader :plaintext, :size

  def initialize(plaintext)
    @plaintext = plaintext.downcase.gsub(/[^a-z0-9]/, '')
    @size = @plaintext.size
  end

  def ciphertext
    all_columns.join(' ')
  end

  private

  def columns
    _, @columns = combos.min_by(&:last)
    @columns
  end

  def combos
    @combos ||= (1..size).to_a.repeated_combination(2).select do |r, c|
      c - r <= 1 && c >= r && r * c >= size
    end
  end

  def all_columns
    return [] unless columns

    (0...columns).to_a.map { |i| chars_by_column(i) }
  end

  def chars_by_column(idx)
    rectangle.map { |row| row[idx] }.join
  end

  def rectangle
    plaintext.scan(/.{1,#{columns}}/).map { |s| "%-#{columns}s" % s }
  end
end
