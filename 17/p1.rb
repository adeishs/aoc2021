#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_input(inp)
  inp.split(': ')[1].split(', ').map do |t|
    axis, range = t.split('=')
    min, max = range.split('..').map(&:to_i).minmax
    [axis.to_sym, { min: min, max: max }]
  end.to_h
end

target = parse_input($stdin.gets.chomp)
max_height = target[:y][:min]
(1..target[:x][:max]).each do |tx|
  (target[:y][:min]...target[:x][:max] - target[:y][:max]).each do |ty|
    dx = 0
    dy = 0
    vx = tx
    vy = ty
    height = 0
    while vx.positive? || dy > target[:y][:min]
      dx += vx
      dy += vy
      height = [height, dy].max
      vx -= 1 if vx.positive?
      vy -= 1
      next unless dx.between?(target[:x][:min], target[:x][:max]) &&
                  dy.between?(target[:y][:min], target[:y][:max])

      max_height = [max_height, height].max
      break
    end
  end
end
puts max_height
