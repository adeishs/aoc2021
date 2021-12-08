#!/usr/bin/env ruby
# frozen_string_literal: true

def decode(code)
  input, output = code.split(' | ')
  in_segs = input.split(' ')
                 .map { |c| c.split('').sort }
                 .sort { |a, b| b.count <=> a.count }
  seg_map = {}
  rev_map = Array.new(10)
  [[9, 1], [8, 7], [7, 4], [0, 8]].each do |i, m|
    chars = in_segs.delete_at(i)
    seg_map[chars.join('')] = m
    rev_map[m] = chars
  end

  [[4, 9], [7, 0]].each do |sub, sup|
    i = in_segs.find_index { |c| c & rev_map[sub] == rev_map[sub] }
    chars = in_segs.delete_at(i)
    seg_map[chars.join('')] = sup
    rev_map[sup] = chars
  end

  chars = in_segs.delete_at(0)
  seg_map[chars.join('')] = 6
  rev_map[6] = chars

  sub, sup = [7, 3]
  i = in_segs.find_index { |c| c & rev_map[sub] == rev_map[sub] }
  chars = in_segs.delete_at(i)
  seg_map[chars.join('')] = sup
  rev_map[sup] = chars

  sub, sup = [5, 6]
  i = in_segs.find_index { |c| c & rev_map[sup] == c }
  chars = in_segs.delete_at(i)
  seg_map[chars.join('')] = sub

  chars = in_segs.delete_at(0)
  seg_map[chars.join('')] = 2

  output.split(' ')
        .map { |s| seg_map[s.split('').sort.join('')].to_s }
        .join('')
        .to_i
end

puts $stdin.each_line.map { |line| decode(line.chomp) }.reduce(&:+)
