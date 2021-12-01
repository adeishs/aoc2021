#!/usr/bin/env ruby
# frozen_string_literal: true

nums = $stdin.each_line.map(&:to_i)
num_of_incs = 0
nums.each_with_index do |num, i|
  next if i == 0

  num_of_incs +=1 if num > nums[i - 1]
end

puts num_of_incs
