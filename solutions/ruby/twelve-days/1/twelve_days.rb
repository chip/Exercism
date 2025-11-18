class TwelveDays
  DAYS = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth].freeze
  VERSES = [
    'a Partridge in a Pear Tree.',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming'
  ].freeze

  def self.song
    song = []
    DAYS.each_with_index do |day, i|
      song << on_the(day)
      song << VERSES[1..i].reverse.join(', ') << ', and ' unless i.zero?
      song << "#{VERSES[0]}\n\n"
    end
    song.join.chomp
  end

  def self.on_the(day)
    "On the #{day} day of Christmas my true love gave to me: "
  end
end
