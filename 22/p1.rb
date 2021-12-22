#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_input(line)
  val_str, coord_str = line.chomp.split(' ')
  val = { 'on' => 1, 'off' => 0 }[val_str]

  coord_range = Hash[
    *coord_str.split(',')
              .map { |coord| coord.split('=') }
              .flat_map do |axis, range|
      [
        axis.to_sym, range.split('..').map(&:to_i)
      ]
    end
  ]
  [val, coord_range]
end

cubes = {}
$stdin.each_line do |line|
  val, coord_range = parse_input(line)
  ([coord_range[:x][0], -50].max..[coord_range[:x][1], 50].min).each do |x|
    cubes[x] ||= {}
    ([coord_range[:y][0], -50].max..[coord_range[:y][1], 50].min).each do |y|
      cubes[x][y] ||= {}
      ([coord_range[:z][0], -50].max..[coord_range[:z][1], 50].min).each do |z|
        cubes[x][y][z] ||= 0
        cubes[x][y][z] = val
      end
    end
  end
end
cnt = 0
cubes.each_key do |x|
  cubes[x].each_key do |y|
    cubes[x][y].each_key do |z|
      cnt += cubes[x][y][z]
    end
  end
end
puts cnt
