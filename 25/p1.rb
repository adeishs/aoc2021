#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

def parse_map(map)
  es = Set.new
  ss = Set.new

  height = map.count
  width = map[0].length

  (0...height).each do |y|
    (0...width).each do |x|
      case map[y][x]
      when '>'
        es.add([x, y])
      when 'v'
        ss.add([x, y])
      end
    end
  end

  [es, ss, width, height]
end

es, ss, width, height = parse_map($stdin.each_line.map(&:chomp))

finished = false
step = 1
until finished
  curr_es = Set.new
  curr_ss = Set.new

  es.each do |p|
    x, y = p
    nx = (x + 1) % width
    if es.member?([nx, y]) || ss.member?([nx, y])
      curr_es.add(p)
    else
      curr_es.add([nx, y])
    end
  end 

  ss.each do |p|
    x, y = p
    ny = (y + 1) % height
    if curr_es.member?([x, ny]) || ss.member?([x, ny])
      curr_ss.add(p)
    else
      curr_ss.add([x, ny])
    end
  end

  if es == curr_es && ss == curr_ss
    finished = true
  else
    step += 1
    es = curr_es
    ss = curr_ss
  end
end

puts step
