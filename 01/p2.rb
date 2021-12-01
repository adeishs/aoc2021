#!/usr/bin/env ruby
# frozen_string_literal: true

nums = $stdin.each_line.map(&:to_i)
num_of_incs = 0
nums.each_with_index do |_num, i|
  next if i.zero?
  break if i >= nums.size - 2

  curr_sum = nums[i..i + 2].sum
  prev_sum = nums[i - 1..i + 1].sum

  num_of_incs += 1 if curr_sum > prev_sum
end

puts num_of_incs
