class PigLatin
  VOWELS = %w[a e i o u]
  CONSONANTS = (('a'..'z').to_a - VOWELS).join('|')
  AEIOU_YT_XR = /^(#{VOWELS.join('|')}|yt|xr).+$/
  QU = /^(#{CONSONANTS}{1})?(qu)(.+)$/
  Y = /^([#{CONSONANTS}]+)y(.*)$/
  NO_VOWELS = /^([#{CONSONANTS}]+)(.*)$/

  def self.translate(str)
    str.split.map { |e| pigify(e) }.join(' ')
  end

  def self.pigify(word)
    return "#{word}ay" if AEIOU_YT_XR.match(word)

    if md = QU.match(word)
      "#{md[3]}#{md[1] || ''}#{md[2]}ay"

    elsif md = Y.match(word)
      "y#{md[2]}#{md[1]}ay"

    elsif md = NO_VOWELS.match(word)
      "#{md[2]}#{md[1]}ay"
    end
  end
end
