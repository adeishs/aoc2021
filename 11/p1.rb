#!/usr/bin/env ruby
# frozen_string_literal: true

WIDTH = 10

def c(x, y)
  WIDTH * y + x
end

def in_range(x, y, neigh_x, neigh_y)
  (neigh_y != y || neigh_x != x) &&
    neigh_x.between?(0, WIDTH - 1) &&
    neigh_y.between?(0, WIDTH - 1)
end

octs = $stdin.each_line.map { |line| line.chomp.chars }.flatten.map(&:to_i)
flash_count = 0
100.times do
  flash_octs = []
  octs.map! { |f| f + 1 }
  changed = true
  while changed
    changed = false
    (0...WIDTH).each do |y|
      (0...WIDTH).each do |x|
        i = c(x, y)
        if octs[i] > 9
          octs[i] = 0
          flash_count += 1
          flash_octs.push(i)
          [y - 1, y, y + 1].product([x - 1, x, x + 1])
                           .select { |ny, nx| in_range(x, y, nx, ny) }
                           .each { |ny, nx| octs[c(nx, ny)] += 1 }
          changed = true
          break
        end
        break if changed
      end
    end
  end

  flash_octs.each { |i| octs[i] = 0 }
end

puts flash_count
