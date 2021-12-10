#!/usr/bin/env ruby
# frozen_string_literal: true

PADDER = 9

points = $stdin.each_line
               .map do |line|
  [PADDER] + line.chomp.split('').map(&:to_i) + [PADDER]
end
pads = Array.new(points[0].count, PADDER)
points = (points << pads << pads).rotate(-1)
lows = []
(1...points.count - 1).each do |y|
  (1...points[y].count - 1).each do |x|
    if [points[y - 1][x], points[y + 1][x], points[y][x - 1], points[y][x + 1]]
       .all? { |p| p > points[y][x] }
      lows.append([y, x])
    end
  end
end

basin_sizes = []
visited = Array.new(points.count) { Array.new(points[0].count, false) }
lows.each do |low|
  low_y, low_x = low
  next if visited[low_y][low_x]

  basin_size = 0
  to_visits = [low]

  loop do
    break if to_visits.empty?

    y, x = to_visits.shift
    next if points[y][x] == 9 || visited[y][x]

    visited[y][x] = true
    basin_size += 1

    to_visits.append([y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1])
  end

  basin_sizes.append(basin_size)
end

puts basin_sizes.sort { |a, b| b <=> a }[0..2].reduce(:*)
