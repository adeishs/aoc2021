#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pp'

def read_input_card
  # skip empty line
  return nil if gets.nil?

  # actually read card

  (1..5).map do |_l|
    $stdin.gets.strip.split(/ +/)
          .map { |x| { num: x.to_i, marked: false } }
  end
end

def card_winning(card)
  col_wins = (0...card[0].count).map { |_| true }
  (0...card.count).each do |r|
    row_win = true
    (0...card[r].count).each do |c|
      played = card[r][c][:marked]
      row_win &&= played
      col_wins[c] &&= played
    end

    # horizontal win?
    return true if row_win
  end

  # vertical win?
  return true if col_wins.reduce { |m, p| m || p }

  false
end

def play_card(card, num)
  unmarked_sum = 0
  (0...card.count).each do |r|
    (0...card[r].count).each do |c|
      card[r][c][:marked] = true if card[r][c][:num] == num

      unmarked_sum += card[r][c][:num] unless card[r][c][:marked]
    end
  end

  return { win: true, unmarked_sum: unmarked_sum } if card_winning(card)

  { win: false }
end

draw_nums = gets.chomp.split(',').map(&:to_i)
played_num = draw_nums.map { |n| [n, false] }.to_h

cards = []
loop do
  card = read_input_card
  break if card.nil?

  cards << card
end

draw_nums.each do |num|
  win = false
  played_num[num] = true
  unmarked_sum = -1
  cards.each do |card|
    play_result = play_card(card, num)
    win ||= play_result[:win]
    if win
      unmarked_sum = play_result[:unmarked_sum]
      break
    end
  end

  if win
    puts num * unmarked_sum
    exit
  end
end
