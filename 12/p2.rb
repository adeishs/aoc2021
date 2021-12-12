#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

START_CAVE_NAME = 'start'
END_CAVE_NAME = 'end'

def small_cave(cave_name)
  return false if [START_CAVE_NAME, END_CAVE_NAME].member?(cave_name)

  cave_name.downcase == cave_name
end

def get_num_of_paths(paths, cave_name, small_cave_visited, visited_twice_cave)
  return 1 if cave_name == END_CAVE_NAME
  return 0 if paths[cave_name].nil?

  small_cave_visited ||= Set.new
  small_cave_visited = small_cave_visited.dup
  if small_cave(cave_name)
    if small_cave_visited.member?(cave_name)
      visited_twice_cave = cave_name
    end

    small_cave_visited.add(cave_name)
  end

  paths[cave_name].map do |curr|
    if small_cave_visited.member?(curr) && !visited_twice_cave.nil?
      0
    else
      get_num_of_paths(paths, curr, small_cave_visited, visited_twice_cave)
    end
  end.reduce(:+)
end

paths = {}
$stdin.each_line.map(&:chomp).each do |line|
  a, b = line.split('-')
  [[a, b], [b, a]].each do |src, dest|
    if dest != START_CAVE_NAME && src != END_CAVE_NAME
      paths[src] ||= Array.new
      paths[src].push(dest)
    end
  end
end

puts get_num_of_paths(paths, START_CAVE_NAME, nil, nil)
