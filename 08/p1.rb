#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.each_line.map { |line|
  line.chomp.split(' | ')[1].split(' ')
      .select { |s| [2, 3, 4, 7].include?(s.length) }
}.map(&:count).sum
