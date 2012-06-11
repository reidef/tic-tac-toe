require './lib/player.rb'

class Computer < Player
  def initialize(token, board)
    super
    @opponent = token == "O" ? "X" : "O"
  end
  
  def move
    computers_move = winning_move
    computers_move ||= defensive_move
    computers_move ||= offensive_move
    
    @board.make_move(self, computers_move)
  end
  
  def defensive_move
    find_wins_for(@opponent)
  end
  
  def winning_move
    find_wins_for(@token)
  end
  
  def find_wins_for(player)
    wins = @board.possible_wins(player)
    unless wins.nil?
      wins.inject(nil) do |block, position|
        @board.valid_move?(position) ? position : block
      end
    else
      nil
    end
  end
  
  def offensive_move
    blocked_wins = @board.possible_wins(@opponent)
    blocked_wins = [] if blocked_wins.nil?
    possible_wins = @board.possible_wins(@token)
    possible_wins = [] if possible_wins.nil?
    available_wins = possible_wins.select do |win|
      !(blocked_wins.include?(win))
    end
    available_wins.flatten!
    available_wins = (1..9).to_a if available_wins.empty?
    available_wins.inject(nil) do |block, position|
      @board.valid_move?(position) ? position : block
    end
  end
end