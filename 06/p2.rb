#!/usr/bin/env ruby
# frozen_string_literal: true

NEW_FISH_STATE = 8
OLD_FISH_RESET_STATE = 6

fish = $stdin.gets.chomp.split(',').map(&:to_i)
fish_counts = (0..NEW_FISH_STATE).map { |i| fish.count(i) }

256.times do
  fish_counts.rotate!
  fish_counts[OLD_FISH_RESET_STATE] += fish_counts[NEW_FISH_STATE]
end

puts fish_counts.sum
