class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    @line.strip.sub(/\[(ERROR|INFO|WARNING)\]:\s*/, '')
  end

  def log_level
    @line.strip
         .match(/\[([^\]]+)\]:.*$/)
         .captures
         .first
         .downcase
  end

  def reformat
    %{#{message} (#{log_level})}
  end
end
