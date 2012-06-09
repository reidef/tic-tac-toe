class Game
  def initialize
    @board = Board.new
    
    @player1 = Player.new("X")
    @player2 = Player.new("O")
    
    @turn = 0
  end
  
  def take_turn
    @turn += 1
    if (@turn % 2) == 1
      @player1.move
    else
      @player2.move
    end
  end
  
  def winner
    @board.winner
  end
end