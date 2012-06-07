class Board
  def initialize
    @moves = {}
  end
  
  def make_move(player, move)
    move = move.to_i
    if valid_move?(move)
      @moves[move] = player
    else
      false
    end
  end
  
  def valid_move?(move)
    !@moves.keys.include?(move) && ( move > 0 && move < 10 )
  end
end