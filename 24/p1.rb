#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

MODEL_LEN = 14
MODEL_NUMS = [9, 8, 7, 6, 5, 4, 3, 2, 1]

def get_const_sets(insts)
  const_sets = []
  (0...MODEL_LEN).each do |m|
    ofs = 18 * m
    const_sets.push([4, 5, 15].map { |o| insts[ofs + o][2].to_i })
  end
  const_sets
end

$levels = {}
def build_deps(const_sets, i, zs)
  sols = {}
  consts = const_sets[i]

  MODEL_NUMS.each do |w|
    zs.each do |z|
      (0...consts[0]).each do |a|
        prev_z = z * consts[0] + a
        if prev_z % 26 + consts[1] == w && prev_z / consts[0] == z
          sols[prev_z] ||= []
          sols[prev_z].push([w, z])
        end

        prev_z = ((z - w - consts[2]) / 26 * consts[0] + a).round
        if prev_z % 26 + consts[1] != w &&
            prev_z / consts[0] * 26 + w + consts[2] == z
          sols[prev_z] ||= []
          sols[prev_z].push([w, z])
        end
      end
    end
  end
  $levels[i] = sols

  build_deps(const_sets, i - 1, sols.keys) if i > 0
end

def cmp_levels(a, b)
  b[0] == a[0] ? b[1] <=> a[1] : b[0] <=> a[0]
end

def solve(i, z, sol)
  return sol.join('') if i == MODEL_LEN

  $levels[i][z].sort { |a, b| cmp_levels(a, b) }.each do |l|
    w, nz = l
    ans = solve(i + 1, nz, (sol + [w]).flatten)
    return ans if ans
  end
end

consts = get_const_sets($stdin.each_line.map { |line| line.chomp.split(' ') })
zs = [0]
build_deps(consts, MODEL_LEN - 1, zs)
puts solve(0, 0, [])
