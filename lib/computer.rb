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
    computers_move ||= any_move
    
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
    wins.empty? ? nil : choose_move_from(wins)
  end
  
  def offensive_move
    blocked_wins = @board.possible_wins(@opponent)
    possible_wins = @board.possible_wins(@token)
    
    return nil if blocked_wins.nil? && possible_wins.nil?
    
    blocked_wins = [] if blocked_wins.nil?
    possible_wins = [] if possible_wins.nil?
    
    available_wins = possible_wins.select do |win|
      !(blocked_wins.include?(win))
    end
    available_wins.flatten!
    choose_move_from available_wins
  end
  
  def any_move
    return 5 if @board.valid_move?(5)
    choose_move_from (1..9).to_a
  end
  
  def choose_move_from(moves)
    moves.flatten.shuffle.find do |move|
      @board.valid_move?(move)
    end
  end
end