class Atbash
  ALPHABET = ('a'..'z').to_a.join

  def self.encode(text)
    decode(text).scan(/.{1,5}/).join(' ')
  end

  def self.decode(text)
    text.downcase.gsub(/\W/, '').tr(ALPHABET, ALPHABET.reverse)
  end
end
