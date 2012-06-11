require './lib/computer.rb'

describe Computer do
  let(:board) { double("Board") }
  let(:computer) { Computer.new("O", board) }
  
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
      board.should_receive(:valid_move?).with(3).and_return(true)
      board.should_receive(:valid_move?).with(5).and_return(false)
      board.should_receive(:valid_move?).with(7).and_return(false)
      
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
      
      board.should_receive(:valid_move?).with(1).and_return(false)
      board.should_receive(:valid_move?).with(2).and_return(true)
      board.should_receive(:valid_move?).with(3).and_return(false)
      
      computer.offensive_move.should == 2
    end
    
    it "returns a randomly selected position if no possible wins" do
      board.should_receive(:possible_wins).with("O").and_return([])
      board.should_receive(:possible_wins).with("X").and_return([])
      
      board.should_receive(:valid_move?).at_least(:once).and_return(false)
      board.should_receive(:valid_move?).with(2).and_return(true)
      
      computer.offensive_move.should == 2
    end
  end
end