class Game
  def initialize
    @board = Board.new
    
    @player1 = Player.new("X", @board)
    @player2 = Computer.new("O", @board)
    
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
  
  def draw_board
    @board.draw_board
  end
end