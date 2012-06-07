require './lib/board.rb'

describe Board do
  let(:board) { Board.new }
  let(:player) { double("Player") }
  describe "#new" do
    it "has no moves" do
      board.instance_variable_get(:@moves).should == {}
    end
  end
  
  describe ".make_move" do
    context "when the move is valid" do
      before :each do
        board.should_receive(:valid_move?).with(1).and_return(true)
      end
      
      it "adds a move to the list of moves" do
        board.make_move(player, "1")
        board.instance_variable_get(:@moves).should == { 1 => player }
      end
    end
    
    context "with an invalid move" do
      before :each do
        board.should_receive(:valid_move?).with(1).and_return(false)
      end
      
      it "returns false" do
        board.make_move(player, "1").should == false
      end
      
      it "doesn't record it" do
        board.make_move(player, "1")
        board.instance_variable_get(:@moves).should == { }
      end
    end
  end
  
  describe ".valid_move?" do
    before :each do      
      board.instance_variable_set(:@moves, { 1 => player, 5 => player})
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
end