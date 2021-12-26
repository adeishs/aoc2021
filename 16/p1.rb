#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_packet(bits)
  version = 0
  pos = 0

  read = ->(num_of_bits) {
    s = pos
    pos += num_of_bits
    bits.slice(s, num_of_bits).join('').to_i(2)
  }

  parse_subpacket = ->() do
    version += read.call(3)
    type_id = read.call(3)
    if type_id == 4
      finished = false
      lit = 0
      until finished
        finished = read.call(1).zero?
        lit = lit << 4 | read.call(4)
      end

      return
    end

    length_type_id = read.call(1)
    if length_type_id == 0
      length = read.call(15) + pos
      parse_subpacket.call() while pos < length
    else
      num_of_subpackets = read.call(11)
      num_of_subpackets.times { parse_subpacket.call() }
    end
  end

  parse_subpacket.call()

  version
end

msg = $stdin.gets.chomp.to_i(16).to_s(2)
msg = '0' * ((4 - msg.length % 4) % 4) + msg
puts parse_packet(msg.chars.map(&:to_i))
