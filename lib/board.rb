class Board
  WINS = [[1,2,3],
          [4,5,6],
          [7,8,9],
          [1,4,7],
          [2,5,8],
          [3,6,9],
          [1,5,9],
          [3,5,7]]
  
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
  
  def winner
    over = occupied_spaces.length == 9 ? "Draw!" : false
    ["X", "O"].inject(over) do |winner, player|
      player_wins?(player) ? player : winner
    end
  end
  
  def player_wins?(player)
    !WINS.select do |win|
      win & @moves[player] == win
    end.empty?
  end
  
  def possible_wins(player)
    WINS.find do |win|
      (win & @moves[player]).length > 1
    end
  end
  
  def available_wins(player)
    WINS.select do |win|
      !(win & @moves[player]).empty?
    end
  end
  
  def draw_board
    system('clear')
    ["X", "O"].each do |player|
      puts "#{player} moves: #{@moves[player].join(', ')}"
    end
  end
end