#!/usr/bin/env ruby

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

game = Game.new(1)

until game.winner do
  game.draw_board
  puts "What is your move?"
  game.take_turn
end

game.draw_board
puts "Who wins? #{game.winner}"