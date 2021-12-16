#!/usr/bin/env ruby
# frozen_string_literal: true

def in_range(x, y, risks)
  x.between?(0, risks[0].count - 1) && y.between?(0, risks.count - 1)
end

def min_idx(paths)
  return nil if paths.empty?

  idx = 0
  min_cost = paths[0][0]
  (1...paths.count).each do |i|
    curr_cost = paths[i][0]
    if curr_cost < min_cost
      min_cost = curr_cost
      idx = i
    end
  end

  idx
end

def calc_min_cost(risks)
  paths = [[0, 0, 0]]
  costs = Array.new(risks.count) { Array.new(risks[0].count, 999_999_999) }

  loop do
    cost, x, y = paths.shift
    return cost if x == risks[0].count - 1 && y == risks.count - 1

    [
      [x + 1, y],
      [x, y + 1],
      [x - 1, y],
      [x, y - 1]
    ].select { |nx, ny| in_range(nx, ny, risks) }
      .each do |nx, ny|
      new_cost = cost + risks[ny][nx]
      if new_cost < costs[ny][nx]
        costs[ny][nx] = new_cost
        paths.push([new_cost, nx, ny])
      end
    end

    idx = min_idx(paths)
    paths.unshift(paths.delete_at(idx)) if (idx || 0) > 0
  end
end

def incr(r, i)
  (r + i) % 9 + 1
end

def expand_map(risks)
  x_len = risks[0].count
  (0...risks.count).each do |y|
    (0..3).each do |x|
      risks[y] += risks[y][0...x_len].map { |r| incr(r, x) }
    end
  end

  y_len = risks.count
  (0..3).each do |y|
    risks[0...y_len].each do |cols|
      risks.push(cols.map { |r| incr(r, y) })
    end
  end

  risks
end

puts calc_min_cost(
  expand_map($stdin.each_line.map { |line| line.chomp.chars.map(&:to_i) })
)
