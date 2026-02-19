class PigLatin
  VOWEL_SOUNDS = /^(a|e|i|o|u|yt|xr)/
  QU_SOUNDS = /^([^aeiou]?qu)(.+)$/
  Y_SOUNDS = /^([^aeiou]+)(y.*)$/
  CONSONANT_SOUNDS = /^([^aeiou]+)(.*)$/

  def self.translate(text)
    text.split.map { |e| pigify(e) }.join(' ')
  end

  def self.pigify(word)
    translated = case word
                 when VOWEL_SOUNDS then word
                 when QU_SOUNDS then word.gsub!(QU_SOUNDS, '\2\1')
                 when Y_SOUNDS then word.gsub!(Y_SOUNDS, '\2\1')
                 when CONSONANT_SOUNDS then word.gsub!(CONSONANT_SOUNDS, '\2\1')
                 end

    "#{translated}ay"
  end
end
