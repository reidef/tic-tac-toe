class Game
  def initialize(humans=1)
    @board = Board.new
    
    case humans
    when 0
      @player1 = Computer.new("X", @board)
      @player2 = Computer.new("O", @board)
    when 1
      @player1 = Player.new("X", @board)
      @player2 = Computer.new("O", @board)
    when 2
      @player1 = Player.new("X", @board)
      @player2 = Player.new("O", @board)
    end
    
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