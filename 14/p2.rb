#!/usr/bin/env ruby
# frozen_string_literal: true

rule = $stdin.each_line.map(&:chomp)
template = rule.shift(2)[0]
rule = rule.map { |r| r.split(' -> ') }.to_h

tally = Hash[*(0...template.length - 1).map { |i| template[i..i + 1] }
                                       .group_by { |v| v }
                                       .flat_map { |k, v| [k, v.count] }]
40.times do
  new_tally = Hash.new(0)
  tally.each_key do |pair|
    pre, post = pair.chars
    new_tally[pre + rule[pair]] += tally[pair]
    new_tally[rule[pair] + post] += tally[pair]
  end

  tally = new_tally
end

char_tally = Hash.new(0)
tally.each { |pair, freq| char_tally[pair[0]] += freq }
char_tally[template[-1]] += 1

min, max = char_tally.values.minmax
puts max - min
