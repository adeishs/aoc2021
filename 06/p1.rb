#!/usr/bin/env ruby
# frozen_string_literal: true

NEW_FISH_STATE = 8

fish = $stdin.gets.chomp.split(',').map(&:to_i)

(1..80).each do |day|
  num_of_new_fish = fish.select { |f| f.zero? }.count
  fish = fish.map { |f| f == 0 ? 6 : f - 1 } + Array.new(num_of_new_fish, NEW_FISH_STATE)
end

puts fish.count
