#!/usr/bin/env ruby
# frozen_string_literal: true

freq = {}
$stdin.each_line
  .map { |line| line.chomp.split(/,| \-> /).map(&:to_i) }
  .select { |ps| ps[0] == ps[2] || ps[1] == ps[3] }
  .each do |ps|
 
  if ps[0] == ps[2]
    step = ps[1] > ps[3] ? -1 : 1
    (ps[1]..ps[3]).step(step).each do |y|
      freq[ps[0]] = Hash.new(0) if freq[ps[0]].nil?
      freq[ps[0]][y] += 1
    end
  elsif ps[1] == ps[3]
    step = ps[0] > ps[2] ? -1 : 1
    (ps[0]..ps[2]).step(step).each do |x|
      freq[x] = Hash.new(0) if freq[x].nil?
      freq[x][ps[1]] += 1
    end
  end
end

num_of_overlaps = 0
freq.keys.each do |x|
  num_of_overlaps += freq[x].values.select { |v| v >= 2 }.size
end

puts num_of_overlaps
