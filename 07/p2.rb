#!/usr/bin/env ruby
# frozen_string_literal: true

def calc_single_crab_fuel(dist)
  dist * (1 + dist) / 2
end

def calc_fuel(crab_locs, target_loc)
  crab_locs.map { |l| calc_single_crab_fuel((l - target_loc).abs) }.sum
end

crab_locs = $stdin.gets.chomp.split(',').map(&:to_i)
puts (crab_locs.min..crab_locs.max).map { |t| calc_fuel(crab_locs, t) }.min
