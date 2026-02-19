class Raindrops
  SOUNDS = [
    [3, 'Pling'],
    [5, 'Plang'],
    [7, 'Plong']
  ].freeze

  def self.convert(num)
    result = SOUNDS.each_with_object([]) do |sound, memo|
      memo << sound.last if (num % sound.first).zero?
    end.join
    result.empty? ? num.to_s : result.concat
  end
end
