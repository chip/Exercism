class PhoneNumber
  def self.clean(num)
    num = num.gsub(/[A-Za-z()@:!.+ -]/, '').gsub(/^1/, '')
    num.size == 10 && /[2-9]{1}[0-9]{2}[2-9]{1}[0-9]{6}/.match?(num) ? num : nil
  end
end
