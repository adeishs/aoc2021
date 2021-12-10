#!/usr/bin/env ruby
# frozen_string_literal: true

EXPECTED = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

SCORE = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

def get_err_score(codes)
  expecteds = []
  codes.each do |c|
    if !EXPECTED[c].nil?
      expecteds.unshift(EXPECTED[c])
    elsif c != expecteds.shift
      return nil
    end
  end

  expecteds.reduce(0) { |m, a| 5 * m + SCORE[a] }
end

scores = $stdin.each_line
               .map { |line| get_err_score(line.chomp.split('')) }
               .reject(&:nil?)
               .sort
puts scores[scores.count / 2]
