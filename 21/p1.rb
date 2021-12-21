#!/usr/bin/env ruby
# frozen_string_literal: true

def other_player(player)
  3 - player
end

DIE_VALS = (1..100).to_a

pos = $stdin.each_line.map do |l|
  l.gsub('Player ', '')
   .gsub('starting position: ', '')
   .split(' ')
   .map(&:to_i)
end.to_h

score = Hash.new(0)

i = 0
num_of_rolls = 0
player = 1
winner = nil
until winner
  rolls_sum = (i...i + 3).map { |d| DIE_VALS[d % 100] }.reduce(:+)
  num_of_rolls += 3
  i = (i + 3) % 100

  pos[player] = 1 + (pos[player] - 1 + rolls_sum) % 10
  score[player] += pos[player]

  (1..2).each do |c|
    if score[player] >= 1000
      winner = c
      break
    end
  end

  player = other_player(player)
end

puts num_of_rolls * score[other_player(winner)]