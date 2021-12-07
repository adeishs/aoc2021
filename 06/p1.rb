#!/usr/bin/env ruby
# frozen_string_literal: true

NEW_FISH_STATE = 8
OLD_FISH_RESET_STATE = 6

fish = $stdin.gets.chomp.split(',').map(&:to_i)

80.times do
  num_of_new_fish = fish.select(&:zero?).count
  fish = fish.map { |f| f.zero? ? OLD_FISH_RESET_STATE : f - 1 } +
         Array.new(num_of_new_fish, NEW_FISH_STATE)
end

puts fish.count
