class Player
  attr_reader :token
  def initialize(token, board)
    @token = token
    @board = board
  end
  
  def move
    players_move = gets.chomp
    @board.make_move(self, players_move)
  end
end