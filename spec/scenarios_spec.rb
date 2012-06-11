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
end