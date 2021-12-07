#!/usr/bin/env ruby
# frozen_string_literal: true

X_SRC, Y_SRC, X_DEST, Y_DEST = (0..3).to_a

freq = {}
$stdin.each_line
      .map { |line| line.chomp.split(/,| -> /).map(&:to_i) }
      .select do |ps|
        ps[X_SRC] == ps[X_DEST] ||
          ps[Y_SRC] == ps[Y_DEST] ||
          (ps[X_SRC] - ps[X_DEST]).abs == (ps[Y_SRC] - ps[Y_DEST]).abs
      end.each do |ps|
  if ps[X_SRC] == ps[X_DEST]
    step = ps[Y_DEST] <=> ps[Y_SRC]
    (ps[Y_SRC]..ps[Y_DEST]).step(step).each do |y|
      freq[ps[X_SRC]] = Hash.new(0) if freq[ps[X_SRC]].nil?
      freq[ps[X_SRC]][y] += 1
    end
  elsif ps[Y_SRC] == ps[Y_DEST]
    step = ps[X_DEST] <=> ps[X_SRC]
    (ps[X_SRC]..ps[X_DEST]).step(step).each do |x|
      freq[x] = Hash.new(0) if freq[x].nil?
      freq[x][ps[Y_SRC]] += 1
    end
  else
    x_step = ps[X_DEST] <=> ps[X_SRC]
    y_step = ps[Y_DEST] <=> ps[Y_SRC]
    x = ps[X_SRC]
    y = ps[Y_SRC]
    (0..(ps[X_DEST] - ps[X_SRC]).abs).each do |_s|
      freq[x] = Hash.new(0) if freq[x].nil?
      freq[x][y] += 1
      x += x_step
      y += y_step
    end
  end
end

num_of_overlaps = 0
freq.each_key do |x|
  num_of_overlaps += freq[x].values.select { |v| v >= 2 }.size
end

puts num_of_overlaps
