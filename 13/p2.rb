#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_input
  fold_section = false
  dot = {}
  folds = []
  $stdin.each_line do |line|
    line.chomp!

    if line == ''
      fold_section = true
      next
    end

    if fold_section
      axis, val = line.gsub('fold along ', '').split('=')
      folds.push([axis, val.to_i])
    else
      x, y = line.split(',').map(&:to_i)
      dot[x] ||= {}
      dot[x][y] = true
    end
  end
  [dot, folds]
end

dot, folds = parse_input
last_fold = {}
folds.each do |axis, val|
  last_fold[axis] = val
  if axis == 'x'
    dot.keys.select { |x| x > val }.each do |x|
      dot[x].each_key do |y|
        new_x = 2 * val - x
        dot[new_x] ||= {}
        dot[new_x][y] = true
        dot[x].delete(y)
      end
    end
  else
    dot.each_key do |x|
      dot[x].keys.select { |y| y > val }.each do |y|
        dot[x][2 * val - y] = true
        dot[x].delete(y)
      end
    end
  end
end

dots = Array.new(last_fold['y']) { Array.new(last_fold['x'], '.') }
dot.each_key { |x| dot[x].each_key { |y| dots[y][x] = '#' } }

puts dots.map { |ds| ds.join('') }.join("\n")
