#!/usr/bin/env ruby
# frozen_string_literal: true

recs = $stdin.each_line.map(&:chomp).map { |line| line.split('') }

line_len = recs[0].count
filtered_recs = recs
(0...line_len).each do |i|
  bs = filtered_recs.map { |rec| rec[i] }
  f = {}
  f[0] = bs.count('0')
  f[1] = bs.count('1')
  b = f[0] > f[1] ? '0' : '1'

  filtered_recs = filtered_recs.select { |rec| rec[i] == b }
  break if filtered_recs.count == 1
end
o = filtered_recs[0].join('')

filtered_recs = recs
(0...line_len).each do |i|
  bs = filtered_recs.map { |rec| rec[i] }
  f = {}
  f[0] = bs.count('0')
  f[1] = bs.count('1')
  b = f[0] > f[1] ? '1' : '0'

  filtered_recs = filtered_recs.select { |rec| rec[i] == b }
  break if filtered_recs.count == 1
end
co2 = filtered_recs[0].join('')

puts o.to_i(2) * co2.to_i(2)
