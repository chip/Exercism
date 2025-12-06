class Atbash
  LOOKUP = ('a'..'z').to_a.zip(('a'..'z').to_a.reverse).to_h

  def self.encode(plaintext)
    plaintext.gsub(/[\s,.]/, '')
             .chars
             .map { |c| LOOKUP.fetch(c.downcase, c) }
             .join
             .scan(/.{1,5}/)
             .join(' ')
  end

  def self.decode(ciphertext)
    ciphertext.gsub(/\s/, '')
              .chars
              .map { |c| LOOKUP.fetch(c.downcase, c) }
              .join
  end
end
