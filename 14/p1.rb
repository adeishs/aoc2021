#!/usr/bin/env ruby
# frozen_string_literal: true

rule = $stdin.each_line.map(&:chomp)
template = rule.shift(2)[0]
rule = rule.map { |r| r.split(' -> ') }.to_h

10.times do
  new_template = ''
  (0...template.length - 1).each do |i|
    pair = template[i..i + 1]
    new_template += template[i] + rule[pair]
  end
  template = new_template + template[-1]
end

min, max = template.chars
                   .group_by { |v| v }
                   .flat_map { |_, v| v.count }
                   .minmax
puts max - min
