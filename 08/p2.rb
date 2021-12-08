#!/usr/bin/env ruby
# frozen_string_literal: true

def find_idx(in_segs, subset)
  in_segs.find_index { |c| c & subset == subset }
end

def decode(code)
  input, output = code.split(' | ')
  in_segs = input.split(' ')
                 .map { |c| c.chars.sort }
                 .sort { |a, b| b.count <=> a.count }
  seg_map = {}
  rev_map = Array.new(10)
  [[9, 1], [8, 7], [7, 4], [0, 8]].each do |i, m|
    rev_map[m] = in_segs.delete_at(i)
    seg_map[rev_map[m].join] = m.to_s
  end

  [[4, 9], [7, 0]].each do |sub, sup|
    rev_map[sup] = in_segs.delete_at(find_idx(in_segs, rev_map[sub]))
    seg_map[rev_map[sup].join] = sup.to_s
  end

  i = 6
  rev_map[i] = in_segs.delete_at(0)
  seg_map[rev_map[i].join] = i

  sub, sup = [7, 3]
  rev_map[sup] = in_segs.delete_at(find_idx(in_segs, rev_map[sub]))
  seg_map[rev_map[sup].join] = sup.to_s

  sub, sup = [5, 6]
  i = in_segs.find_index { |c| c & rev_map[sup] == c }
  seg_map[in_segs.delete_at(i).join] = sub.to_s

  seg_map[in_segs[0].join] = '2'

  output.split(' ')
        .map { |s| seg_map[s.chars.sort.join] }
        .join
        .to_i
end

puts $stdin.each_line
           .map { |line| decode(line.chomp) }
           .reduce(&:+)
