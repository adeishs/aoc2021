#!/usr/bin/env ruby
# frozen_string_literal: true

PADDER = 10

points = $stdin.each_line
               .map do |line|
  [PADDER] + line.chomp.split('').map(&:to_i) + [PADDER]
end
pads = Array.new(points[0].count, PADDER)
points = (points << pads << pads).rotate(-1)
risk_levels = []
(1...points.count - 1).each do |y|
  (1...points[y].count - 1).each do |x|
    if [points[y - 1][x], points[y + 1][x], points[y][x - 1], points[y][x + 1]]
       .all? { |p| p > points[y][x] }
      risk_levels.append(points[y][x] + 1)
    end
  end
end
puts risk_levels.reduce(:+)
