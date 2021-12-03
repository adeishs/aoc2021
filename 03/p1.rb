#!/usr/bin/env ruby
# frozen_string_literal: true

recs = $stdin.each_line.map(&:chomp).map { |line| line.split('') }

gamma_str = ""
line_len = recs[0].count
(0...line_len).each do |i|
  bs = recs.map{ |rec| rec[i] }
  b = bs.max_by { |e| bs.count(e) }
  gamma_str += b
end

gamma = gamma_str.to_i(base = 2)
epsilon = gamma ^ ((1 << line_len) - 1)

puts gamma * epsilon
