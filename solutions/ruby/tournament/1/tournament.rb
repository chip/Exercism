class Tournament
  def self.tally(input)
    table = lines(input)
            .inject({}) { |memo, line| convert_line(memo, line) }
            .sort_by { |k, v| [-v[:P], k] }.map do |team, h|
              format(line_format, team, *h.values_at(:MP, :W, :D, :L, :P))
            end
    [header, table].join
  end

  def self.lines(input)
    input.chomp.lines
  end

  def self.line_format
    "%-31s|  %s |  %s |  %s |  %s |%3s\n".freeze
  end

  def self.convert_line(memo, line)
    (away, home, outcome) = line.chomp.split(';')
    memo[away] = update_team(memo, away, 'away', outcome)
    memo[home] = update_team(memo, home, 'home', outcome)
    memo
  end

  def self.update_team(memo, team, opponent, outcome)
    h = memo.fetch(team, default_values)
    h = matches_played(h)
    case outcome
    when 'win' then h = opponent == 'away' ? win(h) : loss(h)
    when 'draw' then h = draw(h)
    when 'loss' then h = opponent == 'away' ? loss(h) : win(h)
    end
    h
  end

  def self.matches_played(hsh)
    hsh[:MP] += 1
    hsh
  end

  def self.win(hsh)
    hsh[:W] += 1
    hsh[:P] += 3
    hsh
  end

  def self.loss(hsh)
    hsh[:L] += 1
    hsh
  end

  def self.draw(hsh)
    hsh[:D] += 1
    hsh[:P] += 1
    hsh
  end

  def self.default_values
    { MP: 0, W: 0, D: 0, L: 0, P: 0 }
  end

  def self.header
    "Team                           | MP |  W |  D |  L |  P\n"
  end
end
