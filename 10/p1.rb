#!/usr/bin/env ruby
# frozen_string_literal: true

EXPECTED = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

SCORE = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

def get_err_score(codes)
  expecteds = []
  codes.each do |c|
    if !EXPECTED[c].nil?
      expecteds.push(EXPECTED[c])
    elsif c != expecteds.pop
      return SCORE[c]
    end
  end

  0
end

puts $stdin.each_line
           .map { |line| get_err_score(line.chomp.chars) }.reduce(:+)
