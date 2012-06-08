class Board
  def initialize
    @moves = { "X" => [], "O" => [] }
  end
  
  def make_move(player, move)
    move = move.to_i
    if valid_move?(move)
      @moves[player.token] << move
    else
      false
    end
  end
  
  def valid_move?(move)
    !occupied_spaces.include?(move) && ( move > 0 && move < 10 )
  end
  
  def occupied_spaces
    @moves.inject([]) do |occupied, (player, moves)|
      occupied | moves
    end
  end
end