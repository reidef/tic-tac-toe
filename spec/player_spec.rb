require './lib/player.rb'

describe Player do
  let(:board) { double("Board") }
  let(:player) { Player.new("X", board) }
  
  describe "#new" do
    it "sets the token" do
      player.token.should == "X"
    end
  end
  
  describe ".move" do
    it "gets a position from the user and passes it to the board" do
      player.should_receive(:gets).and_return("1\n")
      board.should_receive(:make_move).with(player, "1").and_return(true)
      player.move
    end
  end
end