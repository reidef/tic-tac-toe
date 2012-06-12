#!/usr/bin/env ruby

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

winner = []

100.times do
  game = Game.new(0)

  until game.winner do
    game.draw_board
    game.take_turn
  end
  
  game.draw_board
  winner << game.winner
  
  break if game.winner != "Draw!"
end

puts winner.length