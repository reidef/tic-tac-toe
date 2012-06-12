require './lib/computer.rb'

describe Computer do
  describe "with moves of X: 5, 6 O: 9, 4" do
    before :all do
      @board = Board.new
      @board.instance_variable_set(:@moves, { "X" => [5, 6], "O" => [9, 4] } )
      @computer = Computer.new("X", @board)
    end
    
    it "computer.winning_move" do
      @computer.winning_move.should == nil
    end
  end
  
  describe "with moves of X: 5, 6, 1 O: 7, 4" do
    before :all do
      @board = Board.new
      @board.instance_variable_set(:@moves, { "X" => [5, 4, 8], "O" => [7,6] } )
      @computer = Computer.new("O", @board)
    end
    
    it "board.possible_wins" do
      @board.possible_wins("X").should == [[4,5,6],[2,5,8]]
    end
    
    it "computer.defensive_move" do
      @computer.defensive_move.should == 2
    end
  end
end