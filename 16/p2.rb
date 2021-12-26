#!/usr/bin/env ruby
# frozen_string_literal: true

OP = {
  0 => ->(a, b) { a + b },
  1 => ->(a, b) { a * b },
  2 => ->(a, b) { [a, b].min },
  3 => ->(a, b) { [a, b].max },
  5 => ->(a, b) { a > b ? 1 : 0 },
  6 => ->(a, b) { a < b ? 1 : 0 },
  7 => ->(a, b) { a == b ? 1 : 0 },
}

def parse_packet(bits)
  version = 0
  pos = 0

  read = ->(num_of_bits) {
    s = pos
    pos += num_of_bits
    (bits.slice(s, num_of_bits) || []).join('').to_i(2)
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

      return lit
    end

    op = OP[type_id]
    length_type_id = read.call(1)
    if length_type_id == 0
      length = read.call(15)
      length += pos
      total = parse_subpacket.call()
      while pos < length
        total = op.call(total, parse_subpacket.call())
      end
    else
      num_of_subpackets = read.call(11)
      total = parse_subpacket.call()
      (num_of_subpackets - 1).times do
        total = op.call(total, parse_subpacket.call())
      end
    end

    total
  end

  total = parse_subpacket.call()
  total
end

msg = $stdin.gets.chomp.to_i(16).to_s(2)
msg = '0' * ((4 - msg.length % 4) % 4) + msg
puts parse_packet(msg.chars.map(&:to_i))
