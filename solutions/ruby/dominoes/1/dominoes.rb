class Dominoes
  def self.chain?(dominoes)
    return true if dominoes.empty?
    return dominoes.first.first == dominoes.first.last if dominoes.size == 1

    # Degree parity check
    counts = dominoes.flatten.tally
    return false if counts.values.any?(&:odd?)

    # Build adjacency list (multigraph)
    adj = Hash.new { |h, k| h[k] = [] }
    dominoes.each_with_index do |(a, b), i|
      adj[a] << [b, i]
      adj[b] << [a, i]
    end

    used = Array.new(dominoes.size, false)

    # Pick a starting node with edges
    start = adj.keys.first
    stack = [start]
    path = []

    # Hierholzer's algorithm
    until stack.empty?
      v = stack.last

      adj[v].pop while adj[v].any? && used[adj[v].last[1]]

      if adj[v].empty?
        path << stack.pop
      else
        u, edge_id = adj[v].pop
        next if used[edge_id]

        used[edge_id] = true
        stack << u
      end
    end

    # All edges must be used
    used.all?
  end
end
