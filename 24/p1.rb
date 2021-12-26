#!/usr/bin/env ruby
# frozen_string_literal: true

# adapted from https://topaz.github.io/paste/#XQAAAQCaBAAAAAAAAAA0m0pnuFI8c/fBNAn6x25rti77on4e8DYCelyI4Xj/SWO86l3MhYKSt/IwY1X8XDsPi6oUd359E/fP3WUCy+Hd0NBX3ScDH1UMDMoIn89DqtRJAkuU26H+bJQMhuQJZGvHfbRq+cNenkcVuZMyoJg2X38kr/tdzPWRs0R3nEQAYf3r0cXmSlac2aJH0P2sl7z4weDgKeKkKfE5swiQJ2MN12HwuoRR3LBTiJQjtT73JpWF+KtQBulka0/rhUSDOrztKM4biu1JoxqydIgyDfWupEKKtAiW75B1XW73P7TSQe8BI9O2T12ql8E/CBnsomkNwZLvIqQuyxA8lRBFyEb7T2Ofx8p8uaMPHbMv786Ho5P2KtCBwYdoX3z3fIV+cETYydTzjakKrUdUMq7dRV/kbM91elWwnwaxWByBhJS7jtOshbq8mO2W3BfCQ48WxEmwVrceIMSV2txALQlDxsy1lduebYKTzWCNl58cRdbnvICOxfoV9eofWAd6YP8WsL0eQUXcgzd8K1OW7qe67FH89TwqknLQ8KvTA3WKR1z4kubNHFXrvJLyFPO4Xqk5QhtviCMkBIiUic3Fvme1CyUV5V9g4XGkZpp95hCiTZFAtqVUvWvQARQNtGBuWv0mw9NB7qM940S7lQeCGHE95fH1UtwHYFdNrEuyPVdRYw6oCBD9+eh6PL+vkkN3dz3Axp2EUdlP/qwVQQ==

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

def build_deps(const_sets, i, zs, levels)
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
  levels[i] = sols

  build_deps(const_sets, i - 1, sols.keys, levels) if i > 0
end

def cmp_levels(a, b)
  b[0] == a[0] ? b[1] <=> a[1] : b[0] <=> a[0]
end

def solve(i, z, sol, levels)
  return sol.join('') if i == MODEL_LEN

  levels[i][z].sort { |a, b| cmp_levels(a, b) }.each do |l|
    w, nz = l
    ans = solve(i + 1, nz, sol + [w], levels)
    return ans if ans
  end
end

consts = get_const_sets($stdin.each_line.map { |line| line.chomp.split(' ') })
zs = [0]
levels = {}
build_deps(consts, MODEL_LEN - 1, zs, levels)
puts solve(0, 0, [], levels)
