#!/usr/bin/env ruby
# frozen_string_literal: true

def process(recs, mode)
  rev_mode = (mode.to_i ^ 1).to_s
  filtered_recs = recs
  (0...recs[0].count).each do |i|
    f = %w[0 1].map { |b| [b, filtered_recs.map { |rec| rec[i] }.count(b)] }
               .to_h
    b = f['0'] > f['1'] ? rev_mode : mode

    filtered_recs = filtered_recs.select { |rec| rec[i] == b }
    return filtered_recs[0].join('').to_i(2) if filtered_recs.count == 1
  end
end

recs = $stdin.each_line.map(&:chomp).map { |line| line.split('') }
puts process(recs, '1') * process(recs, '0')
