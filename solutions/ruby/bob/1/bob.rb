class Bob
  def self.hey(remark)
    scrubbed = remark.gsub(/[^\w?]+/, '')
    case scrubbed
    when /^[A-Z]+\?$/
      "Calm down, I know what I'm doing!"
    when /\?$/
      'Sure.'
    when /^[^A-Z]+$/
      'Whatever.'
    when /^[A-Z0-9]+$/
      'Whoa, chill out!'
    when /^\s*$/
      'Fine. Be that way!'
    else
      'Whatever.'
    end
  end
end
