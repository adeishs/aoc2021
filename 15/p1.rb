#!/usr/bin/env ruby
# frozen_string_literal: true

def in_range(x, y, risks)
  x.between?(0, risks[0].count - 1) && y.between?(0, risks.count - 1)
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

    paths.sort! { |a, b| a[0] <=> b[0] }
  end
end

puts calc_min_cost($stdin.each_line.map { |line| line.chomp.chars.map(&:to_i) })
