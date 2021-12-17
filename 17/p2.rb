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
count = 0
(1..target[:x][:max]).each do |tx|
  (target[:y][:min]...target[:x][:max] - target[:y][:max]).each do |ty|
    dx = 0
    dy = 0
    vx = tx
    vy = ty
    while vx > 0 || dy > target[:y][:min] do
      dx += vx
      dy += vy
      vx -= 1 if vx.positive?
      vy -= 1
      if dx.between?(target[:x][:min], target[:x][:max]) &&
        dy.between?(target[:y][:min], target[:y][:max])
        count += 1
        break
      end
    end
  end
end
puts count
