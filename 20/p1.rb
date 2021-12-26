#!/usr/bin/env ruby
# frozen_string_literal: true

DS = (-1..1)

def ch_to_pxl(ch)
  ch == '#' ? 1 : 0
end

def parse_map(input_lines)
  algo = input_lines.shift.chars.map { |c| ch_to_pxl(c) }

  input_lines.shift

  pixels = []
  (0...input_lines.count).each do |y|
    pixels[y] = []
    (0...input_lines[y].length).each do |x|
      pixels[y][x] = input_lines[y][x] == '#' ? 1 : 0
    end
  end
  [algo, pixels]
end

algo, pixels = parse_map($stdin.each_line.map(&:chomp))

out_pixel = 0
count = 0
2.times do
  count = 0
  output_pixels = []
  (-1..pixels.count).each do |y|
    output_pixels[y + 1] ||= []
    (-1..pixels[0].count).each do |x|
      b = ''
      DS.each do |dy|
        ny = y + dy
        unless ny.between?(0, pixels.count - 1)
          b += out_pixel.to_s * DS.to_a.count
          next
        end
        DS.each do |dx|
          nx = x + dx
          unless nx.between?(0, pixels[0].count - 1)
            b += out_pixel.to_s
            next
          end
          b += pixels[ny][nx].to_s
        end
      end
      pixel = algo[b.to_i(2)]
      count += pixel
      output_pixels[y + 1][x + 1] = pixel
    end
  end
  out_pixel = algo[(out_pixel.to_s * 9).to_i(2)]
  pixels = output_pixels
end

puts count
