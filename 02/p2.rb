#!/usr/bin/env ruby
# frozen_string_literal: true

AIM_F = {
  'down' => 1,
  'up' => -1
}.freeze

pos = 0 + 0i
aim = 0
$stdin.each_line
      .map { |line| line.chomp.split(' ', 2) }
      .map { |action, val_s| [action, val_s.to_i] }
      .each do |action, val|
  case action
  when 'forward'
    pos = Complex(pos.real + val, pos.imag + (aim * val))
  else
    aim += AIM_F[action] * val
  end
end

puts pos.real.abs * pos.imag.abs
