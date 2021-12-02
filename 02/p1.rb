#!/usr/bin/env ruby
# frozen_string_literal: true

POS_D = {
  'forward' => 1 + 0i,
  'down' => 0 + 1i,
  'up' => 0 - 1i
}.freeze

pos = 0 + 0i
$stdin.each_line
      .map { |line| line.chomp.split(' ', 2) }
      .map { |action, val_s| [action, val_s.to_i] }
      .each do |action, val|
  pos += POS_D[action] * val
end

puts pos.real.abs * pos.imag.abs
