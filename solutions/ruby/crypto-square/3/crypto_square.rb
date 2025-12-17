class Crypto
  attr_reader :text, :columns

  def initialize(plaintext)
    @text = plaintext.downcase.gsub(/[^a-z0-9]/, '')
    @columns = Math.sqrt(@text.size).ceil
  end

  def ciphertext
    return [] unless columns

    (0...columns).map { |i| chars_by_column(i) }.join(' ')
  end

  private

  def chars_by_column(idx)
    rectangle.map { |row| row[idx] }.join
  end

  def rectangle
    text.scan(/.{1,#{columns}}/).map { |s| "%-#{columns}s" % s }
  end
end
