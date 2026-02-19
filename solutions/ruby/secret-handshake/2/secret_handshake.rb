class SecretHandshake
  ACTIONS = [
    'wink',            # 1 (00001)
    'double blink',    # 2 (00010)
    'close your eyes', # 4 (00100)
    'jump'             # 8 (01000)
  ]

  def initialize(mask)
    @mask = format('%05b', mask).to_i(2)
    @reverse = format('%05b', 16).to_i(2)
  end

  def commands
    enabled?(@reverse) ? actions.reverse : actions
  end

  private

  def actions
    @actions ||= ACTIONS.each_with_index.filter_map do |action, index|
      action if enabled?(1 << index)
    end
  end

  def enabled?(expr)
    (@mask & expr).nonzero?
  end
end
