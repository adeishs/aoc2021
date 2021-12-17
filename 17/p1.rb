#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_input(inp)
  inp.split(': ')[1].split(', ').map do |t|
    axis, range = t.split('=')
    min, max = range.split('..').map(&:to_i).minmax
    [axis.to_sym, { min: min, max: max }]
  end.to_h
end

def calc_min_vx(target)
  vx = 0
  loop do
    dx = vx * (vx + 1) / 2
    return vx if dx.between?(target[:x][:min], target[:x][:max])
    return nil if dx > target[:x][:max]

    vx += 1
  end
end

def calc_dy(target, vx, vy)
  dx = 0
  dy = 0
  max_dy = 0
  loop do
    dx += vx
    dy += vy
    max_dy = [dy, max_dy].max
    return max_dy if dy < target[:y][:min]

    vx -= 1 if vx.positive?
    vy -= 1
  end
end

def calc_max_dy(target, vx)
  vy = vx
  max = vy
  loop do
    curr = calc_dy(target, vx, vy)
    max = [curr, max].max
    vy += 1
    return max if vy >= target[:y][:min].abs
  end
end

target = parse_input($stdin.gets.chomp)
puts calc_max_dy(target, calc_min_vx(target))
