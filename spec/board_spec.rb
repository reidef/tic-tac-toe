require './lib/board.rb'

describe Board do
  let(:board) { Board.new }
  let(:player1) { double("Player", token: "X") }
  let(:player2) { double("Player", token: "O") }
  
  describe "#new" do
    it "has no moves" do
      board.instance_variable_get(:@moves).should == { "X" => [], "O" => [] }
    end
  end
  
  describe ".make_move" do
    context "when the move is valid" do
      before :each do
        board.should_receive(:valid_move?).with(1).and_return(true)
      end
      
      it "adds a move to the list of moves" do
        board.make_move(player1, "1")
        board.instance_variable_get(:@moves).should == { "X" => [1], "O" => [] }
      end
    end
    
    context "with an invalid move" do
      before :each do
        board.should_receive(:valid_move?).with(1).and_return(false)
      end
      
      it "returns false" do
        board.make_move(player1, "1").should == false
      end
      
      it "doesn't record it" do
        board.make_move(player1, "1")
        board.instance_variable_get(:@moves).should == { "X" => [], "O" => [] }
      end
    end
  end
  
  describe ".valid_move?" do
    before :each do      
      board.instance_variable_set(:@moves, { "X" => [1], "O" => [5] } )
    end
    
    it "is true if the space is open" do
      board.valid_move?(3).should == true
    end
    
    it "is false if the space is already occupied" do
      board.valid_move?(5).should == false
    end
    
    it "is false if the space is not on the board" do
      board.valid_move?(-3).should == false
      board.valid_move?(20).should == false
    end
  end
  
  describe ".occupied_spaces" do
    it "is empty with no moves" do
      board.occupied_spaces.should == []
    end
    
    it "contains all occupied spaces" do
      board.instance_variable_set(:@moves, { "X" => [1], "O" => [5] } )
      board.occupied_spaces.should == [1, 5]
    end
  end
end