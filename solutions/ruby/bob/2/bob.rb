class Bob
  def self.hey(msg)
    msg = msg.strip
    if shouting?(msg) && question?(msg)
      "Calm down, I know what I'm doing!"
    elsif shouting?(msg)
      'Whoa, chill out!'
    elsif question?(msg)
      'Sure.'
    elsif silent?(msg)
      'Fine. Be that way!'
    else
      'Whatever.'
    end
  end

  def self.shouting?(msg)
    msg == msg.upcase && msg.match(/[A-Z]/)
  end

  def self.question?(msg)
    msg.end_with?('?')
  end

  def self.silent?(msg)
    msg.split.join('').empty?
  end
end
