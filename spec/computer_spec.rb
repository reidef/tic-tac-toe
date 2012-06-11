require './lib/computer.rb'

describe Computer do
  let(:board) { double("Board") }
  let(:computer) { Computer.new("O", board) }
  
  describe "#new" do
    it "sets the token" do
      computer.token.should == "O"
    end
    
    it "sets the opponent" do
      computer.instance_variable_get(:@opponent).should == "X"
    end
  end
  
  describe ".defensive_move" do
    it "returns the defensive move" do
      computer.should_receive(:find_wins_for).with("X").and_return(3)
      computer.defensive_move.should == 3
    end
    
    it "returns nil if there is no defensive move" do
      computer.should_receive(:find_wins_for).with("X").and_return(nil)
      computer.defensive_move.should == nil
    end
  end
  
  describe ".winning_move" do
    it "returns the winning move" do
      computer.should_receive(:find_wins_for).with("O").and_return(3)
      computer.winning_move.should == 3
    end
    
    it "returns nil if there is no winning move" do
      computer.should_receive(:find_wins_for).with("O").and_return(nil)
      computer.winning_move.should == nil
    end
  end
  
  describe ".find_wins_for" do
    it "returns the last position to complete the triplet" do
      board.should_receive(:possible_wins).with("X").and_return([3,5,7])
      
      board.stub(:valid_move?).and_return(false)
      board.should_receive(:valid_move?).with(3).and_return(true)
      
      computer.defensive_move.should == 3
    end
    
    it "returns nil if no possible wins" do
      board.should_receive(:possible_wins).with("X").and_return(nil)
      computer.defensive_move.should == nil
    end
  end
  
  describe ".offensive_move" do
    it "returns a move that completes a win" do
      board.should_receive(:possible_wins).with("O").and_return([[1,2,3],[3,5,7]])
      board.should_receive(:possible_wins).with("X").and_return([[3,5,7]])
      
      board.stub(:valid_move?).and_return(false)
      board.should_receive(:valid_move?).with(2).and_return(true)
      
      computer.offensive_move.should == 2
    end
    
    it "returns nil if no possible wins" do
      board.should_receive(:possible_wins).with("O").and_return(nil)
      board.should_receive(:possible_wins).with("X").and_return(nil)
      
      computer.offensive_move.should == nil
    end
  end
  
  describe ".any_move" do
    it "returns any available space on the board" do
      board.stub(:valid_move?).and_return(false)
      board.should_receive(:valid_move?).with(2).and_return(true)
      
      computer.any_move.should == 2
    end
    
    
      it "returns 5 if it is available" do
        board.should_receive(:valid_move?).with(5).and_return(true)
        board.stub(:valid_move?).and_return(true)

        computer.any_move.should == 5
      end
  end
end